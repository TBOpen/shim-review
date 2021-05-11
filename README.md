This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your branch
- approval is ready when you have accepted tag

Note that we really only have experience with using GRUB2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
TeraByte, Inc.  https://www.terabyteunlimited.com

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
Image for Linux Recovery Boot Disk
Image for UEFI Recovery Boot Disk
TeraByte OS Deployment Tool Suite (UEFI Boot)
BootIt UEFI

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
Commerical software with large install base used worldwide.

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name:  David Flicek
- Position: President
- Email address: corp@terabyteunlimited.com
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community:  
  Wow, I haven't used PGP in a very long time - I remember starting using it back
  in the CompuServe days.  Anyway, looks like I still have support@terabyteunlimited.com 
  and terabyte@terabyteunlimited.com in the PGP database.  

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
N/A

-------------------------------------------------------------------------------
Please create your shim binaries starting with the 15.4 shim release tar file:
https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.4 and contains
the appropriate gnu-efi source.
-------------------------------------------------------------------------------
yes.  https://github.com/rhboot/shim/releases/tag/15.4 (shim-15.4 release)

plus selected patches of commits - see Dockerfile

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/TBOpen/shim-review

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
Removes the x64 on x32 section which prevents the x32 on x64 from working. 
Explained in patch.  Option to disable fallback as we don't need it, and 
allows us to provide different names to boot instead of a hard coded grubx64.efi. 
Also fixes potential memory leak issues.

-------------------------------------------------------------------------------
If bootloader, shim loading is, GRUB2: is CVE-2020-14372, CVE-2020-25632,
 CVE-2020-25647, CVE-2020-27749, CVE-2020-27779, CVE-2021-20225, CVE-2021-20233,
 CVE-2020-10713, CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311,
 CVE-2020-15705, and if you are shipping the shim_lock module CVE-2021-3418
-------------------------------------------------------------------------------
Yes, I'll be using Ubuntu 20.04.2 GRUB 2.04 version with latest patches.
Keeping an eye out on: https://ubuntu.com/security/cve?q=&package=grub2

It's building today 5/10/2021 using grub2_2.04-1ubuntu26.11

-------------------------------------------------------------------------------
What exact implementation of Secureboot in GRUB2 ( if this is your bootloader ) you have ?
* Upstream GRUB2 shim_lock verifier or * Downstream RHEL/Fedora/Debian/Canonical like implementation ?
-------------------------------------------------------------------------------
Will be building based on Ubnutu version keeping an eye on:
https://ubuntu.com/security/cve?q=&package=grub2

grub2_2.04-1ubuntu26.11

-------------------------------------------------------------------------------
If bootloader, shim loading is, GRUB2, and previous shims were trusting affected
by CVE-2020-14372, CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
  CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
  CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
  and if you were shipping the shim_lock module CVE-2021-3418
  ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
  grub2:
* were old shims hashes provided to Microsoft for verification
  and to be added to future DBX update ?
* Does your new chain of trust disallow booting old, affected by CVE-2020-14372,
  CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
  CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
  CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
  and if you were shipping the shim_lock module CVE-2021-3418
  ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
  grub2 builds ?
-------------------------------------------------------------------------------
The old grub version will not work with the new shim.  New certificate was created.

MS being the signer has the information, and it's in the dbx.

-------------------------------------------------------------------------------
If your boot chain of trust includes linux kernel, is
"efi: Restrict efivar_ssdt_load when the kernel is locked down"
upstream commit 1957a85b0032a81e6482ca4aab883643b8dae06e applied ?
Is "ACPI: configfs: Disallow loading ACPI tables when locked down"
upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 applied ?
-------------------------------------------------------------------------------
It will be used with 5.10.19 or later which already has all the patches.
Confirm that LOCK_DOWN_KERNEL_FORCE_INTEGRITY is the required kernel config
option.

-------------------------------------------------------------------------------
If you use vendor_db functionality of providing multiple certificates and/or
hashes please briefly describe your certificate setup. If there are allow-listed hashes
please provide exact binaries for which hashes are created via file sharing service,
available in public with anonymous access for verification
-------------------------------------------------------------------------------
N/A don't use it.

-------------------------------------------------------------------------------
If you are re-using a previously used (CA) certificate, you will need
to add the hashes of the previous GRUB2 binaries to vendor_dbx in shim
in order to prevent GRUB2 from being able to chainload those older GRUB2
binaries. If you are changing to a new (CA) certificate, this does not
apply. Please describe your strategy.
-------------------------------------------------------------------------------
Generated new certificate that has not been released in any MS signed shim.

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
If possible, provide a Dockerfile that rebuilds the shim.
-------------------------------------------------------------------------------
I used Fedora 29. This repo has the various shim files.   download all files to
their own directory.  The "shim-15.4.tar.bz2" file is from link provided.  
1 - Extract "shim-15.4.tar.bz2" to the subdirectory so it creates the subdirectory 
    named "shim-15.4".  
2 - Copy the "shim.cer" file to the "shim-15.4" subdirectory.  
3 - Run "make_shim_15.4" to do the build.  
4 - Once done I ran "strip shimx64.efi" on it.

Dockerfile method:

1 - Run "docker_make_shim".
2 - The file will be placed in "terabyte_shim-15.4_built"

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
I have uploaded the versions of gcc, ld, and linux version.  It should be a plain
install.  You should have no problem creating a matching shimx64.efi version following
instructions above (not counting date/time specific items embeeded in binaries).  
This is just a normal install in a VM that that has been upgraded several
times to bring it up to Fedora 29.

Dockerfile now exists.

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
Note: I created the shim.crt using openssl because efikeygen was giving me
trouble.   It's 2020 because that's when I created it after the boothole, 
but it hasn't been used in production yet.

openssl req -newkey rsa:2048 -x509 -sha256 -days 3650 -nodes \
            -out shim.crt -keyout shim.key \
            -subj "/CN=TeraByte UEFI SB 2020/O=Terabyte Inc/L=Las Vegas/ST=Nevada/C=US"
openssl pkcs12 -export -out shim.pfx -inkey shim.key -in shim.crt
openssl x509 -outform der -in shim.crt -out shim.cer
