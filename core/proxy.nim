import std/tables

from ../types/index as types import Listionary
from ../constants/index as constants import PROXY_KEYS
from ../functions/index as functions import help, validate

proc proxy*(commands: Listionary) =
  for command in commands.values:
    case command["key"]
      of PROXY_KEYS.validate:
        functions.validate()
        break

      of PROXY_KEYS.help:
        functions.help()
        break

      else:
        functions.help()
        break