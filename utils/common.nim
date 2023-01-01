import std/tables

from ../types/index as types import Dictionary

proc isEqualTo*(dict: Dictionary, key: string, value: string): bool =
  if dict[key] == value: return true
  else: return false