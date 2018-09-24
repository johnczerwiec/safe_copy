<powershell>
powershell.exe Set-ExecutionPolicy unrestricted -force
New-Item -Path "c:\temp" -Type Directory
copy-s3object -BucketName ${s3_bucket} -Key "AWSWinBoot.ps1" -LocalFile "c:\temp\AWSWinBoot.ps1"
powershell.exe -File c:\temp\AWSWinBoot.ps1
</powershell>
BUCKET=${s3_bucket}
