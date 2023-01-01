import std/tables

from strformat import fmt
from ../utils/index as utils import isKindKey
from ../types/index as types import Listionary
from std/json import JsonNode, parseJson, contains, keys
from ../constants/index as constants import VALIDATE_OPTIONS

from ../errors/index as errors import 
  MISSING_SPEC,
  MULTIPLE_SPECS,
  MISSING_OPTIONS,
  MISSING_STRUCTURE,
  SPEC_NOT_AVAILABLE,
  STRUCTURE_NOT_FOUND,
  CUSTOM_SPEC_NOT_FOUND,
  STRUCTURE_MATCH_ERROR

proc specs(filename: string): JsonNode =
  try:
    const folder: string = "specs/"
    const extension: string = ".json"
    let spec: string = readFile(filename=fmt"{folder}{filename}{extension}")
    return parseJson(buffer=spec)

  except IOError:
    echo SPEC_NOT_AVAILABLE
    system.quit(errorcode=QuitFailure)

proc custom(path: string): JsonNode =
  try:
    let spec: string = readFile(filename=path)
    return parseJson(buffer=spec)

  except IOError:
    echo CUSTOM_SPEC_NOT_FOUND
    system.quit(errorcode=QuitFailure)

proc hasMultipleSpecs(args: Listionary): bool =
  var custom: bool
  var standard: bool

  for arg in args.values:
    case arg["key"]
      of "spec": standard = true
      of "custom": custom = true

  if standard and custom: return true
  else: return false

proc parser(args: Listionary): tuple[spec: JsonNode] =
  var spec: JsonNode

  const keys: tuple[key: string, value: string] = (
    key: "key",
    value: "value"
  )

  for arg in args.values:
    case arg[keys.key]:
      of VALIDATE_OPTIONS.spec:
        if cast[bool](arg[keys.value]):
          spec = specs(filename=arg[keys.value])

      of VALIDATE_OPTIONS.custom:
        if cast[bool](arg[keys.value]):
          spec = custom(path=arg[keys.value])
    
  if not cast[bool](spec):
    echo MISSING_SPEC
    system.quit(errorcode=QuitFailure)

  else: return (spec: spec)

proc processor(path: OrderedTableRef[string, string]): JsonNode =
  try:
    let structure: string = readFile(filename=path["key"])
    return parseJson(buffer=structure)

  except IOError:
    echo STRUCTURE_NOT_FOUND
    system.quit(errorcode=QuitFailure)

proc checker(structure: JsonNode, spec: JsonNode): void =
  for key in keys(node=structure):
    if not contains(node=spec, key=key):
      echo STRUCTURE_MATCH_ERROR
      system.quit(errorcode=QuitFailure)

proc validate*(args: Listionary): void = 
  var parsors: tuple[spec: JsonNode]
  var structure: JsonNode
  var path: OrderedTableRef[string, string]
  let length: int = len(t=args)

  if not cast[bool](length):
    echo MISSING_OPTIONS
    system.quit(errorcode=QuitFailure)

  if utils.isKindKey(
    key="type",
    kind="argument",
    value=args[length],
  ):
    discard pop(t=args, key=length, val=path)

  if hasMultipleSpecs(args=args):
    echo MULTIPLE_SPECS
    system.quit(errorcode=QuitFailure)

  parsors = parser(args=args)

  if not cast[bool](path):
    echo MISSING_STRUCTURE
    system.quit(errorcode=QuitFailure)

  structure = processor(path=path)
  checker(structure=structure, spec=parsors.spec)
  system.quit(errorcode=QuitSuccess)