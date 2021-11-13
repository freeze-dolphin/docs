Echo "Auto Deploy"

Git add .
Git commit -m .
Git push

Echo "Press any key to exit..."
[void][System.Console]::ReadKey(1)
