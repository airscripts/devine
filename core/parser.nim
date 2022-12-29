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
from ../constants/index as constants import DEFAULT_INDEX 

proc initializeIndex(): OrderedTable[string, string] =
  return DEFAULT_INDEX.toOrderedTable

proc setParameterType(kind: CmdLineKind): string = 
  case kind
    of cmdArgument:
      return "argument"

    of cmdShortOption:
      return "short"
    
    of cmdLongOption:
      return "long"
    
    else: 
      discard

proc parser*(list: var OptParser): Listionary =
  var index = 0
  var parameters = initOrderedTable[int, initOrderedTable[string, string]()]()

  while true:
    list.next()

    let isCmdEnd = list.kind == cmdEnd
    if isCmdEnd: break

    parameters[index] = initializeIndex()
    parameters[index]["key"] = list.key
    parameters[index]["value"] = list.val
    parameters[index]["type"] = setParameterType(list.kind)
    index += 1

  return parameters