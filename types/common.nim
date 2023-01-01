import std/tables

type Dictionary* = OrderedTableRef[string, string]
type Listionary* = OrderedTableRef[int, Dictionary]