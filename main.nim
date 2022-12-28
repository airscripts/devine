import os

include core/proxy
include core/parser

var commandLineParameters = initOptParser(
  commandLineParams()
)

let parameters = parser(commandLineParameters)
proxy(parameters)