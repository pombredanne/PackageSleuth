

<#

    .Description
    Reads nuget package data to a specific filter.
    .Example
    Read-NuGetPackageData -PackageID "GoogleChrome" -PackageVersion "55.0.2883.87"
#>
function Read-NuGetPackageData {
    param(
        $provider = "chocolatey.org",
        [Parameter(Mandatory=$true)]
        $PackageID,
        [Parameter(Mandatory=$true)]
        $PackageVersion
    )

    $urlStem = "https://$provider/api/v2/Packages()?`$filter=Id%20eq%20%27$PackageID%27%20and%20Version%20eq%20%27$PackageVersion%27"

    write-verbose $urlStem -verbose
    $url = $urlStem -f $url, $PackageID

    Invoke-RestMethod -uri $url 


}

function invoke-packagedownload { 
    param(
        [parameter(ValueFromPipeline=$true)]
        $feedItem,
        [parameter(Mandatory=$true)]
        $downloadPath
    )

    Process {
        $url = $FeedItem.content.src
        $destination = ($FeedItem.title.'#text' + "." + $FeedItem.properties.Version)
        Invoke-WebRequest -Uri $url -OutFile "$DownloadPath/$destination.zip"
    }

}
<#
    .Description
    Obtain versions from the ChocolateyAPI

    .Example
    Read-NuGetPackageVersions -PackageID GoogleChrome

#>
function Read-NuGetPackageVersion {
    param(
        $provider = "chocolatey.org",
        $PackageID
    )

    $url = 'https://{0}/api/v2/package-versions/{1}' -f $provider, $PackageID
    Invoke-RestMethod -Uri $url 

}

