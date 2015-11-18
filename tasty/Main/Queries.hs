module Main.Queries where

import Main.Prelude hiding (def)
import qualified Hasql as H
import qualified Hasql.Serialization as HS
import qualified Hasql.Deserialization as HD
import qualified Main.Prelude as Prelude


def :: ByteString -> H.Query () ()
def sql =
  (sql, Prelude.def, Prelude.def, False)

plain :: ByteString -> H.Query () ()
plain sql =
  (sql, mempty, HD.noResult, False)

dropType :: ByteString -> H.Query () ()
dropType name =
  plain $
    "drop type if exists " <> name

createEnum :: ByteString -> [ByteString] -> H.Query () ()
createEnum name values =
  plain $
    "create type " <> name <> " as enum (" <> 
    mconcat (intersperse ", " (map (\x -> "'" <> x <> "'") values)) <> ")"