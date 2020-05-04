#######################Tim Harris#######################
#######################04/03/2014#######################
##########################V1.0##########################
######################ECC IaaS DC Team##################
########################################################

$DAServer1 = "HARSNS01.essexcc.local"
$DAServer2 = "CHESNS34.essexcc.local"
$DAServer3 = "CHESNS37.essexcc.local"

$DA1 = Get-RemoteAccessConnectionStatisticsSummary -ComputerName harsns01.essexcc.local
$DA2 = Get-RemoteAccessConnectionStatisticsSummary -ComputerName chesns34.essexcc.local
$DA3 = Get-RemoteAccessConnectionStatisticsSummary -ComputerName chesns37.essexcc.local

$DA1=$DA1 | Select-Object -ExpandProperty TotalDAConnections
$DA2=$DA2 | Select-Object -ExpandProperty TotalDAConnections
$DA3=$DA3 | Select-Object -ExpandProperty TotalDAConnections

Import-Module "D:\PowershellDAHTMLReport\OrchestratorServiceModule.psm1"

$ServiceURL = "http://chevmg76:81/Orchestrator2012/Orchestrator.svc/"
$RunbookGUID = "f08d7ac6-a378-47b7-82ff-f2093e684789"
$runbook = Get-OrchestratorRunbook -ServiceUrl $ServiceURL -RunbookId $RunbookGUID
$parmGUID = "c726a644-8659-4b33-8e23-aa0d03658354"
$parameters = @{"6fb28a3a-df8d-4e18-b636-197da33b1d25"=$DAServer1;"b8e7fb46-88b2-4f67-9955-9d8001be0119"=$DA1;"2947bbe5-8ac0-4b03-b1de-f9df51909f1c"=$DAServer2;"f5202b99-0786-47f7-b4ed-83b517a52c84"=$DA2;"2f15a304-df96-4ea9-be51-d35439e3809e"=$DAServer3;"4b98ce24-ea80-4daf-b362-444fdf60d619"=$DA3}
Start-OrchestratorRunbook -Runbook $runbook -Parameters $parameters



exit



