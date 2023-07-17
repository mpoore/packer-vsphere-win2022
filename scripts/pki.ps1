# Import trusted CA certs
# @author Michael Poore
$ErrorActionPreference = "Stop"

# Importing trusted CA certificates
Write-Host "-- Importing trusted CA certificates ..."
$webserver = $env:PKISERVER
$certRoot = "root.crt"
$certIssuing = "issuing.crt"
ForEach ($cert in $certRoot,$certIssuing) {
  Invoke-WebRequest -Uri ($webserver + "/" + $cert) -OutFile C:\$cert
}
Import-Certificate -FilePath C:\$certRoot -CertStoreLocation 'Cert:\LocalMachine\Root' | Out-Null
Import-Certificate -FilePath C:\$certIssuing -CertStoreLocation 'Cert:\LocalMachine\CA' | Out-Null
ForEach ($cert in $certRoot,$certIssuing) {
  Remove-Item C:\$cert -Confirm:$false
}