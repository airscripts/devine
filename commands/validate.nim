import std/tables

from strformat import fmt
from ../utils/index as utils import isKindKey
from ../types/index as types import Listionary
from std/json import JsonNode, parseJson, contains, keys

from ../constants/index as constants import 
  PARAMETER_TYPE,
  PARAMETER_KEYS,
  VALIDATE_OPTIONS

from ../errors/index as errors import 
  MISSING_SPEC,
  MULTIPLE_SPECS,
  MISSING_OPTIONS,
  MISSING_STRUCTURE,
  SPEC_NOT_AVAILABLE,
  STRUCTURE_NOT_FOUND,
  CUSTOM_SPEC_NOT_FOUND,
  STRUCTURE_MATCH_ERROR

const SPECS_FOLDER = "specs/"
const SPEC_EXTENSION = ".json"

proc specs(filename: string): JsonNode =
  try:
    return parseJson(readFile(
      filename=fmt"{SPECS_FOLDER}{filename}{SPEC_EXTENSION}"
    ))

  except IOError:
    echo SPEC_NOT_AVAILABLE
    system.quit(errorcode=QuitFailure)

proc custom(path: string): JsonNode =
  try:
    return parseJson(buffer=readFile(filename=path))

  except IOError:
    echo CUSTOM_SPEC_NOT_FOUND
    system.quit(errorcode=QuitFailure)

proc parser(args: Listionary): tuple[spec: JsonNode] =
  var spec: JsonNode
  var hasSpec: bool = false
  var hasCustom: bool = false

  for arg in args.values:
    case arg[PARAMETER_KEYS.key]:
      of VALIDATE_OPTIONS.spec:
        if cast[bool](arg[PARAMETER_KEYS.value]):
          spec = specs(filename=arg[PARAMETER_KEYS.value])
          hasSpec = true

      of VALIDATE_OPTIONS.custom:
        if cast[bool](arg[PARAMETER_KEYS.value]):
          spec = custom(path=arg[PARAMETER_KEYS.value])
          hasCustom = true

  if hasSpec and hasCustom:
    echo MULTIPLE_SPECS
    system.quit(errorcode=QuitFailure)
    
  if not cast[bool](spec):
    echo MISSING_SPEC
    system.quit(errorcode=QuitFailure)

  else: return (spec: spec)

proc processor(path: OrderedTableRef[string, string]): JsonNode =
  try:
    let structure: string = readFile(filename=path[PARAMETER_KEYS.key])
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
    value=args[length],
    key=PARAMETER_KEYS.type,
    kind=PARAMETER_TYPE.argument,
  ):
    discard pop(t=args, key=length, val=path)

  parsors = parser(args=args)

  if not cast[bool](path):
    echo MISSING_STRUCTURE
    system.quit(errorcode=QuitFailure)

  structure = processor(path=path)
  checker(structure=structure, spec=parsors.spec)
  system.quit(errorcode=QuitSuccess)