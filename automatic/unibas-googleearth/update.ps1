﻿Import-Module AU

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$releases = 'https://support.google.com/earth/answer/168344'

function global:au_BeforeUpdate() {
  Get-RemoteFiles -Purge -FileNameBase 'unibas-googleeath'
  $Latest.Checksum = Get-RemoteChecksum $Latest.URL -Algorithm 'sha256'
}
function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1`'$($Latest.URL)`'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1`'$($Latest.Checksum)`'"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $regex = '-x64.exe$'
  $url = $download_page.links | Where-Object href -match $regex | Select-Object -First 1 -expand href
  $arr = $url -split '-|.exe'
  $version = $arr[1]
  return @{ Version = $version; URL = $url }
}

update -ChecksumFor none -NoCheckChocoVersion