import std/tables

from ../types/index as types import Listionary
from ../utils/index as utils import hasArgument

proc specs(): void =
  echo "specs procedure."

proc custom(): void =
  echo "custom procedure."

proc validate*(args: Listionary): void =
  var path: OrderedTableRef[string, string]
  var length: int = len(args)

  if utils.hasArgument(args[length]):
    discard args.pop(length, path)

  for arg in args.values:
    case arg["key"]:
      of "spec":
        if cast[bool](arg["value"]):
          specs()
          echo "--spec option applied;"

      of "custom":
        if cast[bool](arg["value"]):
          custom()
          echo "--custom option applied;"
      
      else:
        echo "option skipped;"

  if cast[bool](path):
    echo path