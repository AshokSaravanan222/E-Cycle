import SwiftUI

struct ContentView: View {
    
    @StateObject var camera = ViewController()
    @EnvironmentObject var sheetManager: SheetManager
    
    var body: some View {
        HostedViewController(view: camera)
        SubViews(camera: camera)
//        ZStack {
//
//            Color
//                .mint
//                .ignoresSafeArea()
//            Button("Show Custom Sheet") {
//                withAnimation(.spring()) {
//                    sheetManager.present(with: .init(item: items[20]))
//                }
//            }
//        }
//        .popup(with: sheetManager)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SheetManager())
    }
}
