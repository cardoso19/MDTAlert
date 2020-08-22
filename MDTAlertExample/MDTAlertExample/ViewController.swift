//
//  ViewController.swift
//  MDTAlertExample
//
//  Created by Matheus Cardoso kuhn on 17/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IBActions
    @IBAction func actionShowAlertTop(_ sender: UIButton) {
        let message = "This is a test message of the alert on the top of the screen"
        let alert = MDTAlert.createAlert(message: message, position: .top)
        alert.backgroundColor = .black
        alert.setStyle(textColor: .white, font: UIFont.systemFont(ofSize: 22), textAligment: .center)
        alert.present(animated: true)
    }
    
    @IBAction func actionShowAlertBottom(_ sender: UIButton) {
        let message = "This is a test message of the alert on the bottom of the screen"
        let alert = MDTAlert.createAlert(message: message, position: .bottom)
        alert.backgroundColor = .black
        alert.setStyle(textColor: .white, font: UIFont.systemFont(ofSize: 22), textAligment: .center)
        alert.present(animated: true)
    }
}

