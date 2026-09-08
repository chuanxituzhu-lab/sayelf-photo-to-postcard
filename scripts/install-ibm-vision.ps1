param(
  [string]$Model = 'ibm/granite3.2-vision:2b-q4_K_M'
)

$ErrorActionPreference = 'Stop'

if (-not (Get-Command ollama -ErrorAction SilentlyContinue)) {
  throw '未检测到 Ollama。请先安装 Ollama，再重新运行本脚本。'
}

Write-Host "正在本机安装 IBM Granite Vision 模型：$Model"
& ollama pull $Model
if ($LASTEXITCODE -ne 0) {
  throw "Ollama 模型下载失败（退出码：$LASTEXITCODE）。"
}

Write-Host 'IBM Granite Vision 已安装到本机 Ollama。图片识别仍只发送到 127.0.0.1。'
