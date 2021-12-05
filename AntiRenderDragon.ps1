$message = "This script changes the architecture of your Minecraft to x86"
$title = "Confirm"

$result = [System.Windows.Forms.MessageBox]::Show($message, $title, 1, 48)
if ($result -eq 1){
    $result2 = [System.Windows.Forms.MessageBox]::Show("Do you want to clear the cache? This can decrease waiting times and increase disk space.", "Clear Cache?", 4, 48)
    if ($result2 -eq 6){
        #Clear Cache

        Write-Host "deleting cache..."
        Remove-Item -Path "$env:LOCALAPPDATA\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalCache" -Recurse -Force
        Write-Host "deleted cache"

        Write-Host "copying files..."
        Copy-Item -Path "$env:LOCALAPPDATA\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\" -Destination "$env:TEMP" -Recurse -Force
        Write-Host "copied files"

        Write-Host "downloading x86 version"
        Invoke-WebRequest -Uri "https://renderdragon.pink/latest" -OutFile "$env:TEMP\minecraft_x86_temp.appx"
        Write-Host "downloaded x86 version"

        Write-Host "uninstalling minecraft"
        Remove-AppxPackage -Package "Microsoft.MinecraftUWP_8wekyb3d8bbwe"
        Write-Host "uninstalled minecraft"

        Write-Host "installing x86 minecraft"
        Add-AppxPackage -Path "$env:TEMP\minecraft_x86_temp.appx"
        Write-Host "installed x86 minecraft"

        Write-Host "restoring game data"
        Copy-Item -Path "$env:TEMP\Microsoft.MinecraftUWP_8wekyb3d8bbwe" -Destination "$env:LOCALAPPDATA\Packages\" -Recurse -Force
        Write-Host "restored game data"

        Write-Host "clearing up..."
        Remove-Item -Path "$env:TEMP\Microsoft.MinecraftUWP_8wekyb3d8bbwe" -Force -Recurse
            Write-Host "cleared temp game data"
        Remove-Item -Path "$env:TEMP\minecraft_x86_temp.appx" -Force
            Write-Host "cleared temp package"
        Write-Host "finished clearing up"

        [System.Windows.Forms.MessageBox]::Show("Finished", "Finished", 0, 64)

    }
    else{
        #Dont Clear Cache

        Write-Host "copying files..."
        Copy-Item -Path "$env:LOCALAPPDATA\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\" -Destination "$env:TEMP" -Recurse -Force
        Write-Host "copied files"

        Write-Host "downloading x86 version"
        Invoke-WebRequest -Uri "https://renderdragon.pink/latest" -OutFile "$env:TEMP\minecraft_x86_temp.appx"
        Write-Host "downloaded x86 version"

        Write-Host "uninstalling minecraft"
        Remove-AppxPackage -Package "Microsoft.MinecraftUWP_8wekyb3d8bbwe"
        Write-Host "uninstalled minecraft"

        Write-Host "installing x86 minecraft"
        Add-AppxPackage -Path "$env:TEMP\minecraft_x86_temp.appx"
        Write-Host "installed x86 minecraft"

        Write-Host "restoring game data"
        Copy-Item -Path "$env:TEMP\Microsoft.MinecraftUWP_8wekyb3d8bbwe" -Destination "$env:LOCALAPPDATA\Packages\" -Recurse -Force
        Write-Host "restored game data"

        Write-Host "clearing up..."
        Remove-Item -Path "$env:TEMP\Microsoft.MinecraftUWP_8wekyb3d8bbwe" -Force -Recurse
            Write-Host "cleared temp game data"
        Remove-Item -Path "$env:TEMP\minecraft_x86_temp.appx" -Force
            Write-Host "cleared temp package"
        Write-Host "finished clearing up"

        [System.Windows.Forms.MessageBox]::Show("Finished", "Finished", 0, 64)

    }


}else{
    [System.Windows.Forms.MessageBox]::Show("Aborted", "Aborted", 0, 64)
}

