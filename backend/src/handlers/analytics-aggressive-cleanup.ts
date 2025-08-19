// ABOUTME: Aggressive analytics cleanup handler - removes ALL analytics data for fresh start
// ABOUTME: Use when analytics is showing stale/deleted videos that no longer exist

import { AnalyticsEnv } from '../types/analytics';

export async function handleAggressiveAnalyticsCleanup(
  request: Request,
  env: AnalyticsEnv
): Promise<Response> {
  try {
    const authHeader = request.headers.get('Authorization');
    const expectedToken = env.CLEANUP_AUTH_TOKEN || 'default-cleanup-token';
    
    // Basic auth check for cleanup endpoint
    if (authHeader !== `Bearer ${expectedToken}`) {
      return new Response('Unauthorized', { status: 401 });
    }

    // Parse query params for options
    const url = new URL(request.url);
    const mode = url.searchParams.get('mode') || 'all'; // 'all', 'old', 'trending'
    const dryRun = url.searchParams.get('dry_run') === 'true';

    let deletedKeys: string[] = [];
    let errors: string[] = [];
    const patterns = ['views:', 'trending:', 'user:', 'hashtag:', 'creator:', 'video:', 'analytics:'];

    console.log(`Starting aggressive cleanup - mode: ${mode}, dry_run: ${dryRun}`);

    if (mode === 'all' || mode === 'views') {
      // Clean up all view tracking data
      for (const pattern of patterns) {
        try {
          const list = await env.ANALYTICS_KV.list({ prefix: pattern, limit: 1000 });
          
          for (const key of list.keys) {
            if (dryRun) {
              deletedKeys.push(key.name);
            } else {
              await env.ANALYTICS_KV.delete(key.name);
              deletedKeys.push(key.name);
            }
          }

          // Handle pagination if there are more keys
          let cursor = list.list_complete ? null : list.cursor;
          while (cursor) {
            const nextList = await env.ANALYTICS_KV.list({ prefix: pattern, cursor, limit: 1000 });
            
            for (const key of nextList.keys) {
              if (dryRun) {
                deletedKeys.push(key.name);
              } else {
                await env.ANALYTICS_KV.delete(key.name);
                deletedKeys.push(key.name);
              }
            }
            
            cursor = nextList.list_complete ? null : nextList.cursor;
          }
        } catch (error) {
          errors.push(`Failed to clean pattern ${pattern}: ${error instanceof Error ? error.message : String(error)}`);
        }
      }
    }

    if (mode === 'all' || mode === 'trending') {
      // Force clear trending cache
      if (!dryRun) {
        await env.ANALYTICS_KV.delete('trending:videos');
        await env.ANALYTICS_KV.delete('trending:viners');
        await env.ANALYTICS_KV.delete('trending:hashtags');
      }
      deletedKeys.push('trending:videos', 'trending:viners', 'trending:hashtags');
    }

    const response = {
      success: true,
      mode,
      dryRun,
      deletedCount: deletedKeys.length,
      deletedKeys: deletedKeys.slice(0, 100), // Show first 100 keys
      errors: errors.length > 0 ? errors : undefined,
      message: dryRun 
        ? `Would delete ${deletedKeys.length} analytics keys` 
        : `Successfully deleted ${deletedKeys.length} analytics keys`
    };

    return new Response(JSON.stringify(response), {
      status: 200,
      headers: { 
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      }
    });

  } catch (error) {
    console.error('Aggressive analytics cleanup error:', error);
    return new Response(
      JSON.stringify({ 
        error: 'Aggressive cleanup failed', 
        details: error instanceof Error ? error.message : String(error) 
      }),
      { 
        status: 500, 
        headers: { 
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        } 
      }
    );
  }
}