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
https://github.com/TBOpen/shim-review/releases/tag/TeraByte-Shim16.1-x64-20260501

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
10825ab529301401b5b18854537726009336a8ebbad8e661fd88561ed4dfa574 *shimx64.efi

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************

From 2024: https://github.com/rhboot/shim-review/issues/369
From 2021: https://github.com/rhboot/shim-review/issues/139


*******************************************************************************
### If no security contacts have changed since verification, what is the link to your request, where they've been verified (if any, otherwise N/A)?
*******************************************************************************
There are no changes since being verified in 2024.  I would guess the link is
https://github.com/rhboot/shim-review/issues/369
