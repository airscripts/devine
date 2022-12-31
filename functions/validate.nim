import std/tables

from strformat import fmt
from std/json import JsonNode, parseJson
from ../types/index as types import Listionary
from ../utils/index as utils import hasArgument

proc specs(filename: string): JsonNode =
  try:
    var folder: string = "specs/"
    var extension: string = ".json"
    var spec: string = readFile(fmt"{folder}{filename}{extension}")
    return parseJson(spec)

  except IOError:
    echo "Spec not available."

proc custom(): void =
  echo "custom procedure."

proc validate*(args: Listionary): void =
  var spec: JsonNode
  var path: OrderedTableRef[string, string]
  var length: int = len(args)

  if utils.hasArgument(args[length]):
    discard args.pop(length, path)

  for arg in args.values:
    case arg["key"]:
      of "spec":
        if cast[bool](arg["value"]):
          spec = specs(arg["value"])
          echo "--spec option applied;"

      of "custom":
        if cast[bool](arg["value"]):
          custom()
          echo "--custom option applied;"
      
      else:
        echo "option skipped;"

  if cast[bool](path):
    echo path