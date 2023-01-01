from ../types/index as types import ParameterKeys, ParameterKinds, ProxyKeys

const PARAMETER_KEYS*: ParameterKeys = (
  key: "key",
  kind: "kind",
  value: "value",
)

const PARAMETER_KINDS*: ParameterKinds = (
  long: "long",
  short: "short",
  argument: "argument",
)

const DEFAULT_INDEX*: array[0..2, (string, string)] = {
  PARAMETER_KEYS.key: "",
  PARAMETER_KEYS.kind: "",
  PARAMETER_KEYS.value: "",
}

const PROXY_KEYS*: ProxyKeys = (
  help: "help",
  support: "support",
  validate: "validate",
)