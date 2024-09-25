import std/[paths]


when defined(posix):
    import std/posix

when defined(windows):
    proc win_execvp*(path: cstring, params: cstringArray): int64 {.importc: "_execvp", header: "<process.h>", sideEffect.}


proc exec*(path: string, params: seq[string]): int {.discardable.} =
    var c_params = allocCStringArray(@[string(Path(path).splitFile().name)] & params)
    defer: deallocCStringArray(c_params)

    when defined(posix):
        result = execvp(path.cstring, c_params)
    elif defined(windows):
        result = win_execvp(path.cstring, c_params).int
    else:
        raise newException(OSError, "OS not supported.")
