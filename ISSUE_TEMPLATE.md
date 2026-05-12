Confirm the following are included in your repo, checking each box:

 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [-] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [x] any extra patches to shim via your own git tree or as files
 - [x] any extra patches to grub via your own git tree or as files
 - [x] build logs - (NOTE: docker file will generate them.)
 - [x] a Dockerfile to reproduce the build of the provided shim EFI binaries

*******************************************************************************
### What is the link to your tag in a repo cloned from rhboot/shim-review?
*******************************************************************************
~~https://github.com/TBOpen/shim-review/releases/tag/TeraByte-Shim16.1-x64-20260501~~
https://github.com/TBOpen/shim-review/releases/tag/TeraByte-Shim16.1-x64-20260511

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
f35d4531b064f81f226de242f737c9fb829ef4690a0fffde73f589f636bb5987  shimx64.efi

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************

From 2024: https://github.com/rhboot/shim-review/issues/369
From 2021: https://github.com/rhboot/shim-review/issues/139


*******************************************************************************
### If no security contacts have changed since verification, what is the link to your request, where they've been verified (if any, otherwise N/A)?
*******************************************************************************
Added secondary contact, no change to primary contact since being verified in 2024.  I would guess the link you want is
https://github.com/rhboot/shim-review/issues/369
