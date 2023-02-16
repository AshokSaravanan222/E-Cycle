//import AVFoundation
//import SwiftUI
//
//class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
//    
//    @Published var isTaken = false
//
//    @Published var session = AVCaptureSession()
//
//    @Published var alert = false
//
//    // since were going to read pic data
//    @Published var output = AVCapturePhotoOutput()
//
//    //preview..
//    @Published var preview : AVCaptureVideoPreviewLayer!
//
//    @Published var picData = Data(count: 0)
//
//    func Check(){
//        // first checking cameras got permission
//        switch AVCaptureDevice.authorizationStatus(for: .video){
//        case .authorized:
//            setUp()
//            return
//            // Setting Up Session
//        case .notDetermined:
//            //retrusting for permission...
//            AVCaptureDevice.requestAccess(for: .video) { (status) in
//
//                if status {
//                    self.setUp()
//                }
//            }
//        case .denied:
//            self.alert.toggle()
//            return
//        default:
//            return
//        }
//    }
//
//    func setUp() {
//        //setting up camera...
//
//        do{
//            //setting configs...
//            self.session.beginConfiguration()
//
//            // change for your own...
//
//            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
//
//            let input = try AVCaptureDeviceInput(device: device!)
//
//            // checking and adding to session...
//
//            if self.session.canAddInput(input){
//                self.session.addInput(input)
//            }
//
//            //same for output...
//
//            if self.session.canAddOutput(self.output){
//                self.session.addOutput(self.output)
//            }
//
//            self.session.commitConfiguration()
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    // take and retake function...
//
//    func takePic() {
//        DispatchQueue.global(qos: .background).async {
//            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
//            self.session.stopRunning()
//
//            DispatchQueue.main.async {
//                withAnimation{self.isTaken.toggle()}
//            }
//        }
//
//    }
//
//    func reTake() {
//
//        DispatchQueue.global(qos: .background).async {
//            self.session.startRunning()
//
//            DispatchQueue.main.async {
//                withAnimation{self.isTaken.toggle()}
//            }
//        }
//
//    }
//
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//            if error != nil {
//                return
//            }
//
//            print("pic taken")
//
//        guard let imageData = photo.fileDataRepresentation() else{return}
//
//        self.picData = imageData
//
//        }
//
//}
//
//struct CameraPreview: UIViewRepresentable {
//
//    @ObservedObject var camera : CameraModel
//    func makeUIView (context: Context) ->  UIView {
//        let view = UIView(frame: UIScreen.main.bounds)
//
//        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
//        camera.preview.frame = view.frame
//
//        // Your own properties...
//        camera.preview.videoGravity = .resizeAspectFill
//        view.layer.addSublayer(camera.preview)
//
//        // starting session
//        camera.session.startRunning()
//
//        return view
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//
//    }
//}
//
