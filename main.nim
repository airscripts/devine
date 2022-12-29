import std/os
import std/tables
import types/index as types
import descriptors/index as descriptors

include core/proxy
include core/parser

var parameters = initOptParser(
  commandLineParams()
)

let commands = parser(parameters)
proxy(commands)