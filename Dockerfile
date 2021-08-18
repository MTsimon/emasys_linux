FROM ubuntu:raring
RUN sed -i 's/archive.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install git -y
RUN apt-get install gcc-arm-linux-gnueabihf -y
RUN apt-get install gcc -y
RUN apt-get install wget -y
RUN apt-get install make -y
RUN apt-get install bc -y
RUN apt-get install lzop -y
RUN apt-get install libnl-3-dev -y
RUN apt-get install libnl-genl-3-dev -y
ADD make_kernel.sh /usr/bin/make_kernel
RUN chmod +x /usr/bin/make_kernel
RUN mkdir emazys
ADD mmc.patch /emazys/
ADD ew-7811Un_V2 /emazys/
ADD config-3.14.35-ti-r56 /emazys/
#ENTRYPOINT [ "make_kernel" ]
ENTRYPOINT [ "/bin/bash" ]
