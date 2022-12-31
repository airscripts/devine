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
  validate                Validate a given specific against a JSON file
  support                 Show how you can support me and projects like this one
  help                    Show this help
"""

let options = """
Options:
  Nothing to see here
"""

let arguments = """
Arguments:
  Nothing to see here
"""

let descriptor* = fmt"""
{version}
{copyright}
{usage}
{commands}
{options}
{arguments}"""