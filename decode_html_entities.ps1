# Decode HTML numeric character references (&#279; &#x0117;) to actual Unicode characters
param([string[]]$FilePath)
$paths = if ($FilePath -and $FilePath.Count -gt 0) {
    $FilePath | ForEach-Object { (Resolve-Path $_).Path }
} else {
    Get-ChildItem -Path $PSScriptRoot -Recurse -Include *.html,*.htm -File | Select-Object -ExpandProperty FullName
}

$enc = [System.Text.Encoding]::UTF8

foreach ($path in $paths) {
    $content = [System.IO.File]::ReadAllText($path, $enc)
    $original = $content

    # &#decimal; e.g. &#279; &#303;
    $content = [regex]::Replace($content, '&#(\d+);', {
        param($m)
        $code = [int]$m.Groups[1].Value
        if ($code -ge 0 -and $code -le 0x10FFFF) { [char]::ConvertFromUtf32($code) } else { $m.Value }
    })

    # &#xhex; or &#Xhex; e.g. &#x0117; &#x11F;
    $content = [regex]::Replace($content, '&#[xX]([0-9a-fA-F]+);', {
        param($m)
        $code = [Convert]::ToInt32($m.Groups[1].Value, 16)
        if ($code -ge 0 -and $code -le 0x10FFFF) { [char]::ConvertFromUtf32($code) } else { $m.Value }
    })

    if ($content -ne $original) {
        [System.IO.File]::WriteAllText($path, $content, $enc)
        Write-Host "Decoded: $path"
    }
}

Write-Host "Done."
