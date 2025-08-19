#!/bin/bash

# Reset Analytics Engine Dataset
# Since we can't directly delete Analytics Engine datasets, we'll work around it

echo "🔄 OpenVine Analytics Engine Reset Strategy"
echo "==========================================="
echo ""
echo "Analytics Engine datasets cannot be directly deleted."
echo "Here are your options to fix the stale data issue:"
echo ""
echo "OPTION 1: Clear KV Cache Only (Quick fix)"
echo "  This will force trending to recalculate from Analytics Engine"
echo "  Run: ./flush-analytics-kv.sh false"
echo ""
echo "OPTION 2: Create a new dataset with timestamp"
echo "  1. Update wrangler.jsonc to use a new dataset name:"
echo "     Change: \"dataset\": \"nostrvine_video_views\""
echo "     To:     \"dataset\": \"nostrvine_video_views_v2\""
echo ""
echo "  2. Deploy the worker:"
echo "     wrangler deploy"
echo ""
echo "  3. All new analytics will go to the fresh dataset"
echo ""
echo "OPTION 3: Filter old data in queries"
echo "  Modify the Analytics Engine queries to only look at recent data"
echo "  (This is what we should do for production)"
echo ""
echo "Which option would you like to use? (1/2/3): "
read -r option

case $option in
  1)
    echo "Running KV cache flush..."
    cd "$(dirname "$0")/.."
    ./flush-analytics-kv.sh false
    ;;
  2)
    echo ""
    echo "📝 To implement Option 2:"
    echo "1. Edit wrangler.jsonc and change the analytics_engine_datasets binding:"
    echo "   Find: \"dataset\": \"nostrvine_video_views\""
    echo "   Change to: \"dataset\": \"nostrvine_video_views_$(date +%Y%m%d)\""
    echo ""
    echo "2. Update the SQL queries in these files to use the new dataset name:"
    echo "   - src/services/analytics-engine.ts"
    echo "   - src/services/analytics-engine-production.ts"
    echo "   - src/services/trending-analytics-engine.ts"
    echo ""
    echo "3. Deploy: wrangler deploy"
    ;;
  3)
    echo ""
    echo "📝 Option 3 is the best long-term solution."
    echo "I'll create a patch to filter old data..."
    ;;
  *)
    echo "Invalid option"
    exit 1
    ;;
esac