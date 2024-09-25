## Put your tests here.

import std/[osproc, strformat, strutils, unittest]

let cmd = when defined(windows):
    "nimtestchamber.exe"
else:
    "nimtestchamber"

test "Run nimbletestchamber command":
    var (output, status) = execCmdEx(&"bin/{cmd} foo bar")
    check status == 0
    output.stripLineEnd()
    check output == "foo bar"
