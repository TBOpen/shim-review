Confirm the following are included in your repo, checking each box:

 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [-] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [x] any extra patches to shim via your own git tree or as files
 - [x] any extra patches to grub via your own git tree or as files
 - [-] build logs - (NOTE: docker file will generate them.)
 - [x] a Dockerfile to reproduce the build of the provided shim EFI binaries

*******************************************************************************
### What is the link to your tag in a repo cloned from rhboot/shim-review?
*******************************************************************************
`https://github.com/TBOpen/shim-review/releases/tag/TeraByte-Shim15.8-x64-20240203`


*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
0c19056e13f3e0658dfa5c0f223cad9b712fb666e02422f9703e22bd09e8333c

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
https://github.com/TBOpen/shim-review/releases/tag/TeraByte-Shim15.4-x64-20210510
