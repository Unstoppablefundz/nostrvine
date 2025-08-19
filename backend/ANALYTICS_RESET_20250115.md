# Analytics Reset - January 15, 2025

## Problem
The analytics service was showing 20 old videos that no longer exist in the relay. This was because:
1. Analytics data is stored in Cloudflare Analytics Engine dataset `nostrvine_video_views`
2. Analytics Engine data cannot be directly deleted - it has retention policies
3. Old video view data was persisting indefinitely

## Solution Applied
Created a new Analytics Engine dataset with a timestamp to start fresh:

### 1. Updated `wrangler.jsonc`
Changed the VIDEO_ANALYTICS binding from:
```json
"dataset": "nostrvine_video_views"
```
To:
```json
"dataset": "nostrvine_video_views_20250115"
```

### 2. Updated SQL Queries
Modified all Analytics Engine queries in these files to use the new dataset:
- `src/services/analytics-engine.ts`
- `src/services/analytics-engine-production.ts`
- `src/services/trending-analytics-engine.ts`

### 3. Deployed Changes
```bash
wrangler deploy
```

## Result
- Fresh analytics dataset with no stale data
- Only videos viewed after deployment will appear in trending
- No more ghost videos from deleted content

## Future Considerations
For production, consider:
1. Adding date filters to queries (e.g., only show videos viewed in last 30 days)
2. Implementing a proper data retention policy
3. Regular cleanup of old analytics data

## Scripts Created
- `/scripts/reset-analytics-engine.sh` - Interactive script for different reset options
- `/scripts/delete-analytics-dataset.sh` - Documentation for dataset deletion (not executable)
- `/flush-analytics-kv.sh` - Clears the KV cache (not the actual analytics data)

## Next Steps
1. Monitor the trending endpoint to ensure it shows only recent videos
2. New video views will populate the fresh dataset
3. Consider implementing automatic filtering of old data in queries