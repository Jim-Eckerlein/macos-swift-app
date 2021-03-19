import AppKit

var running = true

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSLog("start app")
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        NSLog("applicationWillTerminate")
        running = false
    }
}

class WindowDelegate: NSObject, NSWindowDelegate {
    func windowDidResize(_ notification: Notification) {
        NSLog("windowDidResize")
    }
    
    func windowWillClose(_ notification: Notification) {
        NSLog("windowWillClose")
        running = false
    }
}

let app = NSApplication.shared
let appDelegate = AppDelegate()
app.delegate = appDelegate
app.setActivationPolicy(.regular)

let window = NSWindow(contentRect: NSMakeRect(0, 0, 1024, 768),
                      styleMask: [.closable, .titled, .resizable, .miniaturizable],
                      backing: .buffered,
                      defer: true)

let windowDelegate = WindowDelegate()
window.delegate = windowDelegate
window.title = "Hey, Window under control!"
window.acceptsMouseMovedEvents = true
window.center()
window.makeKeyAndOrderFront(nil)
window.orderFrontRegardless()

app.activate(ignoringOtherApps: true)

while(running) {
    var ev: NSEvent?
    ev = app.nextEvent(matching: .any, until: nil, inMode: .default, dequeue: true)
    if (ev != nil) {
        NSLog("%@", ev!)
        app.sendEvent(ev!)
    }
}

app.terminate(nil)
