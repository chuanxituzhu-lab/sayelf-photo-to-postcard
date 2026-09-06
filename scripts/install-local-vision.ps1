param(
  [string]$Destination = (Join-Path $PSScriptRoot '..\vision\vendor')
)

$ErrorActionPreference = 'Stop'
New-Item -ItemType Directory -Force -Path $Destination | Out-Null

$assets = @(
  @{ Name = 'tf.min.js'; Candidates = @(
      'https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@4.22.0/dist/tf.min.js',
      'https://unpkg.com/@tensorflow/tfjs@4.22.0/dist/tf.min.js'
    ) },
  @{ Name = 'coco-ssd.min.js'; Candidates = @(
      'https://cdn.jsdelivr.net/npm/@tensorflow-models/coco-ssd@2.2.3/dist/coco-ssd.min.js',
      'https://unpkg.com/@tensorflow-models/coco-ssd@2.2.3/dist/coco-ssd.min.js'
    ) },
  @{ Name = 'mobilenet.min.js'; Candidates = @(
      'https://cdn.jsdelivr.net/npm/@tensorflow-models/mobilenet@2.1.1/dist/mobilenet.min.js',
      'https://unpkg.com/@tensorflow-models/mobilenet@2.1.1/dist/mobilenet.min.js'
    ) }
)

foreach ($asset in $assets) {
  $target = Join-Path $Destination $asset.Name
  $downloaded = $false
  foreach ($uri in $asset.Candidates) {
    try {
      Write-Host "Downloading $($asset.Name)"
      Invoke-WebRequest -Uri $uri -OutFile $target -UseBasicParsing
      if ((Get-Item $target).Length -gt 1024) {
        $downloaded = $true
        break
      }
    } catch {
      Write-Verbose "Download failed: $uri"
    }
  }
  if (-not $downloaded) {
    throw "Could not download $($asset.Name). Check network access and retry."
  }
}

$licenseDir = Join-Path (Split-Path $Destination -Parent) 'licenses'
New-Item -ItemType Directory -Force -Path $licenseDir | Out-Null
$licenses = @(
  @{ Name = 'tensorflow-js-LICENSE'; Uri = 'https://raw.githubusercontent.com/tensorflow/tfjs/master/LICENSE' },
  @{ Name = 'tensorflow-js-models-LICENSE'; Uri = 'https://raw.githubusercontent.com/tensorflow/tfjs-models/master/LICENSE' }
)
foreach ($license in $licenses) {
  try {
    Invoke-WebRequest -Uri $license.Uri -OutFile (Join-Path $licenseDir $license.Name) -UseBasicParsing
  } catch {
    Write-Warning "License download skipped: $($license.Uri)"
  }
}

$manifest = [ordered]@{
  installedAt = (Get-Date).ToUniversalTime().ToString('o')
  runtime = 'TensorFlow.js 4.22.0'
  models = @('COCO-SSD 2.2.3', 'MobileNet 2.1.1')
  browserCache = 'IndexedDB after first model load'
  source = 'https://github.com/tensorflow/tfjs-models'
}
$manifest | ConvertTo-Json | Set-Content -Path (Join-Path (Split-Path $Destination -Parent) 'local-vision-manifest.json') -Encoding UTF8
Write-Host "Local vision pack installed in $Destination"
Write-Host 'Open sayelf-photo-to-postcard.html, upload a photo, then click 加载并运行本地视觉识别.'
