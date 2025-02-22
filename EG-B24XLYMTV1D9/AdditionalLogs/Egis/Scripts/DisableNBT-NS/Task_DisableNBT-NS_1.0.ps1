	###########################################################################################################################
	############################################### DisableNBT-NS  ################################################
	###########################################################################################################################
	
	
	$LogPath = "C:\ProgramData\Egis\Logs\Task_DisableNBT-NS_1.0.log"
	$regkey = "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces"
		
	If(!(Test-Path $LogPath)){
		New-Item $LogPath -Force -ItemType File -ErrorAction SilentlyContinue | Out-Null
	}
	
	"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Configuration start." | Out-File -FilePath $LogPath -Append
	
	$Items = Get-ChildItem $regkey
	Foreach($Item in $Items){
		Set-ItemProperty -Path "$regkey\$($Item.pschildname)" -Name NetbiosOptions -Value 2 
		"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Value set : $regkey\$($Item.pschildname)\NetbiosOptions = 2" | Out-File -FilePath $LogPath -Append
	}
	
	"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Waiting 10s" | Out-File -FilePath $LogPath -Append
	
	Start-Sleep -s 10 
																											  	
	"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Configuration finished." | Out-File -FilePath $LogPath -Append

