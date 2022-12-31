import std/tables

from strformat import fmt
from std/json import JsonNode, parseJson
from ../types/index as types import Listionary
from ../utils/index as utils import hasArgument
from ../constants/index as constants import VALIDATE_OPTIONS

proc specs(filename: string): JsonNode =
  try:
    const folder: string = "specs/"
    const extension: string = ".json"
    let spec: string = readFile(fmt"{folder}{filename}{extension}")
    return parseJson(spec)

  except IOError:
    echo "Spec not available."

proc custom(path: string): JsonNode =
  try:
    let spec: string = readFile(path)
    return parseJson(spec)

  except IOError:
    echo "Custom spec not found."

proc validate*(args: Listionary): void =
  var spec: JsonNode
  var path: OrderedTableRef[string, string]
  let length: int = len(args)

  if utils.hasArgument(args[length]):
    discard args.pop(length, path)

  for arg in args.values:
    case arg["key"]:
      of VALIDATE_OPTIONS.spec:
        if cast[bool](arg["value"]):
          spec = specs(arg["value"])
          echo "--spec option applied;"

      of VALIDATE_OPTIONS.custom:
        if cast[bool](arg["value"]):
          spec = custom(arg["value"])
          echo "--custom option applied;"
      
      else:
        echo fmt"-{arg[""key""]} option skipped;"

  if cast[bool](path):
    echo path