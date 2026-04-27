$ErrorActionPreference = "Stop"

$RootDir = Resolve-Path (Join-Path $PSScriptRoot "..")
$CodexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
$SkillsDir = Join-Path $CodexHome "skills"
$TargetDir = Join-Path $SkillsDir "cliproxy-image-cli"
$CliPath = Join-Path $TargetDir "vendor\cliproxy-image-cli\bin\cliproxy-image-cli.js"

New-Item -ItemType Directory -Force $SkillsDir | Out-Null
if (Test-Path $TargetDir) { Remove-Item -Recurse -Force $TargetDir }
Copy-Item -Recurse -Force (Join-Path $RootDir "skill_src\cliproxy-image-cli") $TargetDir

$Node = Get-Command node -ErrorAction SilentlyContinue
if ($null -eq $Node) {
  Write-Host "Installed skill to: $TargetDir"
  Write-Warning "Node.js 18+ is required to run the vendored CLI, but node was not found in PATH."
  exit 0
}

& node $CliPath --help | Out-Null

Write-Host "Installed cliproxy-image-cli skill to: $TargetDir"
Write-Host "Vendored CLI: $CliPath"
Write-Host 'Try: $cliproxy-image-cli 画一张 SaaS 架构图，保存到当前目录'
