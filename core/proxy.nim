import std/tables

from ../types/index as types import Listionary
from ../constants/index as constants import PROXY_KEYS
from ../functions/index as functions import help, validate, support

proc proxy*(args: Listionary) =
  var arg: OrderedTableRef[string, string]
  discard args.pop(0, arg)

  case arg["key"]
    of PROXY_KEYS.validate:
      functions.validate(args)

    of PROXY_KEYS.support:
      functions.support()

    of PROXY_KEYS.help:
      functions.help()

    else:
      functions.help()