Add-Type -AssemblyName System.Windows.Forms
function Set-Minecraft{
    param(
        [Parameter(Mandatory=$true)]
        [string]$url,
        [Parameter(Mandatory=$true)]
        [string]$method
    )
    switch ($method){
        ClearCacheReinstall{
            Write-Host "deleting cache..."
            Remove-Item -Path "$env:LOCALAPPDATA\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalCache" -Recurse -Force
            Write-Host "deleted cache"
    
            Write-Host "copying files..."
            Copy-Item -Path "$env:LOCALAPPDATA\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\" -Destination "$env:TEMP" -Recurse -Force
            Write-Host "copied files"
    
            Write-Host "downloading x86 version"
            Invoke-WebRequest -Uri $url -OutFile "$env:TEMP\minecraft_x86_temp.appx"
            Write-Host "downloaded x86 version"
    
            Write-Host "uninstalling minecraft"
            Remove-AppxPackage -Package "$minecraft"
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
        DontClearCacheReinstall{
            Write-Host "copying files..."
            Copy-Item -Path "$env:LOCALAPPDATA\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\" -Destination "$env:TEMP" -Recurse -Force
            Write-Host "copied files"
    
            Write-Host "downloading x86 version"
            Invoke-WebRequest -Uri $url -OutFile "$env:TEMP\minecraft_x86_temp.appx"
            Write-Host "downloaded x86 version"
    
            Write-Host "uninstalling minecraft"
            Remove-AppxPackage -Package "$minecraft"
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
        Install{
            
        Write-Host "downloading x86 minecraft"
        Invoke-WebRequest -Uri $url -OutFile "$env:TEMP\minecraft_x86_temp.appx"
        Write-Host "downloaded x86 minecraft"

        Write-Host "installing x86 minecraft"
        Add-AppxPackage -Path "$env:TEMP\minecraft_x86_temp.appx"
        Write-Host "installed x86 minecraft"

        Write-Host "clearing up..."
            Remove-Item -Path "$env:TEMP\minecraft_x86_temp.appx" -Force
                Write-Host "cleared temp package"
        Write-Host "finished clearing up"
        [System.Windows.Forms.MessageBox]::Show("Finished", "Finished", 0, 64)
        }
    }
}
Write-Host "getting latest downloads"
$x64=(Invoke-WebRequest -UseBasicParsing -URI https://raw.githubusercontent.com/CubeFOSS/minecraft-appx-download/master/x64.txt).Content
$x86=(Invoke-WebRequest -UseBasicParsing -URI https://raw.githubusercontent.com/CubeFOSS/minecraft-appx-download/master/x86.txt).Content
Write-Host "got latest downloads"
Write-Host "running checks"
    $apps = Get-AppxPackage | Select-Object Name, PackageFullName
    $minecraft = Get-AppxPackage -Name Microsoft.MinecraftUWP
    if("Microsoft.MinecraftUWP" -in $apps.Name){
        
        if ($minecraft -match "x86"){
            $install = [System.Windows.Forms.MessageBox]::Show("You are already running the x86 version, do you want to change to x64?", 1, 32)
            switch ($install){
                1{Set-Minecraft -url $x64 -method Install}
                2{exit}
            }
        }
    }
    else{
        $install = [System.Windows.Forms.MessageBox]::Show("Install x86 Minecraft? Yes: Install x86, No: Install x64, Cancel: Do nothing", "Install Minecraft?", 3, 32)
        switch($install){
            2{exit}
            7{Set-Minecraft -url $x64 -method Install}
            6{Set-Minecraft -url $x86 -method Install}
        }
    }
Write-Host "finished running checks"
$result = [System.Windows.Forms.MessageBox]::Show("This script changes the architecture of your Minecraft to x86", "Confirm", 1, 48)
if ($result -eq 1){
    $result2 = [System.Windows.Forms.MessageBox]::Show("Do you want to clear the cache? This can decrease waiting times and increase disk space.", "Clear Cache?", 4, 48)
    if ($result2 -eq 6){
        #Clear Cache
        Set-Minecraft -url $x86 -method ClearCacheReinstall
    }
    else{
        #Dont Clear Cache
        Set-Minecraft -url $x86 -method DontClearCacheReinstall
    }
}else{
    [System.Windows.Forms.MessageBox]::Show("Aborted", "Aborted", 0, 64)
}