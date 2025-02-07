# Anthony Haughton                      # Student ID:


do {
    # Display menu
    Write-Host "Menu:"
    Write-Host "1. List .log files in folder"
    Write-Host "2. List filesin folder in alphabetical order"
    Write-Host "3. Show current CPU and memory usage"
    Write-Host "4. List all running processes"
    Write-Host "5. Exit"

}

do {
    Write-Host "Select an option:"
    Write-Host "1. Activity One"
    Write-Host "2. Activity Two"
    Write-Host "3. Activity Three"
    Write-Host "4. Activity Four"
    Write-Host "5. Exit"
    
    # Prompt the user for input
    $choice = Read-Host "Enter your selection (1-5)"

    switch ($choice) {
        "1" {
            Write-Host "You selected Activity One."
            # Place code for Activity One here.
        }
        "2" {
            Write-Host "You selected Activity Two."
            # Place code for Activity Two here.
        }
        "3" {
            Write-Host "You selected Activity Three."
            # Place code for Activity Three here.
        }
        "4" {
            Write-Host "You selected Activity Four."
            # Place code for Activity Four here.
        }
        "5" {
            Write-Host "Exiting the program. Goodbye!"
            # Optionally, you could also use "break" here to exit the loop immediately.
            break
        }
        default {
            Write-Host "Invalid selection. Please try again."
        }
    }

    # Optionally add a blank line for better readability between iterations.
    Write-Host ""

} while ($choice -ne "5")