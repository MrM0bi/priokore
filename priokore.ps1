function isadmin{
    # Returns true/false
    ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
}



If (-NOT (isadmin)){
  # Relaunch as an elevated process:
  Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
} Else {
    $process = Get-Process audiodg
    $process.ProcessorAffinity = 4
    $process.PriorityClass = 'High'
}