$port = 5600
$listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $port)
$listener.Start()
Write-Output "Server running at http://localhost:$port/"
while ($true) {
  $client = $listener.AcceptTcpClient()
  try {
    $stream = $client.GetStream()
    $reader = New-Object System.IO.StreamReader($stream, [System.Text.Encoding]::ASCII, $false, 1024, $true)
    $requestLine = $reader.ReadLine()
    if (-not $requestLine) { $client.Close(); continue }
    while ($true) { $line = $reader.ReadLine(); if (-not $line -or $line -eq '') { break } }
    $parts = $requestLine.Split(' ')
    $path = $parts[1].TrimStart('/')
    if ($path -eq '') { $path = 'index.html' }
    $full = Join-Path (Get-Location) $path
    if (Test-Path $full) {
      $bytes = [System.IO.File]::ReadAllBytes($full)
      $contentType = if ($full.EndsWith('.html')) { 'text/html' } elseif ($full.EndsWith('.css')) { 'text/css' } elseif ($full.EndsWith('.js')) { 'application/javascript' } else { 'application/octet-stream' }
      $header = "HTTP/1.1 200 OK`r`nContent-Type: $contentType`r`nContent-Length: $($bytes.Length)`r`nConnection: close`r`n`r`n"
      $headerBytes = [System.Text.Encoding]::ASCII.GetBytes($header)
      $stream.Write($headerBytes, 0, $headerBytes.Length)
      $stream.Write($bytes, 0, $bytes.Length)
    } else {
      $body = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
      $header = "HTTP/1.1 404 Not Found`r`nContent-Type: text/plain`r`nContent-Length: $($body.Length)`r`nConnection: close`r`n`r`n"
      $headerBytes = [System.Text.Encoding]::ASCII.GetBytes($header)
      $stream.Write($headerBytes,0,$headerBytes.Length)
      $stream.Write($body,0,$body.Length)
    }
    $stream.Close()
  } finally {
    $client.Close()
  }
}