import std/tables

from ../types/index as types import Listionary, Dictionary

from std/parseopt import
  next,
  cmdEnd,
  OptParser,
  cmdArgument,
  CmdLineKind,
  cmdLongOption,
  cmdShortOption

from ../constants/index as constants import
  PARAMETER_KEYS,
  PARAMETER_KINDS

proc siever(kind: CmdLineKind): string =
  case kind
    of cmdLongOption: return PARAMETER_KINDS.long
    of cmdArgument: return PARAMETER_KINDS.argument
    of cmdShortOption: return PARAMETER_KINDS.short
    else: discard

proc setter(element: OptParser): Dictionary =
  return {
    PARAMETER_KEYS.key: element.key,
    PARAMETER_KEYS.value: element.val,
    PARAMETER_KEYS.kind: siever(kind=element.kind),
  }.newOrderedTable

proc parser*(list: var OptParser): Listionary =
  var index: int = 0
  var dictionary: Dictionary = newOrderedTable[string, string]()
  var parameters: Listionary = newOrderedTable[int, dictionary]()

  while true:
    list.next()
    if list.kind == cmdEnd: break
    parameters[index] = setter(element=list)
    index += 1

  return parameters