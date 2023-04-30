//
//  ViewController.swift
//  AlertManager-Tutorial
//
//  Created by YouTube on 2023-04-30.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "4", style: .plain, target: self, action: #selector(didTapFour)),
            UIBarButtonItem(title: "3", style: .plain, target: self, action: #selector(didTapThree)),
            UIBarButtonItem(title: "2", style: .plain, target: self, action: #selector(didTapTwo)),
            UIBarButtonItem(title: "1", style: .plain, target: self, action: #selector(didTapOne)),
        ]
    }
    
    @objc private func didTapOne() {
        AlertManager.showNoWifiWarning(on: self)
    }
    
    @objc private func didTapTwo() {
        AlertManager.showDeleteConfirmation(on: self) { confirmed in
            if confirmed {
                print("Deleted")
            } else {
                print("Canceled")
            }
        }
    }
    
    @objc private func didTapThree() {
        AlertManager.showStartWorkoutAlert(on: self) { started in
            print(started)
        }
    }
    
    @objc private func didTapFour() {
        AlertManager.signInAlert(on: self) { strings in
            guard strings.count == 2 else { return }
            strings.forEach({ print($0) })
        }
    }
}
