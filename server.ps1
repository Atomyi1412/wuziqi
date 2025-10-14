Param(
  [int]$Port = 8000,
  [string]$Root = "$(Resolve-Path .)"
)

Add-Type -AssemblyName System.Net.HttpListener
$prefix = "http://localhost:$Port/"
$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add($prefix)
$listener.Start()
Write-Host "Static server started at $prefix serving $Root" -ForegroundColor Green

function Get-ContentType([string]$path){
  switch -regex ($path){
    ".*\.html$" { return "text/html" }
    ".*\.css$" { return "text/css" }
    ".*\.js$" { return "application/javascript" }
    ".*\.json$" { return "application/json" }
    ".*\.(png|jpg|jpeg|gif|svg)$" { return "image/" + $Matches[1] }
    default { return "application/octet-stream" }
  }
}

while ($true) {
  try {
    $ctx = $listener.GetContext()
    $req = $ctx.Request
    $resp = $ctx.Response
    $path = $req.Url.LocalPath.TrimStart('/')
    if ([string]::IsNullOrWhiteSpace($path)) { $path = 'index.html' }
    $full = Join-Path $Root $path
    if (Test-Path $full) {
      $bytes = [System.IO.File]::ReadAllBytes($full)
      $resp.ContentType = Get-ContentType $full
      $resp.OutputStream.Write($bytes,0,$bytes.Length)
    } else {
      $resp.StatusCode = 404
      $msg = [Text.UTF8Encoding]::UTF8.GetBytes("Not Found")
      $resp.OutputStream.Write($msg,0,$msg.Length)
    }
    $resp.Close()
  } catch {
    Write-Host "Error: $_" -ForegroundColor Red
  }
}