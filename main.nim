from std/os import commandLineParams
from std/parseopt import initOptParser

from core/proxy import proxy
from core/parser import parser

var parameters = initOptParser(
  commandLineParams()
)

let commands = parser(parameters)
proxy(commands)