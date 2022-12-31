from std/os import commandLineParams
from std/parseopt import initOptParser

from core/proxy import proxy
from core/parser import parser

var opts = initOptParser(
  commandLineParams()
)

let args = parser(opts)
proxy(args)