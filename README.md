# emasys_linux


## Guide til hvordan linuxkerne og driver til EW-7811Un-V2 bygges på Windows maskine

* Installer GIT https://git-scm.com/downloads
* Installer docker: https://www.docker.com/products/docker-desktop

* Kør følgende kommandoer i kommandoprompten (cmd) 
```console
C:\Users\simon\Desktop>git config --global core.autocrlf input

C:\Users\simon\Desktop>git clone https://github.com/MTsimon/emazys_linux.git

C:\Users\simon\Desktop>cd emazys_linux

C:\Users\simon\Desktop\emasys_linux>docker build -t emazys_linux .

C:\Users\simon\Desktop\emasys_linux>docker run -it --name=emazys_container -v <local_dir>:/mnt/host emazys_linux
```
> Eksempel på <local_dir> kan være C:\\Users\\%USERNAME%\\Desktop , der oprettes en ny mappe der hedder "rootfs", some indeholder zImage og 8188eu.ko på det lokale skrivebord. Husk at fjerne "<>" tegn.
```console
root@8c98670601ec:/# make_kernel
```
> Dette kan tage lang tid afhængig af internetforbindelse og CPU-hastighed
```console
root@8c98670601ec:/# exit
```

Kernefilerne kan nu findes i <local_dir>/rootfs mappen.

wpa_supplicant_8_jb_4.2_rtw_r25670.20171213 skal bruges til at oprette accesspoint. Kan nemmest kompileres på target.
