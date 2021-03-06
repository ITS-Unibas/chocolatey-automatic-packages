﻿$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'vcredist13-x64'
  unzipLocation  = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType       = 'exe'
  url            = 'http://download.microsoft.com/download/C/C/2/CC2DF5F8-4454-44B4-802D-5EA68D086676/vcredist_x64.exe'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 1638, 3010)
  softwareName   = 'Microsoft Visual C++ 2013 Redistributable (x64)*'
  checksum       = '8588eb697eb2049344e6206d2b66ff63104f1c55e553621ab8ecc504d6b9e9d4'
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs
