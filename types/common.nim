import std/tables

type Listionary* = OrderedTableRef[
  int, 
  OrderedTableRef[string, string]
]