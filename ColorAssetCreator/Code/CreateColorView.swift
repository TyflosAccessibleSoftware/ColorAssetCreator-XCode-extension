import SwiftUI
import AppKit

struct CreateColorView: View {
    @State var viewModel = CreateColorViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create Color Asset").font(.title2).padding(.bottom)
                .accessibilityAddTraits(.isHeader)
            
            HStack {
                Text("Color name").accessibilityHidden(true)
                TextField("", text: $viewModel.colorName)
                    .accessibilityLabel("Color name")
                Spacer()
            }
            .padding()
            
            
            
            HStack {
                Text("Path").accessibilityHidden(true)
                TextField("to Assets.xcassets", text: $viewModel.assetPath)
                    .accessibilityLabel("Path to Assets.xcassets")
                
                Button(action: { selectFolder() }) {
                    Image(systemName: "folder")
                        .imageScale(.large)
                        .accessibilityLabel("Open folder explorer")
                }
                .buttonStyle(.plain)
                .help("Find the folder for the Assets catalog of your Xcode Project")
                .padding(4)
                Spacer()
            }
            .padding()
            
            RGBAInput(red: $viewModel.lightRed, green: $viewModel.lightGreen, blue: $viewModel.lightBlue, alpha: $viewModel.lightAlpha, label: "Light Mode", display: viewModel.colorLight)
            
            Toggle("Support Dark Mode", isOn: $viewModel.enableDarkMode)
            
            if viewModel.enableDarkMode {
                RGBAInput(red: $viewModel.darkRed, green: $viewModel.darkGreen, blue: $viewModel.darkBlue, alpha: $viewModel.darkAlpha, label: "Dark Mode", display: viewModel.colorDark)
            }
            
            Button("Create Color Asset") {
                viewModel.createColor()
            }
            .padding(.vertical)
            
            Text(viewModel.statusMessage)
                .foregroundColor(.green)
                .font(.footnote)
        }
        .padding()
        .frame(width: 400)
    }
    
    private func selectFolder() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false
        panel.prompt = "Select"
        
        if panel.runModal() == .OK {
            if let url = panel.url {
                viewModel.assetPath = url.path
                                viewModel.selectedURL = url
            }
        }
    }
}

#Preview {
    CreateColorView()
}
