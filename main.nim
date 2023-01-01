from core/proxy import proxy
from core/parser import parser
from std/os import commandLineParams
from std/parseopt import initOptParser

var opts = initOptParser(cmdLine=commandLineParams())
let args = parser(list=opts)
proxy(args=args)