//
//  Extension+UIViewController.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 17/05/21.
//

import Foundation
import UIKit

extension UIViewController {
   
    func presentViewController(vcIdentifier: String){
        let storyboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: vcIdentifier)
        self.present(vc, animated: true, completion: nil)
    }
    
    func presentAlertViewController(msg: String){
        let alert = UIAlertController(title: BMS_TITLE, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            @unknown default:
                print("destructive")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
// end of extension
