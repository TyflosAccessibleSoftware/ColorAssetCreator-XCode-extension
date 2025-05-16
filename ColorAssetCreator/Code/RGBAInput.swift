import SwiftUI

struct RGBAInput: View {
    @Binding var red: Double
    @Binding var green: Double
    @Binding var blue: Double
    @Binding var alpha: Double
    var label: String
    var display: Color
    
    var body: some View {
        GroupBox(label: Text(label)) {
            VStack(alignment: .leading) {
                
                HStack {
                    Rectangle()
                        .fill(display)
                        .frame(width: 200, height: 30)
                        .border(.black, width: 3)
                        .accessibilityAddTraits(.isImage)
                        .accessibilityLabel(AXNameFromColor(display.cgColor ?? CGColor.black))
                    
                    Text(display.description)
                        .font(.body)
                }
                
                HStack {
                    Text("Red")
                    Slider(value: $red, in: 0.0...1.0, step: 0.05)
                    Text(String(format: "%.2f", red))
                        .frame(width: 50, alignment: .trailing)
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Text("Green")
                    Slider(value: $green, in: 0.0...1.0, step: 0.05)
                    Text(String(format: "%.2f", green))
                        .frame(width: 50, alignment: .trailing)
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Text("Blue")
                    Slider(value: $blue, in: 0.0...1.0, step: 0.05)
                    Text(String(format: "%.2f", blue))
                        .frame(width: 50, alignment: .trailing)
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Text("Alpha")
                    Slider(value: $alpha, in: 0.0...1.0, step: 0.05)
                    Text(String(format: "%.2f", alpha))
                        .frame(width: 50, alignment: .trailing)
                }
                .accessibilityElement(children: .combine)
            }
        }
        .padding(.vertical)
    }
}
