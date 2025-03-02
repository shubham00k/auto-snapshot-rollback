#!/bin/bash

# AWS Auto-Snapshot & Rollback Script
# Author: Shubham
# Description: Automates EBS snapshot creation, logs snapshots, deletes old ones, and enables rollback

# Configuration
VOLUME_ID="vol-05544e1498e897ee5"  # Replace with your actual Volume ID
RETENTION_DAYS=0  # Number of days to keep snapshots
LOG_FILE="snapshot_log.txt"

# Create a snapshot
SNAPSHOT_ID=$(aws ec2 create-snapshot --volume-id $VOLUME_ID --description "Auto Snapshot" --query 'SnapshotId' --output text)
if [ $? -eq 0 ]; then
    echo "[$(date)] Snapshot created: $SNAPSHOT_ID" | tee -a $LOG_FILE
else
    echo "[$(date)] Failed to create snapshot" | tee -a $LOG_FILE
    exit 1
fi

# Delete old snapshots
OLD_SNAPSHOTS=$(aws ec2 describe-snapshots --filters "Name=volume-id,Values=$VOLUME_ID" --query "Snapshots[].{ID:SnapshotId, Time:StartTime}" --output json | jq -r --arg cutoff "$(date -u -d "-$RETENTION_DAYS days" +%Y-%m-%dT%H:%M:%SZ)" '.[] | select(.Time <= $cutoff) | .ID')

for SNAP in $OLD_SNAPSHOTS; do
    aws ec2 delete-snapshot --snapshot-id $SNAP
    echo "[$(date)] Deleted old snapshot: $SNAP" | tee -a $LOG_FILE
done

# Function to rollback to the latest snapshot
rollback() {
    LATEST_SNAPSHOT=$(aws ec2 describe-snapshots --filters "Name=volume-id,Values=$VOLUME_ID" --query "Snapshots | sort_by(@, &StartTime) | [-1].SnapshotId" --output text)
    if [ "$LATEST_SNAPSHOT" != "None" ]; then
        echo "[$(date)] Rolling back to snapshot: $LATEST_SNAPSHOT" | tee -a $LOG_FILE
        aws ec2 create-volume --snapshot-id $LATEST_SNAPSHOT --availability-zone $(aws ec2 describe-volumes --volume-ids $VOLUME_ID --query 'Volumes[0].AvailabilityZone' --output text)
    else
        echo "[$(date)] No snapshots available for rollback" | tee -a $LOG_FILE
    fi
}

# Uncomment the line below to enable rollback function execution
# rollback

