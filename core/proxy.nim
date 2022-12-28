import std/tables

include ../functions/help
include ../functions/validate

proc proxy(parameters: OrderedTable[int, OrderedTable[string, string]]) =
  for parameter in parameters.values:
    case parameter["key"]
      of "validate":
        validate()
        break

      of "help":
        help()
        break

      else:
        help()
        break