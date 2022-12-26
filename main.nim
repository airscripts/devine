import os
include core/parser

var commandLineParameters = initOptParser(
  commandLineParams()
)

echo parser(commandLineParameters)