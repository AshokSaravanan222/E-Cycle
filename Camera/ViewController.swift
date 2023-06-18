import SwiftUI
import AVFoundation
import Vision

class ViewController: UIViewController,ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate {
    private var permissionGranted = false // Flag for permission
    private var captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    private var previewLayer = AVCaptureVideoPreviewLayer()
    var screenRect: CGRect! = nil // For view dimensions


    // Detector
    private var videoOutput = AVCaptureVideoDataOutput()
    var requests = [VNRequest]()
    var detectionLayer: CALayer! = nil
    var lastBounds = CGRect()
    var framesWithoutDetection = 0

    // Camera
    var cameraOutput = AVCapturePhotoOutput()
    var picData = Data(count: 0)
    
    //Classifier
    @Published var stringClassification = ""
    @Published var lastPrediction : String? = nil
    @Published var predictionLabel = UILabel()
    @State var predictionComplete = false
    let imagePredictor = ImagePredictor()
    
    //Camera View
    @Published var display = true
    @Published var loading = false
    @Published var classification = 0
    @Published var needsTip = false
    @Published var displayImage = UIImage()
    
    


    override func viewDidLoad() {
        checkPermission()
        sessionQueue.async { [unowned self] in
            guard permissionGranted else { return }
            self.setupCaptureSession()

            self.setupLayers()
            self.setupDetector()

            self.captureSession.startRunning()
        }
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        screenRect = UIScreen.main.bounds
        self.previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)

        switch UIDevice.current.orientation {
            // Home button on top
        case UIDeviceOrientation.portraitUpsideDown:
            self.previewLayer.connection?.videoOrientation = .portraitUpsideDown

            // Home button on right
        case UIDeviceOrientation.landscapeLeft:
            self.previewLayer.connection?.videoOrientation = .landscapeRight

            // Home button on left
        case UIDeviceOrientation.landscapeRight:
            self.previewLayer.connection?.videoOrientation = .landscapeLeft

            // Home button at bottom
        case UIDeviceOrientation.portrait:
            self.previewLayer.connection?.videoOrientation = .portrait

        default:
            break
        }

        // Detector
        updateLayers()
    }

    func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            // Permission has been granted before
        case .authorized:
            permissionGranted = true

            // Permission has not been requested yet
        case .notDetermined:
            requestPermission()

        default:
            permissionGranted = false
        }
    }

    func requestPermission() {
        sessionQueue.suspend()
        AVCaptureDevice.requestAccess(for: .video) { [unowned self] granted in
            self.permissionGranted = granted
            self.sessionQueue.resume()
        }
    }

    func stopFeed() {
        sessionQueue.async {
            self.cameraOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        }
    }
    
    func startFeed() {
        sessionQueue.async {
            self.captureSession.startRunning()
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil {
            return
        }

        sessionQueue.async {
            self.captureSession.stopRunning()
        }
        
        if loading {
            processPhoto(photo: photo)
        }
        
    }
    
    func processPhoto(photo: AVCapturePhoto) {
        print("pic taken")
        guard let imageData = photo.fileDataRepresentation() else {return}
        self.picData = imageData
       
        
        self.classification = self.classify() // TODO: add method to classify
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.loading.toggle()
        }
    }



    func setupCaptureSession() {
        // Camera input
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,for: .video, position: .back) else { return }
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }

        guard captureSession.canAddInput(videoDeviceInput) else { return }
        captureSession.addInput(videoDeviceInput)

        //Camera
        guard captureSession.canAddOutput(cameraOutput) else { return }
        captureSession.addOutput(cameraOutput)

        // Preview layer
        screenRect = UIScreen.main.bounds

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill // Fill screen
        previewLayer.connection?.videoOrientation = .portrait

        // Detector
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))
        captureSession.addOutput(videoOutput)
        videoOutput.connection(with: .video)?.videoOrientation = .portrait

        // Updates to UI must be on main queue
        DispatchQueue.main.async { [weak self] in
            self!.view.layer.addSublayer(self!.previewLayer)
            self!.view.layer.addSublayer(self!.detectionLayer)
        }
    }


}

struct HostedViewController: UIViewControllerRepresentable {
    
    var view: ViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    
    
}

