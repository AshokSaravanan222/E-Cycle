import Vision
import AVFoundation
import UIKit
import SwiftUI

extension ViewController {
    
    func setupDetector() {
        let modelURL = Bundle.main.url(forResource: "YOLOv3TinyInt8LUT", withExtension: "mlmodelc")
    
        do {
            let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL!))
            let recognitions = VNCoreMLRequest(model: visionModel, completionHandler: detectionDidComplete)
            self.requests = [recognitions]
        } catch let error {
            print(error)
        }
    }
    
    func detectionDidComplete(request: VNRequest, error: Error?) {
        DispatchQueue.main.async(execute: {
            if let results = request.results {
                self.extractDetections(results)
            }
        })
    }
    
    func extractDetections(_ results: [VNObservation]) {
        detectionLayer.sublayers = nil
        
        let screenBounds = self.screenRect.insetBy(dx: 12, dy: 12)
        var biggestBounds = CGRect()
        
        for observation in results where observation is VNRecognizedObjectObservation {
            guard let objectObservation = observation as? VNRecognizedObjectObservation else { continue }
            
            // Transformations
            let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(screenRect.size.width), Int(screenRect.size.height))
            let transformedBounds = CGRect(x: objectBounds.minX, y: screenRect.size.height - objectBounds.maxY, width: objectBounds.maxX - objectBounds.minX, height: objectBounds.maxY - objectBounds.minY)
            
            //TODO: insert code to skip if not at the edge. Add all areas to a new list and find the max. set it to old variable
            
            if (screenBounds.contains(transformedBounds) && (transformedBounds.height * transformedBounds.height > 1500)) {
                if ((transformedBounds.height * transformedBounds.width) > (biggestBounds.height * biggestBounds.width)) {
                    biggestBounds = transformedBounds
                }
                
            }
            
        }
        
        if !(biggestBounds.isEmpty) {
            self.lastBounds = biggestBounds
            framesWithoutDetection = 0
        } else {
            if (framesWithoutDetection > 10) {
                self.lastBounds = CGRect()
            } else {
                self.framesWithoutDetection += 1
            }
        }
        
        let boxLayer = self.drawBoundingBox(self.lastBounds.insetBy(dx: -12, dy: -12))
//        print(boxLayer)
//        print(self.lastBounds.width * self.lastBounds.height)
        detectionLayer.addSublayer(boxLayer)
    }
    
    func setupLayers() {
        detectionLayer = CALayer()
        detectionLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
        self.view.layer.addSublayer(detectionLayer)
    }
    
    func updateLayers() {
        detectionLayer?.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
    }
    
    func drawBoundingBox(_ bounds: CGRect) -> CALayer {
        let boxLayer = CALayer()
        boxLayer.frame = bounds
        boxLayer.borderWidth = 6.0
        boxLayer.borderColor = CGColor.init(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        boxLayer.borderColor = CGColor.init(red: 0.62, green: 0.91, blue: 0.54, alpha: 1.0)
        boxLayer.cornerRadius = 15
        return boxLayer
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:]) // Create handler to perform request on the buffer

        do {
            try imageRequestHandler.perform(self.requests) // Schedules vision requests to be performed
        } catch {
            print(error)
        }
    }
}
