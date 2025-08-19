# Analytics Engine Dataset Setup

## Problem
The new Analytics Engine dataset `nostrvine_video_views_20250115` isn't receiving data even though:
1. The worker is deployed with the correct binding
2. Video view tracking returns success
3. SQL queries are syntactically correct

## Possible Issues

### 1. Dataset Creation
Analytics Engine datasets in Cloudflare need to be created through the dashboard first:
1. Go to Cloudflare Dashboard > Analytics > Analytics Engine
2. Create a new dataset named `nostrvine_video_views_20250115`
3. Ensure it's active

### 2. API Token Permissions
The CLOUDFLARE_API_TOKEN needs these permissions:
- Account > Analytics Engine:Read
- Account > Analytics Engine:Write

### 3. Dataset Name Format
The dataset name might need to follow specific conventions:
- No underscores with dates?
- Specific length limits?

## Quick Fix Options

### Option 1: Use Workers Analytics Engine API
Instead of SQL queries, use the native API:
```javascript
// In the worker
await env.VIDEO_ANALYTICS.writeDataPoint({
  blobs: [...],
  doubles: [...],
  indexes: [...]
});
```

### Option 2: Check Dataset Status
```bash
curl -X GET "https://api.cloudflare.com/client/v4/accounts/{account_id}/analytics_engine/datasets" \
  -H "Authorization: Bearer {api_token}"
```

### Option 3: Force Dataset Creation
Sometimes you need to create the dataset via API first:
```bash
curl -X POST "https://api.cloudflare.com/client/v4/accounts/{account_id}/analytics_engine/datasets" \
  -H "Authorization: Bearer {api_token}" \
  -H "Content-Type: application/json" \
  -d '{"name": "nostrvine_video_views_20250115"}'
```