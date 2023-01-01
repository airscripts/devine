type ParameterKeys* = tuple[
  key: string,
  kind: string,
  value: string,
]

type ParameterKinds* = tuple[
  long: string,
  short: string,
  argument: string,
]

type ProxyKeys* = tuple[
  help: string,
  support: string,
  validate: string,
]