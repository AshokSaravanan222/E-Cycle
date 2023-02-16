//
//  Classifier.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 2/16/23.
//

import Foundation
import CoreML

extension ViewController {
    
    func classify() -> Int {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            print("waited 2 seconds")
        }
        return 1
    }
    
}
