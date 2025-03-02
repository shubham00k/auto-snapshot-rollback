Auto Snapshot & Rollback for Cloud Instances

This script automates the process of creating snapshots for cloud instances and rolling back to a previous state when needed. It helps prevent data loss and provides a quick recovery option in case of system failures or misconfigurations.
Features

    Automated snapshots of cloud instances.
    Rollback mechanism to restore an instance to a previous snapshot if something goes wrong.
    Works with AWS, Azure, and GCP (tested only on AWS).
    Generates logs for tracking actions and can send notifications if configured.

How It Works

    The script runs and checks for the target instance(s).
    It creates a new snapshot of the instance’s disk(s).
    If rollback is triggered, it finds the latest snapshot and reverts the instance to that state.
    Logs are generated for tracking every action performed.

Requirements

    AWS CLI (configured with necessary permissions)
    Azure CLI (if using Azure)
    gcloud CLI (if using GCP)
    Basic knowledge of shell scripting and cloud storage

Usage

    Clone the repository:

git clone https://github.com/shubham00k/auto-snapshot-rollback.git
cd auto-snapshot-rollback

Make the script executable:

chmod +x snapshot_script.sh

Run the script:

    ./snapshot_script.sh

Rollback Example

If something goes wrong with an instance, the rollback process can restore the previous snapshot:

./snapshot_script.sh --rollback

Troubleshooting

    If you get permission errors, make sure your cloud credentials have snapshot creation and deletion permissions.
    If rollback is not working, check if there’s a valid snapshot available before running the rollback command.
    If the instance is not found, ensure the correct instance ID is used in the script.

License

This project is open-source and available under the MIT License.
