import std/tables

from ../types/index as types import Listionary, Dictionary
from ../commands/index as commands import help, validate, support
from ../constants/index as constants import PROXY_KEYS, PARAMETER_KEYS

proc proxy*(args: Listionary): void =
  var arg: Dictionary
  discard args.pop(0, arg)

  case arg[PARAMETER_KEYS.key]
    of PROXY_KEYS.validate:
      commands.validate(args)

    of PROXY_KEYS.support:
      commands.support()

    of PROXY_KEYS.help:
      commands.help()

    else:
      commands.help()