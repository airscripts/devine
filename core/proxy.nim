import std/tables

include ../types/common
include ../functions/help
include ../functions/validate

proc proxy(commands: Listionary) =
  for command in commands.values:
    case command["key"]
      of "validate":
        validate()
        break

      of "help":
        help()
        break

      else:
        help()
        break