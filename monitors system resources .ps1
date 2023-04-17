<#PowerShell script that monitors system resources (CPU usage, memory usage, and disk usage) in real-time and displays the data continuously:#>



# Function to get total CPU usage percentage
Function Get-TotalCpuUsage {
    $cpuUsage = Get-Counter '\Processor(_Total)\% Processor Time' -ErrorAction SilentlyContinue |
                Select-Object -ExpandProperty CounterSamples |
                Select-Object -ExpandProperty CookedValue
    $cpuUsage
}

# Function to get total memory usage percentage
Function Get-TotalMemoryUsage {
    $memoryUsage = Get-Counter '\Memory\% Committed Bytes In Use' -ErrorAction SilentlyContinue |
                   Select-Object -ExpandProperty CounterSamples |
                   Select-Object -ExpandProperty CookedValue
    $memoryUsage
}

# Function to get total disk usage percentage
Function Get-TotalDiskUsage {
    $diskUsage = Get-Counter '\LogicalDisk(_Total)\% Free Space' -ErrorAction SilentlyContinue |
                 Select-Object -ExpandProperty CounterSamples |
                 Select-Object -ExpandProperty CookedValue |
                 ForEach-Object { 100 - $_ }
    $diskUsage
}

# Function to display system resource usage
Function Show-ResourceUsage {
    $cpuUsage = Get-TotalCpuUsage
    $memoryUsage = Get-TotalMemoryUsage
    $diskUsage = Get-TotalDiskUsage

    Write-Host "`nCPU Usage: $cpuUsage%"
    Write-Host "Memory Usage: $memoryUsage%"
    Write-Host "Disk Usage: $diskUsage%"
}

# Continuously display system resource usage every 1 second
while ($true) {
    Show-ResourceUsage
    Start-Sleep -Seconds 1
}
