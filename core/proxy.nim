import std/tables

proc proxy(parameters: OrderedTable[int, OrderedTable[string, string]]) =
  for parameter in parameters.values:
    case parameter["key"]
      of "help":
        echo "Help function."
        break

      else:
        echo "Default case."
        break