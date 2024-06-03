$port = Read-Host "Enter the port number to listen on: "

$listener = [System.Net.Sockets.TcpListener]::new('0.0.0.0', $port)
$listener.Start()

Write-Host "TCP listener started on port $port. Waiting for connections..."

while ($true) {
    $client = $listener.AcceptTcpClient()
    $stream = $client.GetStream()
    $reader = [System.IO.StreamReader]::new($stream)
    $writer = [System.IO.StreamWriter]::new($stream)

    $clientEndPoint = $client.Client.RemoteEndPoint
    Write-Host "Connection established from $($clientEndPoint.Address):$($clientEndPoint.Port)"

    while ($stream.DataAvailable) {
        $data = $reader.ReadLine()
        Write-Host "Received: $data"
    }

    $reader.Close()
    $writer.Close()
    $stream.Close()
    $client.Close()
}
