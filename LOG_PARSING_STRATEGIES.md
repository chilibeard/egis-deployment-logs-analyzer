# Log Parsing Strategies for Egis Deployment Logs

This document outlines the parsing strategies for each log file type collected during Autopilot and Intune deployments, as referenced in @EG-B24XLYMTV1D9.

## 1. Diagnostic Logs (MDM Diagnostic Reports)
- **Format:** Typically a ZIP archive containing multiple files.
- **Extraction:** Decompress the archive.
- **Parsing:** Search for key indicators, errors, and enrollment statuses using regex and predefined patterns.
- **Notes:** Focus on critical timestamps, status codes, and error indicators.

## 2. Egis Logs
- **Format:** Plain text files.
- **Parsing:** Process each line and match known patterns including error keywords, transaction IDs, and timestamps.
- **Notes:** Leverage regex to extract useful metadata (log levels, dates, etc.).

## 3. Intune Management Extension Logs
- **Format:** Plain text logs.
- **Parsing:** Process the file line-by-line to extract log levels (INFO, DEBUG, ERROR) and corresponding messages.
- **Notes:** Map the log levels to specific actions in our deployment status.

## 4. Windows Event Logs (.evtx)
- **Format:** Binary event logs.
- **Parsing:** Utilize a conversion tool or library (e.g., an `evtx` parser) to convert logs into XML/JSON for easier processing.
- **Notes:** Extract security-relevant events and error details for critical analysis.

## 5. Installation and Configuration Logs
- **Format:** Can be either plain text or JSON.
- **Parsing:**
  - For JSON files, parse directly and validate against an expected schema.
  - For plain text, use regex to extract status updates, error messages, and installation timings.
- **Notes:** Segregate success messages from errors and track installation milestones.

## General Parsing Workflow
1. **Extraction:**  
   Decompress archives (if applicable) and normalize file formats.
2. **Normalization:**  
   Convert logs into a structured JSON format for easier ingestion into our database.
3. **Error Handling:**  
   Capture parsing errors and unexpected formats. Log these in the `error_tracking` table.
4. **Integration:**  
   Parsing functions will be integrated into the backend API (deployed via Vercel) to process logs in real-time.

## Future Enhancements
- Refine regex patterns and update parsing logic as more deployment log samples become available.
- Add support for additional log types based on future requirements. 