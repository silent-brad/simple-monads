import std/strformat

func square(x: int): int =
  x * x

func add_one(x: int): int =
  x + 1

type NumberWithLogs = ref object
  result: int
  logs: seq[string]

func square_with_logs(x: int): NumberWithLogs =
  NumberWithLogs(result: x * x, logs: @[fmt"Squared {x} to get {x * x}."])

func add_one_with_logs(x: int): NumberWithLogs =
  NumberWithLogs(result: x + 1, logs: @[fmt"Squared {x} to get {x + 1}."])

func wrap_with_logs(x: int): NumberWithLogs =
  NumberWithLogs(result: x, logs: @[])

func run_with_logs(input: NumberWithLogs, transform: proc(x: int): NumberWithLogs {.no_side_effect.}): NumberWithLogs =
  var new_number_with_logs = transform(input.result)
  NumberWithLogs(result: new_number_with_logs.result, logs: input.logs & new_number_with_logs.logs)

echo add_one_with_logs(2).run_with_logs(square_with_logs).run_with_logs(add_one_with_logs).logs
