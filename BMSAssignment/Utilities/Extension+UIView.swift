//
//  Extension+UIView.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 17/05/21.
//

import Foundation
import UIKit

extension UIView {
    
    func addBorderLayerAndCornerRadius(color: UIColor){
        self.layer.borderWidth = 0.5
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = 10
    }
}
// end of extension
