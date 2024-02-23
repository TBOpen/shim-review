This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 or systemd-boot on Linux, so
asking us to endorse anything else for signing is going to require some convincing on
your part.

Check the docs directory in this repo for guidance on submission and
getting your shim signed.

Here's the template:

*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************
TeraByte, Inc.  https://www.terabyteunlimited.com

*******************************************************************************
### What product or service is this for?
*******************************************************************************
Image for Linux Recovery Boot Disk
Image for UEFI Recovery Boot Disk
TeraByte OS Deployment Tool Suite (UEFI Boot)
BootIt UEFI

*******************************************************************************
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
*******************************************************************************
Commerical software with large install base used worldwide.

*******************************************************************************
### Why are you unable to reuse shim from another distro that is already signed?
*******************************************************************************
Because they don't meet our needs and requirements for our products.

*******************************************************************************
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.
*******************************************************************************
- Name:  David Flicek
- Position: President
- Email address: corp@terabyteunlimited.com
- PGP key fingerprint:  2891C706D99AB4B2ECF5D1BE64B1B1216F7DC24B


*******************************************************************************
### Who is the secondary contact for security updates, etc.?
*******************************************************************************
- Name: N/A 
- Position: N/A
- Email address: N/A
- PGP key fingerprint: N/A

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Were these binaries created from the 15.8 shim release tar?
Please create your shim binaries starting with the 15.8 shim release tar file: https://github.com/rhboot/shim/releases/download/15.8/shim-15.8.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.8 and contains the appropriate gnu-efi source.

*******************************************************************************
yes.  https://github.com/rhboot/shim/releases/tag/15.8 (shim-15.8 release)

plus selected patches of commits - see Dockerfile

*******************************************************************************
### URL for a repo that contains the exact code which was built to get this binary:
*******************************************************************************
https://github.com/TBOpen/shim-review

*******************************************************************************
### What patches are being applied and why:
*******************************************************************************
Removes the x64 on x32 section which prevents the x32 on x64 from working. 
Explained in patch.  Option to disable fallback as we don't need it, and 
allows us to provide different names to boot instead of a hard coded grubx64.efi. 

*******************************************************************************
### If shim is loading GRUB2 bootloader what exact implementation of Secureboot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
*******************************************************************************
Yes, using grub2-unsigned-2.12~rc1-10ubuntu4 from Ubuntu 23.10.

*******************************************************************************
### If shim is loading GRUB2 bootloader and your previously released shim booted a version of GRUB2 affected by any of the CVEs in the July 2020, the March 2021, the June 7th 2022, the November 15th 2022, or 3rd of October 2023 GRUB2 CVE list, have fixes for all these CVEs been applied?

* 2020 July - BootHole
  * Details: https://lists.gnu.org/archive/html/grub-devel/2020-07/msg00034.html
  * CVE-2020-10713
  * CVE-2020-14308
  * CVE-2020-14309
  * CVE-2020-14310
  * CVE-2020-14311
  * CVE-2020-15705
  * CVE-2020-15706
  * CVE-2020-15707
* March 2021
  * Details: https://lists.gnu.org/archive/html/grub-devel/2021-03/msg00007.html
  * CVE-2020-14372
  * CVE-2020-25632
  * CVE-2020-25647
  * CVE-2020-27749
  * CVE-2020-27779
  * CVE-2021-3418 (if you are shipping the shim_lock module)
  * CVE-2021-20225
  * CVE-2021-20233
* June 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-06/msg00035.html, SBAT increase to 2
  * CVE-2021-3695
  * CVE-2021-3696
  * CVE-2021-3697
  * CVE-2022-28733
  * CVE-2022-28734
  * CVE-2022-28735
  * CVE-2022-28736
  * CVE-2022-28737
* November 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-11/msg00059.html, SBAT increase to 3
  * CVE-2022-2601
  * CVE-2022-3775
* October 2023 - NTFS vulnerabilities
  * Details: https://lists.gnu.org/archive/html/grub-devel/2023-10/msg00028.html, SBAT increase to 4
  * CVE-2023-4693
  * CVE-2023-4692
*******************************************************************************
The old grub version will not work with the new shim.  New certificate was created.

*******************************************************************************
### If shim is loading GRUB2 bootloader, and if these fixes have been applied, is the upstream global SBAT generation in your GRUB2 binary set to 4?
The entry should look similar to: `grub,4,Free Software Foundation,grub,GRUB_UPSTREAM_VERSION,https://www.gnu.org/software/grub/`
*******************************************************************************
Yes.

*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
*******************************************************************************
No, there is no need to provide old shim hashes to MS - no bugs in our specific parts.
(FWIW, I thought the whole concept of SBAT was to not overpopulate the limited DBX - if everyone adds their old hash to DBX the whole problem is back)
Yes, the old grub versions will not boot with the new shim.

*******************************************************************************
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?
*******************************************************************************
Yes, using 6.6.x already has all patches applied. 

*******************************************************************************
### Do you build your signed kernel with additional local patches? What do they do?
*******************************************************************************
yes, fix sil3512 polling with NIEN bit, 
change tmpfs max to 90% from 50% needed for use on small memory envrionments,
basically nothing that is a security issue.

*******************************************************************************
### Do you use an ephemeral key for signing kernel modules?
### If not, please describe how you ensure that one kernel build does not load modules built for another kernel.
*******************************************************************************
yes, each major update gets a new key.  It's automatic on our build system.

*******************************************************************************
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
*******************************************************************************
N/A

*******************************************************************************
### If you are re-using a previously used (CA) certificate, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs to vendor_dbx in shim in order to prevent GRUB2 from being able to chainload those older GRUB2 binaries. If you are changing to a new (CA) certificate, this does not apply.
### Please describe your strategy.
*******************************************************************************
N/A

*******************************************************************************
### What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as closely as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
### If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and what the differences would be.
*******************************************************************************
Dockerfile method:

1 - Run "docker_make_shim".
2 - The file will be placed in "terabyte_shim-15.8_built"

*******************************************************************************
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
*******************************************************************************
The "terabyte_shim-15.8_built" directory will contain the build log as well.

*******************************************************************************
### What changes were made in the distor's secure boot chain since your SHIM was last signed?
For example, signing new kernel's variants, UKI, systemd-boot, new certs, new CA, etc..
*******************************************************************************
The new SHIM has a new certificate so won't load any of the prior items and
as mentioned every major kernel update (e.g. 5.14 to 5.15) gets a new key.

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
02c4bf81a5f359213d80ec365366d8be35b02bf84e522802c5fc8ee8694c8e05 *shimx64.efi

*******************************************************************************
### How do you manage and protect the keys used in your SHIM?
*******************************************************************************
hardware secuirty token.

*******************************************************************************
### Do you use EV certificates as embedded certificates in the SHIM?
*******************************************************************************
No, they expire too soon, we use the generated one.

*******************************************************************************
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( GRUB2, fwupd, fwupdate, systemd-boot, systemd-stub, shim + all child shim binaries )?
### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim.
### Where your code is only slightly modified from an upstream vendor's, please also preserve their SBAT entries to simplify revocation.
If you are using a downstream implementation of GRUB2 or systemd-boot (e.g.
from Fedora or Debian), please preserve the SBAT entry from those distributions
and only append your own. More information on how SBAT works can be found
[here](https://github.com/rhboot/shim/blob/main/SBAT.md).
*******************************************************************************
Yes, we append our own SBAT entries.

SHIM:

sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,4,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.terabyte,1,TeraByte,UEFI shim,2,https://www.terabyteunlimited.com

GRUB2:
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,4,Free Software Foundation,grub,2.12~rc1,https://www.gnu.org/software/grub/
grub.ubuntu,1,Ubuntu,grub2,2.12~rc1-10ubuntu4,https://www.ubuntu.com/
grub.peimage,1,Canonical,grub2,2.12~rc1-10ubuntu4,https://salsa.debian.org/grub-team/grub/-/blob/master/debian/patches/secure-boot/efi-use-peimage-shim.patch
grub.terabyte,1,TeraByte,grub2,2.12-tbu-2024-1,https://www.terabyteunlimited.com/

Our UEFI Applications:

BootIt:

sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
BIU.TERABYTE,1,TeraByte,BootIt UEFI,1,https://www.terabyteunlimited.com

Image for Linux:

sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
IFU.TERABYTE,1,TeraByte,Image for UEFI,1,https://www.terabyteunlimited.com

TBOSDT:

sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
TBOSDT.TERABYTE,1,TeraByte,TBOSDT UEFI,1,https://www.terabyteunlimited.com



*******************************************************************************
### If shim is loading GRUB2 bootloader, which modules are built into your signed GRUB2 image?
*******************************************************************************
test sleep search search_fs_uuid search_fs_file search_label png password_pbkdf2 
gcry_sha512 pbkdf2 part_gpt part_msdos part_apple minicmd memdisk linux relocator 
loadenv keystatus jpeg iso9660 hfsplus halt acpi mmap gfxmenu gfxterm trig 
bitmap_scale bitmap font fat ext2 fshelp reboot echo configfile normal terminal 
gettext chain efinet net priority_queue datetime bufio cat extcmd btrfs gzio 
lzopio crypto boot all_video efi_gop efi_uga video_bochs video_cirrus video_fb 
video help peimage

*******************************************************************************
### If you are using systemd-boot on arm64 or riscv, is the fix for [unverified Devicetree Blob loading](https://github.com/systemd/systemd/security/advisories/GHSA-6m6p-rjcq-334c) included?
*******************************************************************************
N/A 

*******************************************************************************
### What is the origin and full version number of your bootloader (GRUB2 or systemd-boot or other)?
*******************************************************************************
will be using grub2-unsigned-2.12~rc1-10ubuntu4 from Ubuntu 23.10.

*******************************************************************************
### If your SHIM launches any other components, please provide further details on what is launched.
*******************************************************************************
Image for UEFI Recovery Boot Disk
TeraByte OS Deployment Tool Suite (UEFI Boot)
BootIt UEFI

*******************************************************************************
### If your GRUB2 or systemd-boot launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
*******************************************************************************
N/A

*******************************************************************************
### How do the launched components prevent execution of unauthenticated code?
*******************************************************************************
Checks signatures.

*******************************************************************************
### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB2)?
*******************************************************************************
No.
*******************************************************************************
### What kernel are you using? Which patches does it includes to enforce Secure Boot?
*******************************************************************************
6.6.x

*******************************************************************************
### Add any additional information you think we may need to validate this shim.
*******************************************************************************
N/A.
