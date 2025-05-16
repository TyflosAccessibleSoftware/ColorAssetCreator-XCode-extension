import Foundation
import XcodeKit
import SwiftUI
import AppKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        DispatchQueue.main.async {
            let view = CreateColorView()
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 420, height: 600),
                styleMask: [.titled, .closable, .resizable],
                backing: .buffered, defer: false)
            window.center()
            window.title = "Color Asset Creator"
            window.contentView = NSHostingView(rootView: view)
            window.makeKeyAndOrderFront(nil)
        }
        completionHandler(nil)
    }
}
