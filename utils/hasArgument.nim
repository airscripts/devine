import std/tables

proc hasArgument*(value: OrderedTableRef[string, string]): bool =
  if value["type"] == "argument": return true
  else: return false