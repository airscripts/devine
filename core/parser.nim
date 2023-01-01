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
  DEFAULT_INDEX,
  PARAMETER_KEYS,
  PARAMETER_KINDS

proc initializeIndex(): Dictionary =
  return DEFAULT_INDEX.newOrderedTable

proc setParameterType(kind: CmdLineKind): string = 
  case kind
    of cmdArgument:
      return PARAMETER_KINDS.argument

    of cmdShortOption:
      return PARAMETER_KINDS.short
    
    of cmdLongOption:
      return PARAMETER_KINDS.long
    
    else: 
      discard

proc parser*(list: var OptParser): Listionary =
  var index: int = 0

  var parameters: Listionary = newOrderedTable[
    int, newOrderedTable[string, string]()
  ]()

  while true:
    list.next()

    let isCmdEnd: bool = list.kind == cmdEnd
    if isCmdEnd: break

    parameters[index] = initializeIndex()
    parameters[index][PARAMETER_KEYS.key] = list.key
    parameters[index][PARAMETER_KEYS.value] = list.val
    parameters[index][PARAMETER_KEYS.kind] = setParameterType(list.kind)

    index += 1

  return parameters