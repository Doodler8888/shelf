rename :: Filepath -> Filepath
rename Filepath =
    let name = format fp filePath
    let trashPath = "~/.local/share/trash" ++ name

