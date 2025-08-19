// ABOUTME: Handler for trending vines (videos) endpoint - returns top performing videos
// ABOUTME: Provides data for popular content discovery in mobile app and website

import { AnalyticsEnv } from '../types/analytics';
import { TrendingAnalyticsEngineService } from '../services/trending-analytics-engine';

export async function handleTrendingVines(
  request: Request,
  env: AnalyticsEnv,
  ctx?: ExecutionContext
): Promise<Response> {
  try {
    const url = new URL(request.url);
    const limit = Math.min(parseInt(url.searchParams.get('limit') || '20'), 100);
    const window = (url.searchParams.get('window') || '24h') as '1h' | '24h' | '7d' | 'all';
    
    // Create service instance
    const trendingService = new TrendingAnalyticsEngineService(env as any, ctx || { waitUntil: () => {}, passThroughOnException: () => {} });
    
    // First try to get cached trending data for fast response
    const cachedVideos = await trendingService.getCachedTrending(window);
    
    // If we have cached data, use it
    let trendingVideos = cachedVideos;
    
    // If no cache or empty, fetch fresh data
    if (!trendingVideos || trendingVideos.length === 0) {
      trendingVideos = await trendingService.getTrendingVideos(window, limit);
      
      // Cache the results for next time if we got data
      if (trendingVideos.length > 0 && ctx) {
        ctx.waitUntil(trendingService.cacheTrendingData());
      }
    }
    
    // Transform to match expected API format
    const response = {
      vines: trendingVideos.slice(0, limit).map(video => ({
        eventId: video.videoId,
        views: video.views,
        score: video.viralScore,
        uniqueViewers: video.uniqueViewers,
        avgCompletion: video.avgCompletion,
        title: video.title,
        creatorPubkey: video.creatorPubkey,
        hashtags: video.hashtags
      })),
      algorithm: 'viral_score_v2',
      updatedAt: Date.now(),
      period: window,
      totalVines: trendingVideos.length
    };

    return new Response(JSON.stringify(response), {
      status: 200,
      headers: {
        'Content-Type': 'application/json',
        'Cache-Control': 'public, max-age=300', // 5 minute cache
        'Access-Control-Allow-Origin': '*'
      }
    });

  } catch (error) {
    console.error('Trending vines error:', error);
    return new Response(
      JSON.stringify({ 
        error: 'Failed to fetch trending vines',
        vines: [],
        updatedAt: Date.now()
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