@ECHO off
SET wsusPath=\\path\to\wds\wsuscontent
SET /P wimPath="Bitte kompletten Pfad zum WIM eingeben: "

MD mnt
DISM /Mount-Image /ImageFile:%wimPath% /index:1 /MountDir:mnt

FOR /F %%f in ('DIR /s /b /o:n /A:D %wsusPath%') do (
  DISM /Image:mnt /Add-Package /PackagePath:%%f
)

DISM /Unmount-Image /MountDir:mnt /commit
RD mnt

PAUSE