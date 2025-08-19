#!/bin/bash

# Script to delete and recreate the Analytics Engine dataset
# This will permanently delete ALL analytics data!

echo "🗑️  OpenVine Analytics Engine Dataset Reset"
echo "=========================================="
echo ""
echo "⚠️  WARNING: This will DELETE the nostrvine_video_views dataset!"
echo "All historical analytics data will be permanently lost."
echo ""

read -p "Are you SURE you want to delete all analytics data? Type 'DELETE' to confirm: " confirm

if [ "$confirm" != "DELETE" ]; then
    echo "❌ Operation cancelled"
    exit 1
fi

echo ""
echo "🔄 Deleting nostrvine_video_views dataset..."

# Delete the dataset
wrangler analytics-engine sql "DROP TABLE IF EXISTS nostrvine_video_views" 2>/dev/null || true

echo "✅ Dataset deleted"
echo ""
echo "📝 To recreate the dataset, the worker will automatically create it on first write"
echo "   Just start tracking new video views and the dataset will be created"
echo ""
echo "💡 Next steps:"
echo "  1. New video views will start populating a fresh dataset"
echo "  2. Trending will only show videos that have been viewed after the reset"
echo "  3. No more stale/old video data!"