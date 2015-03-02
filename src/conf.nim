import os, parsecfg, strutils, streams


type 
    iniConfiguration* = object of RootObj
        ClientId*: string
        ClientSecret*: string


let file = "BRPlaylistBackup.ini"
var f = newFileStream(file, fmRead)
if f != nil:
    var p: CfgParser
    open(p, f, file)
    while true:
        var e = next(p)
        case e.kind
            of cfgEof:
                echo("EOF!")
                break
            of cfgSectionStart:   ## a ``[section]`` has been parsed
                echo("new section: " & e.section)
            of cfgKeyValuePair:
                echo("key-value-pair: " & e.key & ": " & e.value)
            of cfgOption:
                echo("command: " & e.key & ": " & e.value)
            of cfgError:
                echo(e.msg)
                close(p)
            else:
                echo("cannot open: " & paramStr(1))
