import os
import std/tables
import types/common

include core/proxy
include core/parser

var parameters = initOptParser(
  commandLineParams()
)

let commands = parser(parameters)
proxy(commands)