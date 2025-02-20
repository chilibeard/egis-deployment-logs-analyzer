# Processing Pipeline Design for Deployment Logs

This document outlines the end-to-end processing pipeline for log file ingestion, parsing, and storage in the Supabase database.

## Overview
The pipeline processes logs received from the Supabase Storage bucket. The backend (NestJS running as Vercel Serverless Functions) will handle log ingestion, parsing, and database insertion.

## Pipeline Stages

### 1. Log Ingestion
- **Source:** Files uploaded to the Supabase Storage bucket (e.g., "deployment-logs").
- **Approach:**  
  - Monitor the storage bucket for new uploads (using Supabase Storage triggers or scheduled checks).
  - Optionally, accept direct uploads via a Vercel API endpoint.

### 2. Queue Assignment (Priority-Based Processing)
Logs are categorized into priority queues for optimized processing:

#### High Priority Queue
- **Logs:** Critical installation logs, Windows Event logs with errors, and immediate device enrollment failures.
- **Processing:** Immediate parsing and status update.
- **Notifications:** Real-time alerts pushed to the frontend.

#### Medium Priority Queue
- **Logs:** Routine configuration logs and standard Egis logs.
- **Processing:** Batch processing with moderate delay.
- **Notes:** Monitor for any warning-level issues.

#### Low Priority Queue
- **Logs:** Diagnostic reports and informational logs.
- **Processing:** Process during low-load periods.
- **Notes:** Archive for historical analysis and deferred processing.

### 3. Parsing and Normalization
- **Parsing Engine:**  
  Use the strategies outlined in `LOG_PARSING_STRATEGIES.md`.
- **Output:**  
  Normalized JSON records for insertion into database tables such as `log_entries`, `installation_logs`, etc.
- **Error Handling:**  
  Log any parsing errors or exceptions into the `error_tracking` table with detailed context.

### 4. Data Storage and Status Update
- **Database:**  
  Parsed data is stored in the Supabase PostgreSQL database based on our existing schema (`DATABASE_SCHEMA.md`).
- **Status Updates:**  
  Use triggers and functions (as defined in our schema) to update deployment status in real-time.

### 5. Monitoring and Alerting
- **Real-time Subscriptions:**  
  Utilize Supabase Realtime for pushing updates to the frontend dashboard.
- **Error Monitoring:**  
  Log errors and exceptions for further analysis.
- **Performance Metrics:**  
  Track processing times and queue lengths to identify potential bottlenecks.

## Future Considerations
- **Scalability:**  
  Introduce dynamic scaling for processing queues as file volume increases.
- **Retry Mechanisms:**  
  Implement robust retry mechanisms for failed parsing attempts.
- **Detailed Logging and Auditing:**  
  Maintain an audit trail for each processing step to support troubleshooting and performance tuning. 