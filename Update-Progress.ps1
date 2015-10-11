Function Update-Progress
<#  
.SYNOPSIS  
    Writes the progress of the script to the screen. 

.DESCRIPTION
    This function is useful for linear scripts that are frequently updated. After each section of code simply call the function again to move the progress bar along.

.PARAMETER FirstRun
    When switch present sents up the Write-Progress for first use.

.PARAMETER LastRun
    When switch present sents the Write-Progress to complete.

.PARAMETER Activity
    String provides the text in the Write-Progress bar.

.INPUTS
    None.

.OUTPUTS
    Progress Bar. 

.NOTES  
    Author     : Glen Buktenica
	Change Log : Initial Build  20151006 
    License    : The MIT License (MIT)
                 http://opensource.org/licenses/MIT

.LINK
    http://blog.buktenica.com/update-progress          
#>  
{
Param 
(
    [Switch] $FirstRun,
    [Switch] $LastRun,
    [String] $Activity
)
    # On first run count the number times function is called.   
    If ($FirstRun)
    {
        $Global:ProgressTotal = 0
        $Global:ProgressCount = 0
        $ContentArray = Get-Content $script:MyInvocation.MyCommand.Path

        Foreach ($line in $ContentArray)
        {
            If ($line -like "*Update-Progress*")
            {
                $Global:ProgressTotal ++
            }
        }
        $Global:ProgressTotal = $ProgressTotal - 3
        $Global:Activity = $Activity
        Write-Progress -Id 1 -Activity $Global:Activity -Status "0 percent complete" -PercentComplete 0
    }
    # On last run set percentage complete to 100 percent.
    ElseIF ($LastRun)
    {
        Write-Progress -Id 1 -Activity $Global:Activity -Status "100 percent complete" -PercentComplete 100
    }
    # Else move the progress bar along.
    Else
    {
        # Calculate percentage complete rounded to whole number
        $Global:ProgressComplete = [decimal]::round($ProgressCount/$ProgressTotal*100)
        If (($ProgressComplete -gt 100) -or ($ProgressComplete -lt 0))
        {
            $Global:ProgressComplete = 0
        }
        Write-Progress -Id 1 -Activity $Global:Activity -Status "$ProgressComplete percent complete" -PercentComplete $ProgressComplete
        $Global:ProgressCount ++
    }
}
#Example code use here:
Clear-Host
Update-Progress -FirstRun -Activity "Running Script"
Write-Host
Write-Host
Write-Host
Write-Host
Write-Host
Write-Host "Short code here"
Write-Host "----------------------"
Start-Sleep -Milliseconds 500

Update-Progress
Write-Host "Short code here"
Write-Host "----------------------"
Start-Sleep -Milliseconds 500

Update-Progress
Write-Host "Short code here"
Write-Host "----------------------"
Start-Sleep -Milliseconds 500

Update-Progress
Write-Host "Longer code here"
Write-Host "----------------------"
Start-Sleep -Milliseconds 1000

Update-Progress
Update-Progress

Start-Sleep -Milliseconds 500
Write-Host "Short code here"
Write-Host "----------------------"
Update-Progress -LastRun
Start-Sleep -Milliseconds 1500
