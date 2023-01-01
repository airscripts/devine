import std/tables

proc isKindKey*(
  value: OrderedTableRef[string, string],
  key: string,
  kind: string
): bool =
  if value[key] == kind: return true
  else: return false