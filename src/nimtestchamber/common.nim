import std/[paths]


when defined(posix):
    import std/posix

when defined(windows):
    proc win_execvp*(path: cstring, params: cstringArray): int64 {.importc: "_execvp", header: "<process.h>", sideEffect.}


proc exec*(path: string, params: seq[string]) =
    var c_params = allocCStringArray(@[string(Path(path).splitFile().name)] & params)

    when defined(posix):
        discard execvp(path.cstring, c_params)
    elif defined(windows):
        discard win_execvp(path.cstring, c_params)
    else:
        raise newException(OSError, "OS not supported.")

    deallocCStringArray(c_params)
