# Build SHIM 
FROM fedora:42

# set to the time_t value to use for the PE image - this causes build machine name to also be fixed value
ENV SOURCE_DATE_EPOCH=1777254038

# just copied this from the Fedora submission - this will install latest versions
#RUN dnf -y --disablerepo='*' --enablerepo=fedora --enablerepo=updates install --nodocs --best --allowerasing dnf-plugins-core
#RUN dnf config-manager setopt *.enabled=0
#RUN dnf config-manager setopt fedora.enabled=1 updates.enabled=1
#RUN dnf -y install --nodocs --best --allowerasing  @buildsys-build ccache git make popt-devel nss-devel nspr-devel gettext elfutils-libelf-devel make gcc binutils vim-enhanced wget dos2unix
#RUN dnf -y builddep --nodocs --best --allowerasing efivar pesign 'shim-unsigned-x64'

# this is the locked versions - from chatgpt - after building with the latest versions commented out below.
#
# to update the rpms.lock file:
#   1 - comment out the two commands below
#   2 - uncomment the RUN dnf items above that install the latest versions
#   3 - create a build.
#   4 - find image id: docker image ls
#   5 - open shell in image: docker run -it <image id> bash
#   6 - run: rpm -qa --qf '%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}\n' | sort > /rpms.lock
#   7 - exit the container: exit
#   8 - find container name: docker ps --all
#   9 - copy rpms.lock file out of container: docker cp <container>:/rpms.lock ./rpms.lock
#  10 - undo #1 and #2 above.
#

COPY rpms.lock /tmp/rpms.lock

RUN dnf -y install fedora-repos-archive && \
    dnf config-manager setopt updates-archive.enabled=1 && \
    rpm -qa --qf '%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}\n' | sort > /tmp/base.lock && \
    comm -13 /tmp/base.lock /tmp/rpms.lock > /tmp/to-install.lock && \
    dnf -y install --nodocs --best $(cat /tmp/to-install.lock) && \
    dnf clean all
    

# copy over the files
RUN wget https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2
# ADD https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2 /
RUN tar xvfj shim-16.1.tar.bz2

# Add the patches needed prior to 15.5 - needed for 15.4 build
#ADD https://github.com/rhboot/shim/commit/4068fd42c891ea6ebdec056f461babc6e4048844.patch /
#ADD https://github.com/rhboot/shim/commit/822d07ad4f07ef66fe447a130e1027c88d02a394.patch /
#ADD https://github.com/rhboot/shim/commit/8b59591775a0412863aab9596ab87bdd493a9c1e.patch /
#RUN cd /shim-15.4 && patch -Np1 -i /4068fd42c891ea6ebdec056f461babc6e4048844.patch
#RUN cd /shim-15.4 && patch -Np1 -i /822d07ad4f07ef66fe447a130e1027c88d02a394.patch
#RUN cd /shim-15.4 && patch -Np1 -i /8b59591775a0412863aab9596ab87bdd493a9c1e.patch

COPY cert/shim.cer /shim-16.1
COPY shim-16.1.patch /
COPY make_shim_16.1 /
RUN chmod +x /make_shim_16.1
RUN ./make_shim_16.1 &> shim_build.log
RUN strip /shim-16.1/shimx64.efi

# copy files out using:
#   docker cp <containerid>:/file/path/within/container /host/path/target
# list the containers using: 
#   docker ps --all
# remove containers using:
#   docker rm <containerid>
# list the images using:
#   docker image ls
# remove an image:
#   docker image rm <imageid>
# open shell in an image
#   docker run -it <imageid> sh


