import std/[paths, posix]


proc exec*(path: string, params: seq[string]) =
    when defined(posix):
        var c_params = allocCStringArray(@[string(Path(path).splitFile().name)] & params)
        discard execv(path.cstring, c_params)
        deallocCStringArray(c_params)
    else:
        raise newException(OSError, "OS not supported.")