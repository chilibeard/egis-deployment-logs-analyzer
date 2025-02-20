# Use $PSScriptRoot if available (script location), else fallback to current location
$scriptRoot = $PSScriptRoot
if (-not $scriptRoot) { $scriptRoot = Get-Location }

# Get hostname for naming the output folder
$hostName = $env:COMPUTERNAME
$BaseOutputFolder = Join-Path -Path $scriptRoot -ChildPath $hostName

# Create the base output folder if it doesn't exist
if (!(Test-Path $BaseOutputFolder)) {
    New-Item -ItemType Directory -Path $BaseOutputFolder | Out-Null
}

Write-Output "Starting log collection..."

# Example: Run diagnostic tool and collect logs
# Uncomment and customize these steps as needed:
# $StandardDiagZip = Join-Path -Path $BaseOutputFolder -ChildPath "MDMDiagReport.zip"
# $DiagCmd = "mdmdiagnosticstool.exe -area 'DeviceEnrollment;DeviceProvisioning;Autopilot' -zip `"$StandardDiagZip`""
# Write-Output "Running MDMDiagnosticTool..."
# Invoke-Expression $DiagCmd
# Start-Sleep -Seconds 30
# Write-Output "Extracting diagnostic report..."
# Expand-Archive -Path $StandardDiagZip -DestinationPath (Join-Path $BaseOutputFolder "StandardDiagnostics") -Force
# Remove-Item $StandardDiagZip -Force

Write-Output "Log collection complete." 