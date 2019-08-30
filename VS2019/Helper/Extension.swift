//
//  Extension.swift
//  VS2019
//
//  Created by Quân Đinh on 30.08.19.
//  Copyright © 2019 Quân Đinh. All rights reserved.
//

import Foundation

extension String {
    func convertToInt8() -> Int8 {
        if let number = Int8(self) {
            return number
        } else {
            return 0
        }
    }
    
    func convertToDouble() -> Double {
        if let number = Double(self) {
            return number
        } else {
            return 0
        }
    }
}

