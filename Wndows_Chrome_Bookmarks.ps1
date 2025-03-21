#Ashraful Hoda, 21st March 2025

$bookmarksFile = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Bookmarks"

if (-Not (Test-Path $bookmarksFile)) {
    Write-Host "No bookmarks found :("
    exit
}

Write-Host "Found bookmarks file!"
Write-Host "Save to file? (Y/n)"
$choice = Read-Host

$urls = Get-Content $bookmarksFile | Select-String '"url":' | ForEach-Object { ($_ -split '"')[3] }

if ($choice -eq "Y") {
    Write-Host "Enter file name"
    $file = Read-Host
    $urls | Out-File $file
    Write-Host "Saved in $file"
} elseif ($choice -eq "n") {
    $urls
} else {
    Write-Host "Bruh... Just type Y or n"
    exit
}
