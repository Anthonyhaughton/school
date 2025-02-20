# Anthony Haughton          # Student ID: 

# Prompt user until 5 key is presssed
do {
    # Display menu
    Write-Host "Menu:"
    Write-Host "1. List .log files in folder"
    Write-Host "2. List files in folder in alphabetical order"
    Write-Host "3. Show CPU and memory usage"
    Write-Host "4. List running processes by size"
    Write-Host "5. Exit"

    # Get user input
    $choice = Read-Host "Enter your choice"

    # Process user input
    switch ($choice) {
        1 {
            # B1: List .log files in folder with current date and output to DailyLog.txt
            $logFiles = Get-ChildItem -Filter "*.log" | Select-Object -ExpandProperty Name
            $logFilesWithDate = "$(Get-Date) - $($logFiles -join ', ')"
            Add-Content -Path ".\DailyLog.txt" -Value $logFilesWithDate
        }
        2 {
            # B2: List files in folder in alphabetical order and output to C916contents.txt
            $files = Get-ChildItem | Select-Object Name
            $files | Sort-Object -Property Name | Format-Table -AutoSize | Out-File -FilePath ".\C916contents.txt"
        }
        3 {
            # B3: Show CPU and memory usage
            $cpu = Get-CimInstance -Class Win32_Processor | Select-Object -ExpandProperty LoadPercentage
            $memory = Get-CimInstance -Class Win32_OperatingSystem | Select-Object -Property FreePhysicalMemory, TotalVisibleMemorySize

            Write-Host "CPU Usage: $cpu%"
            Write-Host "Free Memory: $($memory.FreePhysicalMemory) KB"
            Write-Host "Total Memory: $($memory.TotalVisibleMemorySize) KB"
        }
        4 {
            # B4: List running processes sorted by size
            #Get-Process | Sort-Object -Property VM | Format-Table -Autosize | Out-String
            #Get-Process | Sort-Object -Property VM | Out-GridView -Title "Running Processes (Sorted by VM Size)"
            # List running processes sorted by Virtual Memory (VM) size (least to greatest)
            Get-Process | 
                Sort-Object -Property VM | 
                Select-Object ProcessName, Id, VM, WS |
                Format-Table -AutoSize
    }

    # Sort by Process ID and display in a Grid View
    $ProcessList | Sort-Object -Property ProcessID | Out-GridView -Title "Processes and Associated Virtual Machines"
        }
        5 {
            # B5: Break the loop and stop the script
            break
        }
        default {
            # If 1-5 not selected
            Write-Host "Invalid Choice! Please try again."
        }
    }
} while ($choice -ne "5")

# Exception handling for System.OutOfMemoryException
try {
    # Step D: Your code that may throw an OutOfMemoryException
}
catch [System.OutOfMemoryException] {
    Write-Host "An OutOfMemoryException occurred!"
}

#Take screenshots and save them in Requirements folder
#Step E: Code to capture screenshots goes here

# Compress all files in folder to a ZIP archive
Compress-Archive -Path ".\" -Destination ".\"
