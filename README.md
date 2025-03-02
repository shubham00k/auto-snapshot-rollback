# Auto-Snapshot & Rollback for Cloud Instances  

This script automates the process of taking snapshots of cloud instances and rolling them back when needed. It is designed to help system administrators and DevOps engineers maintain backup copies of instances and restore them in case of failures.  

## Features  
 **Automated Snapshots** – Periodically creates snapshots of cloud instances.  
 **Rollback Functionality** – Easily revert to a previous snapshot if needed.  
 **Logging & Notifications** – Logs all snapshot and rollback operations for tracking.  
 **Multi-Cloud Compatibility** – Currently tested with AWS, but designed to support GCP and Azure with minor modifications.  

## Requirements  
- Bash shell  
- AWS CLI (Configured with access credentials)  
- Optional: GCP & Azure CLI (for future support)  

## Installation  
1. Clone the repository:  
   ```sh
   git clone https://github.com/shubham00k/auto-snapshot-rollback.git
   cd auto-snapshot-rollback
