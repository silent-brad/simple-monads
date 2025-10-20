import std/strformat

func square(x: int): int =
  x * x

func add_one(x: int): int =
  x + 1

type Result[T] = ref object
  value: T
  logs: seq[string]

func square_with_logs(x: int): Result[int] =
  Result[int](value: x * x, logs: @[fmt"Squared {x} to get {x * x}."])

func add_one_with_logs(x: int): Result[int] =
  Result[int](value: x + 1, logs: @[fmt"Squared {x} to get {x + 1}."])

func wrap_with_logs(x: int): Result[int] =
  Result[int](value: x, logs: @[])

func run_with_logs[A, B](input: Result[A], transform: proc(x: A): Result[B] {.no_side_effect.}): Result[B] =
  var new_value = transform(input.value)
  Result[B](value: new_value.value, logs: input.logs & new_value.logs)

echo add_one_with_logs(2).run_with_logs(square_with_logs).run_with_logs(add_one_with_logs).logs
