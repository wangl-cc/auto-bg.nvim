/*
A simple Swift script that prints "dark" or "light" to stdout when the macOS
dark mode is toggled.
Copyright (C) 2023 Loong Wang

Based on [bouk/dark-mode-notify](https://github.com/bouk/dark-mode-notify/blob/4d7fe211f81c5b67402fad4bed44995344a260d1/main.swift),
[MIT licensed](https://github.com/bouk/dark-mode-notify/blob/4d7fe211f81c5b67402fad4bed44995344a260d1/LICENSE),
and
[vimpostor/vim-lumen](https://github.com/vimpostor/vim-lumen/blob/b183859510bebfc9062caf300e24c707a5fe522f/autoload/lumen/platforms/macos/watcher.swift),
[GPLv3
licensed](https://github.com/vimpostor/vim-lumen/blob/b183859510bebfc9062caf300e24c707a5fe522f/LICENSE.txt).
*/

import Cocoa

setbuf(stdout, nil)

func notify() {
    if UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark" {
        print("dark")
    } else {
        print("light")
    }
}

if CommandLine.arguments.dropFirst(1).first == "oneshot" {
    notify()
    exit(0)
}

DistributedNotificationCenter.default.addObserver(
    forName: Notification.Name("AppleInterfaceThemeChangedNotification"),
    object: nil,
    queue: nil) { (notification) in notify() }

NSWorkspace.shared.notificationCenter.addObserver(
    forName: NSWorkspace.didWakeNotification,
    object: nil,
    queue: nil) { (notification) in notify() }

NSApplication.shared.run()
