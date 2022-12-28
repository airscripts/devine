import os

include core/proxy
include core/parser

var parameters = initOptParser(
  commandLineParams()
)

let commands = parser(parameters)
proxy(commands)