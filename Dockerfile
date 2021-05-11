# Build SHIM 
FROM fedora:29

# just copied this from the Fedora submission
RUN dnf --nodocs -y --best --allowerasing --disablerepo='*' --enablerepo=fedora --enablerepo=updates install dnf-plugins-core
RUN dnf config-manager --set-disabled '*'
RUN dnf config-manager --set-enabled fedora updates
RUN dnf --nodocs -y --best --allowerasing install @buildsys-build ccache git make popt-devel nss-devel nspr-devel gettext elfutils-libelf-devel make gcc binutils vim-enhanced wget dos2unix
RUN dnf --nodocs -y --best --allowerasing builddep efivar pesign 'shim-unsigned*'

# copy over the files
RUN wget https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2
# ADD https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2 /
RUN tar xvfj shim-15.4.tar.bz2

# Add the patches needed prior to 15.5
ADD https://github.com/rhboot/shim/commit/4068fd42c891ea6ebdec056f461babc6e4048844.patch /
ADD https://github.com/rhboot/shim/commit/822d07ad4f07ef66fe447a130e1027c88d02a394.patch /
ADD https://github.com/rhboot/shim/commit/8b59591775a0412863aab9596ab87bdd493a9c1e.patch /
RUN cd /shim-15.4 && patch -Np1 -i /4068fd42c891ea6ebdec056f461babc6e4048844.patch
RUN cd /shim-15.4 && patch -Np1 -i /822d07ad4f07ef66fe447a130e1027c88d02a394.patch
RUN cd /shim-15.4 && patch -Np1 -i /8b59591775a0412863aab9596ab87bdd493a9c1e.patch

COPY cert/shim.cer /shim-15.4
COPY shim-15.4.patch /
COPY make_shim_15.4 /
RUN chmod +x /make_shim_15.4
RUN ./make_shim_15.4
RUN strip /shim-15.4/shimx64.efi

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


