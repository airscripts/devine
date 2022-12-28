import std/tables
import std/parseopt

proc parser(
  list: var OptParser
): OrderedTable[int, OrderedTable[string, string]] =
  var index: int = 0

  var parameters = initOrderedTable[
    int,
    initOrderedTable[string, string]()
  ]()


  while true:
    list.next()

    if list.kind == cmdEnd:
      break

    parameters[index] = {
      "key": "", 
      "value": "", 
      "type": ""
    }.toOrderedTable

    parameters[index]["key"] = list.key
    parameters[index]["value"] = list.val

    case list.kind
      of cmdArgument:
        parameters[index]["type"] = "argument"

      of cmdShortOption:
        parameters[index]["type"] = "short"
      
      of cmdLongOption:
        parameters[index]["type"] = "long"
      
      else: 
        discard

    index += 1

  return parameters