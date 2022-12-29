import std/tables

from ../types/index as types import Listionary
from ../functions/index as functions import help, validate

proc proxy*(commands: Listionary) =
  for command in commands.values:
    case command["key"]
      of "validate":
        functions.validate()
        break

      of "help":
        functions.help()
        break

      else:
        functions.help()
        break