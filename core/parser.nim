import std/tables 

from std/parseopt import
  next,
  cmdEnd,
  OptParser,
  cmdArgument,
  CmdLineKind,
  cmdLongOption,
  cmdShortOption

from ../types/index as types import Listionary
from ../constants/index as constants import DEFAULT_INDEX, PARAMETER_TYPE

proc initializeIndex(): OrderedTableRef[string, string] =
  return DEFAULT_INDEX.newOrderedTable

proc setParameterType(kind: CmdLineKind): string = 
  case kind
    of cmdArgument:
      return PARAMETER_TYPE.argument

    of cmdShortOption:
      return PARAMETER_TYPE.short
    
    of cmdLongOption:
      return PARAMETER_TYPE.long
    
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
    parameters[index]["key"] = list.key
    parameters[index]["value"] = list.val
    parameters[index]["type"] = setParameterType(list.kind)
    index += 1

  return parameters