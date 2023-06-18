//
//  Classifier.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 2/16/23.
//

import Foundation
import CoreML
import SwiftUI
import AVFoundation
import Vision

extension ViewController {
    
    func scaleImage(_ image: UIImage, to size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        let scaledImage = renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
        return scaledImage
    }
    
    func cropImage(image: UIImage, rect: CGRect) -> UIImage {
        if !(rect.isEmpty) {
            let cgImage = image.cgImage!// better to write "guard" in realm app
            
            let factor = CGFloat(cgImage.width)/image.size.width
            let transformedRect = CGRect(x: rect.origin.x * factor, y: rect.origin.y * factor, width: rect.width * factor, height: rect.height * factor)
            
            let croppedCGImage = cgImage.cropping(to: transformedRect)
            
            
            return UIImage(cgImage: croppedCGImage!)
        } else {
            return image
        }
        
    }
    
    
    func adjustBounds(rect: CGRect, screenBounds: CGSize) -> CGRect {
        
        var newRect = CGRect()
        
        if (rect.width > rect.height) {
            let dy = ((rect.width - rect.height) / 2)
            
            if (rect.minY - dy < 0) || (rect.width > screenBounds.height) {
                newRect = CGRect(x: rect.minX, y: 0, width: rect.width, height: screenBounds.height)
            } else {
                newRect = CGRect(x: rect.minX, y: rect.minY - dy, width: rect.width, height: rect.width)
            }
            
        } else if (rect.height > rect.width) {
            
            let dx = ((rect.height - rect.width) / 2)
            
            if (rect.minX - dx < 0) || (rect.height > screenBounds.width) {
                newRect = CGRect(x: 0, y: rect.minY, width: screenBounds.width, height: rect.height)
            } else {
                newRect = CGRect(x: rect.minX - dx, y: rect.minY, width: rect.height, height: rect.height)
            }
        } else {
            //nothing
        }
        
        return newRect
        
    }
    
    

    
    func classify() -> Int {
        
//        let scaledImage = UIImage(data: picData)!.scalePreservingAspectRatio(
//            targetSize: screenRect.size
//        )
        let scaledImage = scaleImage(UIImage(data: picData)!, to: screenRect.size)

        let adjustedRect = adjustBounds(rect: lastBounds, screenBounds: screenRect.size)
        
        displayImage = cropImage(image: scaledImage!, rect: adjustedRect)
        
        classifyPhoto(displayImage)
        print(stringClassification)
        
        return classification
        
    }
    
    
}

extension ViewController {

    /// Updates the storyboard's prediction label.
    /// - Parameter message: A prediction or message string.
    /// - Tag: updatePredictionLabel
    func updatePredictionLabel(_ message: String) {
        DispatchQueue.main.async {
            self.predictionLabel.text = message
        }
    }
    /// Notifies the view controller when a user selects a photo in the camera picker or photo library picker.
    /// - Parameter photo: A photo from the camera or photo library.
    func classifyPhoto(_ photo: UIImage) {
        updatePredictionLabel("Making predictions for the photo...")

        DispatchQueue.global(qos: .userInitiated).async {
            self.classifyImage(photo)
        }
    }

}


extension ViewController {
    // MARK: Image prediction methods
    /// Sends a photo to the Image Predictor to get a prediction of its content.
    /// - Parameter image: A photo.
    private func classifyImage(_ image: UIImage) {
        do {
            try self.imagePredictor.makePredictions(for: image,
                                                    completionHandler: imagePredictionHandler)
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }

    /// The method the Image Predictor calls when its image classifier model generates a prediction.
    /// - Parameter predictions: An array of predictions.
    /// - Tag: imagePredictionHandler
    private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
        guard let predictions = predictions else {
            updatePredictionLabel("No predictions. (Check console log.)")
            return
        }

        let formattedPredictions = formatPredictions(predictions)

        let predictionString = formattedPredictions.joined(separator: "\n")
        updatePredictionLabel(predictionString)
        
        DispatchQueue.main.async {
            self.classification = self.subPrediction(classification: predictions[0].classification)
        }
        
    }
    
    private func subPrediction(classification: String) -> Int {
        var ids = items.map { (item) -> Int in
            if item.category == classification {
                return item.id
            } else if item.id == 27 { //Trash
                let categories = item.category.components(separatedBy: ", ")
                if categories.contains(classification) {
                    return item.id
                } else {
                    return -1
                }
            } else {
                return -1
            }
        }
        ids = ids.filter { $0 != -1 }
        print(ids)
        return ids.randomElement() ?? 0 // will add in functionality to classify even further in next release
    }

    /// Converts a prediction's observations into human-readable strings.
    /// - Parameter observations: The classification observations from a Vision request.
    /// - Tag: formatPredictions
    private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
        // Vision sorts the classifications in descending confidence order.
        let topPredictions: [String] = predictions.prefix(1).map { prediction in
            var name = prediction.classification

            // For classifications with more than one name, keep the one before the first comma.
            if let firstComma = name.firstIndex(of: ",") {
                name = String(name.prefix(upTo: firstComma))
            }

            return "\(name) - \(prediction.confidencePercentage)%"
        }

        return topPredictions
    }
}


