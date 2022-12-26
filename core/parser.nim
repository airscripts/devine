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
    echo list

    parameters[index] = {
      "key": "",
      "type": "",
      "value": "",
    }.toOrderedTable

    case list.kind
      of cmdEnd:
        break

      of cmdArgument:
        parameters[index]["key"] = list.key
        parameters[index]["type"] = "argument"

      of cmdShortOption, cmdLongOption:
        if list.val == "":
          parameters[index]["value"] = ""
          parameters[index]["type"] = "key"
          parameters[index]["key"] = list.key
        
        else:
          parameters[index]["key"] = list.key
          parameters[index]["value"] = list.val
          parameters[index]["type"] = "keyvalue"

    index += 1

  return parameters