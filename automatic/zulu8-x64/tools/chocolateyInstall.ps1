﻿$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$urljre = 'https://cdn.azul.com/zulu/bin/zulu8.52.0.23-ca-jre8.0.282-win_x64.zip'
$urljdkfx = 'https://cdn.azul.com/zulu/bin/zulu8.50.0.53-ca-fx-jdk8.0.275-win_x64.zip'
$urljrefx = 'https://cdn.azul.com/zulu/bin/zulu8.50.0.53-ca-fx-jre8.0.275-win_x64.zip'

$checksumurljre = 'fd025254af1276dd6da4a5ac0a4372c47e3e1f11559eeed165cd858a3384f4dc'
$checksumurljdkfx = '380c647a45f092973168317455dd25fca4fb0c6bbfad77feed08048f1cadcae9'
$checksumurljrefx = '1e5c6a830d75799d9bc36dce2fcac42a1db0fde54d7ae0f5c8cdd91275113724'


Get-ChocolateyWebFile -PackageName 'zulu8-x64' -FileFullPath "$toolsDir\JRE\zulu8-x64-jre.zip" -Url $urljre -Checksum $checksumurljre -ChecksumType 'sha256'
Get-ChocolateyWebFile -PackageName 'zulu8-x64' -FileFullPath "$toolsDir\FX\JDK\zulu8-x64-jdk-fx.zip" -Url $urljdkfx -Checksum $checksumurljdkfx -ChecksumType 'sha256'
Get-ChocolateyWebFile -PackageName 'zulu8-x64' -FileFullPath "$toolsDir\FX\JRE\zulu8-x64-jre-fx.zip" -Url $urljrefx -Checksum $checksumurljrefx -ChecksumType 'sha256'

$packageArgs = @{
    packageName    = 'zulu8-x64'
    fileType       = 'msi'
    url64bit       = 'https://cdn.azul.com/zulu/bin/zulu8.52.0.23-ca-jdk8.0.282-win_x64.msi'
    checksum64     = 'bccc0740da32a450f0c3d24f288f6e6ed81220c6af46c4bb8daaf092bb1b5414'
    checksumType64 = 'sha256'
    silentArgs     = '/qn /norestart'
    validExitCodes = @(0)
    softwareName   = 'Zulu 8*'
}

Install-ChocolateyPackage @packageArgs
