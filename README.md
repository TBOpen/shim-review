This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your branch

Note that we really only have experience with using grub2 on Linux, so asking
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
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/tree/15  (The shim-15 release download)

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/TBOpen/shim-review

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
Fixes the code peter jones implemented on our behalf via ALLOW_32BIT_KERNEL_ON_X64 
which was misunderstood.  We have an option to boot a signed x686 kernel on x64
machines. The patch fixes it, it also disables fallback as we don't need it, and 
allows us to provide different names to boot instead of a hard coded grubx64.efi. 
Also fixes potential memory leak issues and patch to fix fedora 29 issue with header 
files being moved to a different directory.

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
I used Fedora 29. This repo has the various shim files.   download all files to
their own directory.  The "shim-15.tar.gz" file is from the shim site.  
1 - Extract "shim-15.tar.gz" to the subdirectory so it creates the subdirectory 
    named "shim-15".  
2 - Copy the "shim.cer" file to the "shim-15" subdirectory.  
3 - Run "make_shim_15" to do the build.  
4 - Once done I ran "strip shimx64.efi" on it.
    Note: I did that from Ubuntu if it matters: GNU strip (GNU Bin Utils for debian) 2.25

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
I have uploaded the versions of gcc, ld, and linux version.  It should be a plain
install.  You should have no problem creating a matching shimx64.efi version following
instructions above (not counting date/time specific items embeeded in binaries).  
This is just a normal install in a VM that that has been upgraded several
times to bring it up to Fedora 29.

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
I typically go straight to MS to validate it, but want to try this method to
see how well if flows.  It should be plain enough to reproduce without problems.  
I'm moving from SHIM14 to SHIM15 since I need to update GRUB 2 to the latest
version with the YY_FATAL_ERROR patch that changes grub_printf to grub_fatal
which I also have done (based on Ubuntu version grub2_2.02-2ubuntu8-16).  I
see no need for you to have to deal with GRUB logs and building since there 
would be no point; anyone trying to cheat the system for some reason could 
send you something good then replace with something else. 


-------------------------------------------------------------------------------
If bootloader, shim loading is, grub2: is CVE-2020-10713 fixed ?
-------------------------------------------------------------------------------
Yes.

-------------------------------------------------------------------------------
If bootloader, shim loading is, grub2, and previous shims were trusting affected
by CVE-2020-10713 grub2:
* were old shims hashes provided to Microsoft for verification
  and to be added to future DBX update ?
* Does your new chain of trust disallow booting old, affected by CVE-2020-10713,
  grub2 builds ?
-------------------------------------------------------------------------------
MS has the files because they signed them.  If they want me to provide or mark
it as expired, that's fine (but not until the new release is out or people may
not be able to restore or use their systems.).

Yes, the new shim won't be able to load the old grub2.

-------------------------------------------------------------------------------
If your boot chain of trust includes linux kernel, is
"efi: Restrict efivar_ssdt_load when the kernel is locked down"
upstream commit 1957a85b0032a81e6482ca4aab883643b8dae06e applied ?
Is "ACPI: configfs: Disallow loading ACPI tables when locked down"
upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 applied ?
-------------------------------------------------------------------------------
It will because we continually update and won't be updating until this shim
thing is done.   We'll still use the 5.4.x kernels and the patch was applied in 
5.4.50 our release will be beyond that.  Typically the latest or one version back
at the time we do the release.

-------------------------------------------------------------------------------
If you use vendor_db functionality of providing multiple certificates and/or
hashes please briefly describe your certificate setup. If there are whitelisted hashes
please provide exact binaries for which hashes are created via file sharing service,
available in public with anonymous access for verification
-------------------------------------------------------------------------------
N/A don't use it.
