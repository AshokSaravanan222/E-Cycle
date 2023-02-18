import SwiftUI

struct ContentView: View {
    
    @StateObject var camera = ViewController()
    
    var body: some View {
        ZStack {
            HostedViewController(view: camera)
                .ignoresSafeArea()
            CameraView(camera: camera)
                .environmentObject(SheetManager())
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
