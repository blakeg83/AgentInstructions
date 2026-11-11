param(
  [string]$TargetPath = ".",
  [Parameter(Mandatory=$true)][string]$ProjectName,
  [ValidateSet("dotnet","generic")][string]$ProjectType = "dotnet",
  [string]$TaigaProject = ""
)
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$target = [System.IO.Path]::GetFullPath($TargetPath)
if (-not (Test-Path -LiteralPath $target -PathType Container)) { throw "Target directory does not exist: $target" }
$hasTaiga = -not [string]::IsNullOrWhiteSpace($TaigaProject)
$files = @(@{path="AGENTS.md"; source="AGENTS.base.md"})
if ($hasTaiga) { $files += @{path="docs/taiga-agent-workflow.md"; source="taiga-agent-workflow.md"} }
foreach ($f in $files) {
  $dest = Join-Path $target $f.path
  if (Test-Path -LiteralPath $dest) { throw "Refusing to overwrite: $dest" }
}
$base = Get-Content -LiteralPath (Join-Path $root "templates/AGENTS.base.md") -Raw
if ($ProjectType -eq "dotnet") {
  $base += "`n" + (Get-Content -LiteralPath (Join-Path $root "templates/AGENTS.dotnet.md") -Raw)
}
if (-not $hasTaiga) {
  $base = ($base -split "`n" | Where-Object { $_ -notmatch 'Taiga is the source|When Taiga is configured|high-priority defect' }) -join "`n"
  $base = $base.Replace("docs/taiga-agent-workflow.md", "the configured project workflow")
}
foreach ($f in $files) {
  $dest = Join-Path $target $f.path
  $parent = Split-Path -Parent $dest
  if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
  $content = if ($f.path -eq "AGENTS.md") { $base } else { Get-Content -LiteralPath (Join-Path $root ("templates/" + $f.source)) -Raw }
  $content = $content.Replace("{{PROJECT_NAME}}", $ProjectName).Replace("{{TAIGA_PROJECT}}", $(if ($hasTaiga) { $TaigaProject } else { "not configured" }))
  [System.IO.File]::WriteAllText($dest, $content, [System.Text.UTF8Encoding]::new($false))
  Write-Host "Created $dest"
}
