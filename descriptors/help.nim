import ../configs
from strformat import fmt

let version = fmt"Devine Version {configs.version}"
let copyright = "Copyright (c) 2023 by Airscript\n"

let usage = """
Usage:
  devine command [options] [arguments]
"""

let commands = """
Commands:
  validate                validate a given specific against a json file
  help                    show this help
"""

let options = """
Options:
  nothing to see here
"""

let arguments = """
Arguments:
  nothing to see here
"""

let descriptor* = fmt"""
{version}
{copyright}
{usage}
{commands}
{options}
{arguments}"""