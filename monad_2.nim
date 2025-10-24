type
  TMaybe[T] = object
    case empty: bool
    of false: value: T
    else: nil

proc Just*[T](value: T): TMaybe[T] =
  result.empty = false
  result.value = value

proc Nothing*[T](): TMaybe[T] =
  result.empty = true

proc safe_read_line(): TMaybe[string] =
  var r = stdin.read_line()
  if r == "": return Nothing[string]()
  else: return Just(r)

when is_main_module:
  var Test = Just("Test")
  echo Test.value
  var m_some = safe_read_line()
  echo m_some.value
