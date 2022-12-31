import std/tables

from ../types/index as types import Listionary
from ../constants/index as constants import PROXY_KEYS
from ../commands/index as commands import help, validate, support

proc proxy*(args: Listionary): void =
  var arg: OrderedTableRef[string, string]
  discard args.pop(0, arg)

  case arg["key"]
    of PROXY_KEYS.validate:
      commands.validate(args)

    of PROXY_KEYS.support:
      commands.support()

    of PROXY_KEYS.help:
      commands.help()

    else:
      commands.help()