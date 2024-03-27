# Run this with local admin
# New-SelfSignedCertificate -DnsName "Authentication Purpose" -CertStoreLocation "cert:\LocalMachine\My"


$certname = "KapilIntune"    ## Replace {certificateName}
$cert = New-SelfSignedCertificate -Subject "CN=$certname" -CertStoreLocation "Cert:\CurrentUser\My" -KeyExportPolicy Exportable -KeySpec Signature -KeyLength 2048 -KeyAlgorithm RSA -HashAlgorithm SHA256
Export-Certificate -Cert $cert -FilePath "C:\Users\kapil\projects\lrn_graph_m365\$certname.cer"   ## Specify your preferred location