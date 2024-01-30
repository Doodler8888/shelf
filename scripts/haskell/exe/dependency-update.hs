import System.Environment (getArgs)
import System.Process (readProcess)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import Control.Monad (forM_)

main :: IO ()
main = do
    [filePath] <- getArgs  -- Get the file path from command line arguments
    contents <- TIO.readFile filePath
    let dependenciesBlock = dropWhile (/= "[dependencies]") $ T.lines contents
    let dependencies = takeWhile (not . T.isPrefixOf "[") $ drop 1 dependenciesBlock
    let depNames = map (head . T.words . fst . T.breakOn "=") dependencies
    latestVersions <- mapM getLatestVersion depNames
    let updatedContents = T.unlines $ updateDependencies (zip depNames latestVersions) $ T.lines contents
    TIO.writeFile filePath updatedContents
    putStrLn "Updated Cargo.toml with the latest dependency versions."

getLatestVersion :: Text -> IO Text
getLatestVersion depName = do
    output <- readProcess "cargo" ["search", T.unpack depName] ""
    let latestVersion = head . drop 1 . T.words . T.pack $ head $ lines output
    return $ T.filter (/= '"') latestVersion

updateDependencies :: [(Text, Text)] -> [Text] -> [Text]
updateDependencies updates = map updateLine
  where
    updateLine line = case T.breakOn "=" line of
        (name, version) -> case lookup name updates of
            Just newVersion -> name <> "= \"" <> newVersion <> "\""
            Nothing -> name <> version


