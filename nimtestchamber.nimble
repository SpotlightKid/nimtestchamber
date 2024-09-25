version     = "0.2.0"
author      = "Christopher Arndt"
description = "A test chamber for experimenting with Nim projects"
license     = "MIT"

srcDir = "src"

requires "nim >= 2.0.0"

bin = @["nimtestchamber"]

binDir = "bin"

before test:
    exec("nimble build")
