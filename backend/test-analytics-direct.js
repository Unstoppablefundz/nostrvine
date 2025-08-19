// Test Analytics Engine directly
const ACCOUNT_ID = process.env.CLOUDFLARE_ACCOUNT_ID;
const API_TOKEN = process.env.CLOUDFLARE_API_TOKEN;

async function testAnalyticsEngine() {
  // First, let's try a simple query to see if the dataset exists
  const query = `SELECT COUNT(*) as total FROM nostrvine_video_views_20250115`;
  
  console.log('Testing Analytics Engine with query:', query);
  
  try {
    const response = await fetch(
      `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/analytics_engine/sql`,
      {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${API_TOKEN}`,
          'Content-Type': 'text/plain',
        },
        body: query
      }
    );

    const text = await response.text();
    console.log('Response status:', response.status);
    console.log('Response:', text);
    
    if (\!response.ok) {
      console.error('Query failed:', text);
    } else {
      const result = JSON.parse(text);
      console.log('Query result:', JSON.stringify(result, null, 2));
    }
  } catch (error) {
    console.error('Error:', error);
  }
}

// Check if credentials are set
if (\!ACCOUNT_ID || \!API_TOKEN) {
  console.error('Please set CLOUDFLARE_ACCOUNT_ID and CLOUDFLARE_API_TOKEN environment variables');
  console.error('You can get these from wrangler secret list');
  process.exit(1);
}

testAnalyticsEngine();
EOF < /dev/null