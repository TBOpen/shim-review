# Build SHIM 
FROM fedora:42

# just copied this from the Fedora submission
RUN dnf -y --disablerepo='*' --enablerepo=fedora --enablerepo=updates install --nodocs --best --allowerasing dnf-plugins-core
RUN dnf config-manager setopt *.enabled=0
RUN dnf config-manager setopt fedora.enabled=1 updates.enabled=1
RUN dnf -y install --nodocs --best --allowerasing  @buildsys-build ccache git make popt-devel nss-devel nspr-devel gettext elfutils-libelf-devel make gcc binutils vim-enhanced wget dos2unix
RUN dnf -y builddep --nodocs --best --allowerasing efivar pesign 'shim-unsigned-x64'

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


