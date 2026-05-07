$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Master = Join-Path $Root 'keys.txt'
$Log = Join-Path $Root 'cemu_key_generator_log.txt'

"Starting Wii U Cemu key generator" | Set-Content -Path $Log -Encoding UTF8
"Root: $Root" | Add-Content -Path $Log -Encoding UTF8
"" | Add-Content -Path $Log -Encoding UTF8

if (Test-Path $Master) {
    Remove-Item $Master -Force
}

$Found = 0
$Skipped = 0

$keyFiles = Get-ChildItem -Path $Root -Recurse -Filter 'game.key' -File

foreach ($KeyFile in $keyFiles) {
    $Dir = $KeyFile.Directory.FullName

    Write-Host ""
    Write-Host "Checking folder: $Dir"

    "" | Add-Content -Path $Log -Encoding UTF8
    "Checking folder: $Dir" | Add-Content -Path $Log -Encoding UTF8

    $WudFiles = Get-ChildItem -Path $Dir -Filter '*.wud' -File

    if ($WudFiles.Count -eq 0) {
        Write-Host "  SKIP: No .wud file found in this same folder as game.key"
        "  SKIP: No .wud file found in this same folder as game.key" | Add-Content -Path $Log -Encoding UTF8
        $Skipped++
        continue
    }

    if ($WudFiles.Count -gt 1) {
        Write-Host "  SKIP: More than one .wud file found in this folder"
        "  SKIP: More than one .wud file found in this folder" | Add-Content -Path $Log -Encoding UTF8
        foreach ($WudFile in $WudFiles) {
            Write-Host "    $($WudFile.Name)"
            "    $($WudFile.Name)" | Add-Content -Path $Log -Encoding UTF8
        }
        $Skipped++
        continue
    }

    $Wud = $WudFiles[0]

    if ($KeyFile.Length -ne 16) {
        Write-Host "  SKIP: game.key is $($KeyFile.Length) bytes. Expected 16 bytes."
        "  SKIP: game.key is $($KeyFile.Length) bytes. Expected 16 bytes." | Add-Content -Path $Log -Encoding UTF8
        $Skipped++
        continue
    }

    $Bytes = [System.IO.File]::ReadAllBytes($KeyFile.FullName)
    $Hex = -join ($Bytes | ForEach-Object { $_.ToString('x2') })

    if ($Hex.Length -ne 32) {
        Write-Host "  SKIP: Generated key length is $($Hex.Length). Expected 32."
        "  SKIP: Generated key length is $($Hex.Length). Expected 32." | Add-Content -Path $Log -Encoding UTF8
        $Skipped++
        continue
    }

    $Line = "$Hex # $($Wud.BaseName)"
    $PerGameKeys = Join-Path $Dir 'keys.txt'

    Set-Content -Path $PerGameKeys -Value $Line -Encoding ASCII
    Add-Content -Path $Master -Value $Line -Encoding ASCII

    Write-Host "  OK: Created: $PerGameKeys"
    Write-Host "  Line: $Line"

    "  OK: Created: $PerGameKeys" | Add-Content -Path $Log -Encoding UTF8
    "  Line: $Line" | Add-Content -Path $Log -Encoding UTF8

    $Found++
}

"" | Add-Content -Path $Log -Encoding UTF8
"Finished." | Add-Content -Path $Log -Encoding UTF8
"Created keys for: $Found folder(s)" | Add-Content -Path $Log -Encoding UTF8
"Skipped: $Skipped folder(s)" | Add-Content -Path $Log -Encoding UTF8

Write-Host ""
Write-Host "Finished."
Write-Host "Created keys for: $Found folder(s)"
Write-Host "Skipped: $Skipped folder(s)"

if (Test-Path $Master) {
    Write-Host "Master keys.txt created: $Master"
    "Master keys.txt created: $Master" | Add-Content -Path $Log -Encoding UTF8
} else {
    Write-Host "No master keys.txt was created."
    "No master keys.txt was created." | Add-Content -Path $Log -Encoding UTF8
}

Write-Host ""
Write-Host "Log written to: $Log"