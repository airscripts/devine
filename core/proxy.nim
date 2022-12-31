import std/tables

from ../types/index as types import Listionary
from ../constants/index as constants import PROXY_KEYS
from ../functions/index as functions import help, validate

proc proxy*(commands: Listionary) =
  var command: OrderedTableRef[string, string]
  discard commands.pop(0, command)

  case command["key"]
    of PROXY_KEYS.validate:
      functions.validate()

    of PROXY_KEYS.support:
      functions.support()

    of PROXY_KEYS.help:
      functions.help()

    else:
      functions.help()