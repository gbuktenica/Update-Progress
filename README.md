# Update-Progress
<#  
.SYNOPSIS  
    Writes the progress of the script to the screen. 

.DESCRIPTION
    This function is useful for linear scripts that are frequently updated. After each section of code simply call the function again to move the progress bar along.

.PARAMETER FirstRun
    When switch present sents up the Write-Progress for first use.

.PARAMETER LastRun
    When switchd present sents the Write-Progress to complete.

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
    http://blog.buktenica.com               
#> 
