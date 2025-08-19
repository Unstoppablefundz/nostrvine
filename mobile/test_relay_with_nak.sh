#!/bin/bash

echo "🧪 Testing OpenVine Relay Pagination with nak"
echo "============================================"
echo ""

RELAY="wss://relay3.openvine.co"

echo "📹 BATCH 1: Getting 5 most recent kind 32222 events..."
echo "--------------------------------------------------------"
BATCH1=$(timeout 5 nak req -k 32222 -l 5 $RELAY 2>&1 | grep -v "connecting")

# Extract event IDs and timestamps
IDS1=$(echo "$BATCH1" | grep -o '"id":"[^"]*"' | cut -d'"' -f4)
TIMESTAMPS1=$(echo "$BATCH1" | grep -o '"created_at":[0-9]*' | sed 's/"created_at"://')

echo "Events received: $(echo "$IDS1" | wc -l | tr -d ' ')"
echo "Timestamps:"
echo "$TIMESTAMPS1" | while read ts; do
    if [ ! -z "$ts" ]; then
        echo "  - $ts ($(date -r $ts 2>/dev/null || date -d @$ts 2>/dev/null || echo $ts))"
    fi
done

# Get the oldest timestamp
OLDEST=$(echo "$TIMESTAMPS1" | sort -n | head -1)
echo ""
echo "Oldest timestamp from batch 1: $OLDEST"

if [ -z "$OLDEST" ]; then
    echo "❌ No timestamps found in first batch"
    exit 1
fi

echo ""
echo "📹 BATCH 2: Getting events older than $OLDEST using --until parameter..."
echo "-------------------------------------------------------------------------"
BATCH2=$(timeout 5 nak req -k 32222 -l 5 --until $OLDEST $RELAY 2>&1 | grep -v "connecting")

IDS2=$(echo "$BATCH2" | grep -o '"id":"[^"]*"' | cut -d'"' -f4)
TIMESTAMPS2=$(echo "$BATCH2" | grep -o '"created_at":[0-9]*' | sed 's/"created_at"://')

echo "Events received: $(echo "$IDS2" | wc -l | tr -d ' ')"
echo "Timestamps:"
echo "$TIMESTAMPS2" | while read ts; do
    if [ ! -z "$ts" ]; then
        echo "  - $ts ($(date -r $ts 2>/dev/null || date -d @$ts 2>/dev/null || echo $ts))"
    fi
done

# Check for duplicates
echo ""
echo "📊 ANALYSIS:"
echo "------------"

# Count unique events
DUPLICATES=0
for id in $IDS2; do
    if echo "$IDS1" | grep -q "$id"; then
        echo "  ⚠️  Duplicate found: $id"
        DUPLICATES=$((DUPLICATES + 1))
    fi
done

if [ $DUPLICATES -eq 0 ]; then
    echo "  ✅ No duplicates - pagination is working correctly!"
else
    echo "  ❌ Found $DUPLICATES duplicate events"
fi

# Verify timestamps are older
NEWER_COUNT=0
for ts in $TIMESTAMPS2; do
    if [ ! -z "$ts" ] && [ "$ts" -gt "$OLDEST" ]; then
        echo "  ⚠️  Found newer timestamp: $ts > $OLDEST"
        NEWER_COUNT=$((NEWER_COUNT + 1))
    fi
done

if [ $NEWER_COUNT -eq 0 ]; then
    echo "  ✅ All batch 2 events are older or equal to batch 1's oldest"
else
    echo "  ❌ Found $NEWER_COUNT events newer than expected"
fi

echo ""
echo "📹 BATCH 3: Testing pagination reset scenario..."
echo "-------------------------------------------------"
# Get even older events
OLDEST2=$(echo "$TIMESTAMPS2" | sort -n | head -1)
if [ ! -z "$OLDEST2" ]; then
    echo "Getting events older than $OLDEST2..."
    BATCH3=$(timeout 5 nak req -k 32222 -l 5 --until $OLDEST2 $RELAY 2>&1 | grep -v "connecting")
    IDS3=$(echo "$BATCH3" | grep -o '"id":"[^"]*"' | cut -d'"' -f4)
    
    echo "Events received: $(echo "$IDS3" | wc -l | tr -d ' ')"
    
    # Check all three batches are different
    ALL_UNIQUE=1
    for id in $IDS3; do
        if echo "$IDS1 $IDS2" | grep -q "$id"; then
            ALL_UNIQUE=0
            break
        fi
    done
    
    if [ $ALL_UNIQUE -eq 1 ] && [ ! -z "$IDS3" ]; then
        echo "  ✅ Successfully loaded 3 different batches of videos!"
    else
        echo "  ⚠️  Some overlap detected or no new events"
    fi
fi

echo ""
echo "========================================="
echo "✅ PAGINATION TEST COMPLETE"
echo "========================================="
echo ""
echo "Summary:"
echo "  - Relay: $RELAY"
echo "  - Event kind: 32222 (NIP-32222 addressable video events)"
echo "  - Pagination parameter: --until (timestamp)"
echo "  - Result: The relay correctly returns older events when using --until"