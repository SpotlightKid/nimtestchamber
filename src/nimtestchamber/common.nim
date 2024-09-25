import std/[paths, posix]


when defined(windows):
    proc win_execv*(path: cstring, params: cstringArray): int64 {.importc: "_execv", header: "<process.h>", sideEffect.}


proc exec*(path: string, params: seq[string]) =
    var c_params = allocCStringArray(@[string(Path(path).splitFile().name)] & params)

    when defined(posix):
        discard execv(path.cstring, c_params)
    elif defined(windows):
        discard win_execv(path.cstring, c_params)
    else:
        raise newException(OSError, "OS not supported.")

    deallocCStringArray(c_params)
