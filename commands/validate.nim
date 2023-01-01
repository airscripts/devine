import std/tables

from strformat import fmt
from ../types/index as types import Listionary
from ../utils/index as utils import hasArgument
from std/json import JsonNode, parseJson, contains, keys
from ../constants/index as constants import VALIDATE_OPTIONS

from ../errors/index as errors import 
  MISSING_SPEC,
  MULTIPLE_SPECS,
  MISSING_STRUCTURE,
  SPEC_NOT_AVAILABLE,
  STRUCTURE_NOT_FOUND,
  CUSTOM_SPEC_NOT_FOUND,
  STRUCTURE_MATCH_ERROR

proc specs(filename: string): JsonNode =
  try:
    const folder: string = "specs/"
    const extension: string = ".json"
    let spec: string = readFile(fmt"{folder}{filename}{extension}")
    return parseJson(spec)

  except IOError:
    echo SPEC_NOT_AVAILABLE
    system.quit(QuitFailure)

proc custom(path: string): JsonNode =
  try:
    let spec: string = readFile(path)
    return parseJson(spec)

  except IOError:
    echo CUSTOM_SPEC_NOT_FOUND
    system.quit(QuitFailure)

proc hasMultipleSpecs(args: Listionary): bool =
  var custom: bool
  var standard: bool

  for arg in args.values:
    case arg["key"]
      of "spec": standard = true
      of "custom": custom = true

  if standard and custom: return true
  else: return false

proc parser(arg: OrderedTableRef[string, string]): JsonNode =
  case arg["key"]:
    of VALIDATE_OPTIONS.spec:
      if cast[bool](arg["value"]):
        return specs(arg["value"])

    of VALIDATE_OPTIONS.custom:
      if cast[bool](arg["value"]):
        return custom(arg["value"])
    
    else:
      echo MISSING_SPEC
      system.quit(QuitFailure)

proc processor(path: OrderedTableRef[string, string]): JsonNode =
  try:
    let structure: string = readFile(path["key"])
    return parseJson(structure)

  except IOError:
    echo STRUCTURE_NOT_FOUND

proc checker(structure: JsonNode, spec: JsonNode): void =
  for key in keys(structure):
    if not contains(spec, key):
      raise newException(ValueError, "Key not found")

proc validate*(args: Listionary): void =
  var spec: JsonNode
  var structure: JsonNode
  var path: OrderedTableRef[string, string]
  let length: int = len(args)

  if utils.hasArgument(args[length]):
    discard args.pop(length, path)

  if hasMultipleSpecs(args):
    echo MULTIPLE_SPECS
    system.quit(QuitFailure)

  for arg in args.values:
    spec = parser(arg)

  if not cast[bool](path):
    echo MISSING_STRUCTURE
    system.quit(QuitFailure)

  try:
    structure = processor(path)
    checker(structure, spec)
    system.quit(QuitSuccess)
  
  except ValueError:
    echo STRUCTURE_MATCH_ERROR
    system.quit(QuitFailure)