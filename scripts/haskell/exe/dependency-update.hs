import System.Environment
import System.Process
import Text.Regex.Posix ((=~))

main :: IO ()
main = do
    -- Get the filename from the command line arguments
    args <- getArgs
    let filename = if null args then "Cargo.toml" else head args

    -- Read the file
    contents <- readFile filename

    -- Split the file into lines
    let lines = map words $ lines contents

    -- Find the index of the [dependencies] line
    let depsIndex = length $ takeWhile (/= "[dependencies]") lines

    -- Extract the dependencies
    let deps = drop (depsIndex + 1) lines

    -- Run cargo search on each dependency
    mapM_ (\dep -> callCommand $ "cargo search " ++ head dep) deps
