import SwiftUI

@Observable
final class CreateColorViewModel {
    var assetPath: String = ""
    var urlPath: URL?
    var colorName: String = ""
    var colorLight: Color = .white
    var lightRed = 1.0 { didSet { updateColorDisplay() } }
    var lightGreen = 1.0 { didSet { updateColorDisplay() } }
    var lightBlue = 1.0 { didSet { updateColorDisplay() } }
    var lightAlpha = 1.0 { didSet { updateColorDisplay() } }
    var enableDarkMode = false
    var colorDark: Color = .black
    var darkRed = 0.0 { didSet { updateColorDisplay() } }
    var darkGreen = 0.0 { didSet { updateColorDisplay() } }
    var darkBlue = 0.0 { didSet { updateColorDisplay() } }
    var darkAlpha = 1.0 { didSet { updateColorDisplay() } }
    
    var statusMessage: String = ""
    
    func createColor() {
        guard !colorName.isEmpty else {
            setStatus("⚠️ Warning: color name field is empty.")
            return
        }
        guard !assetPath.isEmpty else {
            setStatus("⚠️ Warning: Path to Assets.xcassets field is empty.")
            return
        }
        let fm = FileManager.default
        let colorDir = URL(fileURLWithPath: assetPath)
            .appendingPathComponent("\(colorName).colorset")
        colorDir.startAccessingSecurityScopedResource()
        do {
            try fm.createDirectory(at: colorDir, withIntermediateDirectories: true)
            var colors: [[String: Any]] = [
                [
                    "idiom": "universal",
                    "color": [
                        "color-space": "srgb",
                        "components": [
                            "red": lightRed,
                            "green": lightGreen,
                            "blue": lightBlue,
                            "alpha": lightAlpha
                        ]
                    ]
                ]
            ]
            
            if enableDarkMode {
                colors.append([
                    "idiom": "universal",
                    "appearances": [
                        [
                            "appearance": "luminosity",
                            "value": "dark"
                        ]
                    ],
                    "color": [
                        "color-space": "srgb",
                        "components": [
                            "red": darkRed,
                            "green": darkGreen,
                            "blue": darkBlue,
                            "alpha": darkAlpha
                        ]
                    ]
                ])
            }
            
            let contents: [String: Any] = [
                "info": [
                    "version": 1,
                    "author": "xcode"
                ],
                "colors": colors
            ]
            
            let jsonData = try JSONSerialization.data(withJSONObject: contents, options: .prettyPrinted)
            let fileURL = colorDir.appendingPathComponent("Contents.json")
            fileURL.startAccessingSecurityScopedResource()
            try jsonData.write(to: fileURL)
            fileURL.stopAccessingSecurityScopedResource()
            colorDir.stopAccessingSecurityScopedResource()
            setStatus("✅ Color asset created!")
        } catch {
            setStatus("❌ Error: \(error.localizedDescription)")
        }
    }
    
    private func setStatus(_ text: String) {
        statusMessage = text
        AccessibilityNotification.Announcement(text).post()
    }
    
    private func updateColorDisplay() {
        colorLight = Color(red: lightRed, green: lightGreen, blue: lightBlue, opacity: lightAlpha)
        colorDark = Color(red: darkRed, green: darkGreen, blue: darkBlue, opacity: darkAlpha)
    }
}
