# AntiRenderDragon
Powershell script to convert x64 minecraft to x86 minecraft.

How to run:

1. Download the file (and unzip it)

2. Open Powershell as administrator

3. cd to where the file is located (if its in the downloads folder you can use this command: `cd (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path`)

4. Type in this command: `Set-ExecutionPolicy RemoteSigned`

5. Unblock the script using the `Unblock-File` cmdlet (snippet if you are in the downloads folder: `Unblock-File .\AntiRenderDragon-master\AntiRenderDragon.ps1`)

6. Run the script

7. After you are done you can set the ExecutionPolicy back to what it was before, though it is not really needed with "RemoteSigned". To change it back run this command: `Set-ExecutionPolicy Default`


if you have any questions dont hesitate to open a new issue
oh i forgot to say this: PLEASE MAKE A BACKUP BEFORE RUNNING THIS

have fun with it


im gonna make it better yes just wait pls im a human too
