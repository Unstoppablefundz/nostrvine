// ABOUTME: Test endpoint for debugging Analytics Engine writes
// ABOUTME: Provides direct analytics testing without video tracking complexity

export async function handleTestAnalytics(
  request: Request,
  env: any
): Promise<Response> {
  try {
    const timestamp = Date.now();
    
    // Write a simple test data point
    console.log('Writing test data point to Analytics Engine...');
    
    await env.VIDEO_ANALYTICS.writeDataPoint({
      blobs: [
        'test_video_id',      // blob1
        'test_user',          // blob2
        'US',                 // blob3
        'test',               // blob4
        'view_end',           // blob5
        '2025-01-17',         // blob6
        'test_creator',       // blob7
        'test,analytics',     // blob8
        'Test Video',         // blob9
        '23'                  // blob10
      ],
      doubles: [
        1,                    // double1: view count
        6000,                 // double2: watch duration
        1,                    // double3: loop count
        1.0,                  // double4: completion rate
        6000,                 // double5: total duration
        0,                    // double6: is new view
        1,                    // double7: is completed view
        timestamp             // double8: timestamp
      ],
      indexes: ['test_video_id']
    });
    
    console.log('✅ Test data point written successfully');
    
    // Try to query immediately
    const query = `
      SELECT COUNT(*) as total 
      FROM nostrvine_video_views 
      WHERE double8 >= ${timestamp - 1000}
    `;
    
    console.log('Executing test query:', query);
    
    const response = await fetch(
      `https://api.cloudflare.com/client/v4/accounts/${env.CLOUDFLARE_ACCOUNT_ID}/analytics_engine/sql`,
      {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${env.CLOUDFLARE_API_TOKEN}`,
          'Content-Type': 'text/plain',
        },
        body: query
      }
    );
    
    const result = await response.json();
    console.log('Query result:', result);
    
    return new Response(JSON.stringify({
      success: true,
      writeTimestamp: timestamp,
      queryResult: result,
      message: 'Test data point written and queried'
    }), {
      status: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      }
    });
    
  } catch (error) {
    console.error('Test analytics error:', error);
    return new Response(JSON.stringify({
      error: 'Test failed',
      details: error instanceof Error ? error.message : String(error)
    }), {
      status: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      }
    });
  }
}