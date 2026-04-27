$ErrorActionPreference = "Stop"

$RootDir = Resolve-Path (Join-Path $PSScriptRoot "..")
$CodexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
$SkillsDir = Join-Path $CodexHome "skills"
$TargetDir = Join-Path $SkillsDir "cliproxy-image-cli"

New-Item -ItemType Directory -Force $SkillsDir | Out-Null
if (Test-Path $TargetDir) { Remove-Item -Recurse -Force $TargetDir }
Copy-Item -Recurse -Force (Join-Path $RootDir "skill_src\cliproxy-image-cli") $TargetDir

Write-Host "Installed cliproxy-image-cli skill to: $TargetDir"
Write-Host 'Try: $cliproxy-image-cli 画一张 SaaS 架构图，保存到当前目录'
