	###########################################################################################################################
	############################################### Configure Network for NAC  ################################################
	###########################################################################################################################
	
	
	$LogPath = "C:\ProgramData\Egis\Logs\Install_ConfigureNetworkForNAC_1.0.log"
	$WiredAdapters = Get-NetAdapter | Where Name -like "*Ethernet*" | Select-Object -Expand Name
	$XMLContent = '<?xml version="1.0"?>
<LANProfile xmlns="http://www.microsoft.com/networking/LAN/profile/v1">
	<MSM>
		<security>
			<OneXEnforced>false</OneXEnforced>
			<OneXEnabled>true</OneXEnabled>
			<OneX xmlns="http://www.microsoft.com/networking/OneX/v1">
				<maxAuthFailures>3</maxAuthFailures>
				<authMode>machine</authMode>
				<EAPConfig><EapHostConfig xmlns="http://www.microsoft.com/provisioning/EapHostConfig"><EapMethod><Type xmlns="http://www.microsoft.com/provisioning/EapCommon">25</Type><VendorId xmlns="http://www.microsoft.com/provisioning/EapCommon">0</VendorId><VendorType xmlns="http://www.microsoft.com/provisioning/EapCommon">0</VendorType><AuthorId xmlns="http://www.microsoft.com/provisioning/EapCommon">0</AuthorId></EapMethod><Config xmlns="http://www.microsoft.com/provisioning/EapHostConfig"><Eap xmlns="http://www.microsoft.com/provisioning/BaseEapConnectionPropertiesV1"><Type>25</Type><EapType xmlns="http://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV1"><ServerValidation><DisableUserPromptForServerValidation>false</DisableUserPromptForServerValidation><ServerNames></ServerNames></ServerValidation><FastReconnect>true</FastReconnect><InnerEapOptional>false</InnerEapOptional><Eap xmlns="http://www.microsoft.com/provisioning/BaseEapConnectionPropertiesV1"><Type>26</Type><EapType xmlns="http://www.microsoft.com/provisioning/MsChapV2ConnectionPropertiesV1"><UseWinLogonCredentials>true</UseWinLogonCredentials></EapType></Eap><EnableQuarantineChecks>false</EnableQuarantineChecks><RequireCryptoBinding>false</RequireCryptoBinding><PeapExtensions><PerformServerValidation xmlns="http://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV2">false</PerformServerValidation><AcceptServerName xmlns="http://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV2">false</AcceptServerName></PeapExtensions></EapType></Eap></Config></EapHostConfig></EAPConfig>
			</OneX>
		</security>
	</MSM>
</LANProfile>
'				
	$XMLPath = "C:\ProgramData\Egis\Scripts\ConfigureNetworkForNAC\Ethernet.xml"
	
	
	If(!(Test-Path $LogPath)){
		New-Item $LogPath -Force -ItemType File -ErrorAction SilentlyContinue | Out-Null
	}
	
	"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Configuration start." | Out-File -FilePath $LogPath -Append
	
	If(!(Test-Path $XMLPath)){
		New-Item $XMLPath -Force -ItemType File -ErrorAction SilentlyContinue | Out-Null
		"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') $XMLPath created." | Out-File -FilePath $LogPath -Append
		
		$XMLContent | Out-File -FilePath $XMLPath
		"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') XML file has been written." | Out-File -FilePath $LogPath -Append
	}
	
	"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Starting the dot3svc service.." | Out-File -FilePath $LogPath -Append
	Start-Service -Name 'dot3svc'
	
	Foreach($WiredAdapter in $WiredAdapters){
		"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Configuring $WiredAdapter adapter ..." | Out-File -FilePath $LogPath -Append
		netsh lan add profile interface=$WiredAdapter filename=$XMLPath | Out-File -FilePath $LogPath -Append
		"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') $WiredAdapter adapter configuration finished, please refer to the previous log entries to see how it went." | Out-File -FilePath $LogPath -Append
	}
	
	"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Setting the start up type of the dot3svc service to automatic." | Out-File -FilePath $LogPath -Append
	Set-Service -Name 'dot3svc' -StartupType 'Automatic'
	
	$ServiceStatus = get-service -Name "dot3svc" -ErrorAction SilentlyContinue | Select-Object -Expand Status
	If($ServiceStatus -eq "Running"){
		"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') The dot3svc service is running. Restarting ..." | Out-File -FilePath $LogPath -Append
		Stop-Service -Name "dot3svc" -Force
	}
	
	"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Restarting the dot3svc service.." | Out-File -FilePath $LogPath -Append
	Start-Service -Name 'dot3svc'
	
	"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Waiting 10s" | Out-File -FilePath $LogPath -Append
	
	Start-Sleep -s 10 
																											  	
	"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Configuration finished." | Out-File -FilePath $LogPath -Append
