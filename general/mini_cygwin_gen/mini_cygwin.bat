@echo off

set PATH_ORIG=%PATH%
set CYGWIN=nodosfilewarning

for %%F in (%0) do path %%~pFbin;%path%
for %%F in (%0) do bash.exe --login -i

path %PATH_ORIG%
