//
//  AlertManager.swift
//  AlertManager-Tutorial
//
//  Created by YouTube on 2023-04-30.
//

import UIKit

class AlertManager {
    
    private static func showTextAlert(on vc: UIViewController, with title: String, with message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    public static func showNoWifiWarning(on vc: UIViewController) {
        self.showTextAlert(on: vc, with: "No Wifi", with: "You have now wifi")
    }
}


// MARK: - Button Alerts
extension AlertManager {
    
    private static func showButtonAlert(on vc: UIViewController,
                                        title: String,
                                        message: String? = nil,
                                        button1: UIAlertAction,
                                        button2: UIAlertAction) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(button1)
        alert.addAction(button2)
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
    static func showDeleteConfirmation(on vc: UIViewController, completion: @escaping (Bool) -> Void) {
        
        let button1 = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(false)
        }
        
        let button2 = UIAlertAction(title: "Delete", style: .destructive) { _ in
            completion(true)
        }
        
        self.showButtonAlert(on: vc, title: "Delete Post", message: nil, button1: button1, button2: button2)
    }
    
    static func showStartWorkoutAlert(on vc: UIViewController, completion: @escaping (Bool) -> Void) {
        let button1 = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(false)
        }
        let button2 = UIAlertAction(title: "Start", style: .default) { _ in
            completion(true)
        }
        self.showButtonAlert(on: vc, title: "Start Workout?", message: nil, button1: button1, button2: button2)
    }
}


// MARK: - TextField Alerts
extension AlertManager {
    
    private static func showTextFieldAlert(on vc: UIViewController,
                                           title: String,
                                           message: String? = nil,
                                           textFields: [(UITextField) -> Void],
                                           completion: @escaping ([String]) -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        textFields.forEach({ alert.addTextField(configurationHandler: $0) })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            completion([])
        }))
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            var strings: [String] = []
            for textField in alert.textFields ?? [] {
                if let text = textField.text, !text.isEmpty { strings.append(text) }
            }
            completion(strings)
        }))
        
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
    
    static func signInAlert(on vc: UIViewController,
                            completion: @escaping ([String]) -> Void) {
        
        var textFields: [(UITextField) -> ()] = []
        
        textFields.append { (textField) in
            textField.placeholder = "Username"
            textField.autocapitalizationType = .words
        }
        
        textFields.append { (textField) in
            textField.placeholder = "Password"
            textField.autocapitalizationType = .words
            textField.isSecureTextEntry = true
        }

        self.showTextFieldAlert(on: vc, title: "Sign In", message: nil, textFields: textFields, completion: completion)
    }
}
