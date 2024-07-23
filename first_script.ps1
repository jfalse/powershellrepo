if ($args.Count -gt 0) {
    Write-Output "`nArgs exist, checking if directory exists..."
    Write-Output "---------------------------------------------------"

    # Check if the argument is a directory or file
    if (Test-Path -Path $args[0] -PathType Container) {
        Write-Output "$($args[0]) is a directory`n"
    } else {
        Write-Output "$($args[0]) directory does not exist`n"
    }
}

"{0,-15} {1,-20} {2,-30}" -f "Type", "Path/Size", "Name"
"{0,-15} {1,-20} {2,-30}" -f "----------", "--------------", "-----------"

Get-ChildItem | ForEach-Object {
    if ($_.PSIsContainer) {
        # Directory
        "{0,-15} {1,-20} {2,-30}" -f "[Directory]" , $_.FullName, " "
    } else {
	function Fsize {
		param (
			[int64]$handler
		)
		return "{0:N2} KB" -f ($handler / 1KB)
	}
	$fileSize = Fsize $_.length
        "{0,-15} {1,-20} {2,-15}" -f "[File]", $fileSize  , $_.Name
    }
}