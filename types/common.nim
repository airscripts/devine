import std/tables

type Listionary* = OrderedTable[
  int, 
  OrderedTable[string, string]
]