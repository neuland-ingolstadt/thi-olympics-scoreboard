$fileName = "logo.png"
$source = Join-Path $PSScriptRoot "assets" $fileName
$output = Join-Path $PSScriptRoot "web" "icons"

Remove-Item -Path $output -Recurse -Force

npx pwa-asset-generator $source $output --background "#FFFFFF" --padding 0 --opaque