# Anthony Haughton         Student ID:

try {
    $sqlServerInstanceName = "SRV19-PRIMARY\SQLEXPRESS"
    $databaseName = "ClientDB"

    # D1. Check for the existence of the database
    $databaseCount = (Invoke-Sqlcmd -ServerInstance $sqlServerInstanceName -Query "SELECT COUNT(*) AS DatabaseCount FROM sys.databases WHERE name = '$databaseName'").DatabaseCount
    
    if ($databaseCount -eq 1) {
        Write-Host "The database '$databaseName' already exists. Deleting it..."
        # Force disconnect any active connections
        Invoke-Sqlcmd -ServerInstance $sqlServerInstanceName -Query "ALTER DATABASE [$databaseName] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;"
        # Drop the database
        Invoke-Sqlcmd -ServerInstance $sqlServerInstanceName -Query "DROP DATABASE [$databaseName];"
        Write-Host "The database '$databaseName' has been deleted."
    }
        
    # D2. Create the new database
    Write-Host "Creating the database '$databaseName'..."
    Invoke-Sqlcmd -ServerInstance $sqlServerInstanceName -Query "CREATE DATABASE [$databaseName]"
    Write-Host "The database '$databaseName' has been created."
    
    # D3. Create the new table
    $tableName = "Client_A_Contacts"
    $tableScript = @"
CREATE TABLE [$databaseName].[dbo].[$tableName]
(
    First_Name varchar(100),
    Last_Name varchar(100),
    City varchar(50),
    County varchar(50),
    Zip varchar(20),
    OfficePhone varchar(15),
    MobilePhone varchar(15)
)
"@
    Write-Host "Creating the table '$tableName'..."
    Invoke-Sqlcmd -ServerInstance $sqlServerInstanceName -Database $databaseName -Query $tableScript
    Write-Host "The table '$tableName' has been created."
    
    # D4. Insert data from the CSV file
    $csvPath = Join-Path $PSScriptRoot "NewClientData.csv"
    $insertScript = @"
BULK INSERT [$databaseName].[dbo].[$tableName]
FROM '$csvPath'
WITH (FORMAT = 'CSV', FIRSTROW = 2)
"@
    Write-Host "Inserting data from '$csvPath' into '$tableName'..."
    Invoke-Sqlcmd -ServerInstance $sqlServerInstanceName -Database $databaseName -Query $insertScript
    Write-Host "Data has been inserted into '$tableName'."
    
    # D5. Generate the output file
    $outputFilePath = Join-Path $PSScriptRoot "SqlResults.txt"
    $outputScript = "SELECT * FROM [$databaseName].[dbo].[$tableName]"
    Invoke-Sqlcmd -ServerInstance $sqlServerInstanceName -Database $databaseName -Query $outputScript | Out-File -FilePath $outputFilePath -Encoding UTF8
    Write-Host "The 'SqlResults.txt' file has been created."
}
# E. Error handling 
catch {
    Write-Host "An error occurred: $_"
}
