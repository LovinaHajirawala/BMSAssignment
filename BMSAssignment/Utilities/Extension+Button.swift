//
//  Extension+Button.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 22/05/21.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    var action: (() -> Void)?

    func whenButtonIsClicked(action: @escaping () -> Void) {
        self.action = action
        self.addTarget(self, action: #selector(CustomButton.clicked), for: .touchUpInside)
    }

    // Button Event Handler:
    @objc func clicked() {
        action?()
    }
}
