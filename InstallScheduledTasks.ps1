cd C:\APPS\Install\group-tax-longview\admin\install
#Call variables from Vars.ps1
. .\Vars.ps1

#Scheduled task to start Longview at startup

$action = New-ScheduledTaskAction -Execute "$WORKDIR\admin\LvStartAll.bat"
$trigger = New-ScheduledTaskTrigger -AtStartup
$User = "SYSTEM"
$Principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -RunLevel Highest
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Longview startup" -Principal $Principal -Description "Task to run $SERVERNAME at startup"

Write-Host "Scheduled task to start $SERVERNAME at startup successfully created"
pause

#Scheduled task to start Longview daily backup at 1:10 AM

$action = New-ScheduledTaskAction -Execute "$WORKDIR\admin\LvDaily.bat"
$StartTime = (Get-date "01:10 AM")
$trigger = New-ScheduledTaskTrigger -Daily -At $StartTime
$User = "SYSTEM"
$Principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -RunLevel Highest
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Longview Daily" -Principal $Principal -Description "Task to run Longview Daily Backup at 1:10 AM every day"

Write-Host "Scheduled task to run Longview Daily Backup at 1:10 AM every day"
pause