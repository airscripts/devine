import std/tables

from ../types/index as types import Listionary

proc validate*(args: Listionary) =
  var path: OrderedTableRef[string, string]
  var length: int = len(args)
  discard args.pop(length, path)

  for arg in args.values:
    case arg["key"]:
      of "specification":
        if cast[bool](arg["value"]): 
          echo "--specification option applied;"

      of "custom":
        if cast[bool](arg["value"]): 
          echo "--custom option applied;"
      
      else:
        echo "option skipped;"

  echo path