#inspired by https://github.com/galeksandrp/au-packages/tree/master/teamviewer-qs
Import-Module AU

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$releases = 'https://download.teamviewer.com/download/TeamViewerQS.exe'

function global:au_BeforeUpdate() {
    Get-RemoteFiles -Purge -FileNameBase 'TeamViewerQS'
    $Latest.Checksum = Get-RemoteChecksum $Latest.URL -Algorithm 'md5'
}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $regex   = '.exe$'
    $url     = $download_page.links | Where-Object href -match $regex | Select-Object -First 1 -expand href
    $arr = $url -split '-|.exe'
    $version = $arr[1]
    Write-Host $url
    Write-Host $version

    <#
    $versions = [ordered]@{ }

    [array]'https://download.teamviewer.com/download/TeamViewerQS.exe' + (Invoke-WebRequest -UseBasicParsing 'https://www.teamviewer.com/ru/download/old-versions.aspx').Links.href -match '/TeamViewerQS\.exe$' | ForEach-Object {
        $filename = "$env:TMP\$([guid]::NewGuid()).exe"
        Get-ChocolateyWebFile 'teamviewerqs' "$_" -FileFullPath $filename

        $version = ''
        try {
            $version = [version](Get-Item $filename).VersionInfo.FileVersion.trim()
        }
        catch {
        }
        if (!$version) {
            $version = (Get-Item $filename).VersionInfo.ProductVersionRaw
        }
        $versions[$version.major, $version.minor -join '.'] = @{URL32 = "$_"; Version = "$version" }
    }

    @{Streams = $versions }
    #>
    return @{ Version = $version; URL = $url}
}

update -ChecksumFor none -NoCheckChocoVersion -Verbose