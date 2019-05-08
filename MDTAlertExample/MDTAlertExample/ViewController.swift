//
//  ViewController.swift
//  MDTAlertExample
//
//  Created by Matheus Cardoso kuhn on 17/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: - IBActions
    @IBAction func actionShowAlertTop(_ sender: UIButton) {
        let alertView = MDTAlertView(message: "This is a test message of the alert on the top of the screen",
                                     position: .top,
                                     dismissTime: 3.0)
        alertView.style(backgroundColor: .red,
                        font: UIFont.systemFont(ofSize: 16),
                        textColor: .white)
        alertView.present()
    }
    
    @IBAction func actionShowAlertBottom(_ sender: UIButton) {
        let alertView = MDTAlertView(message: "This is a test message of the alert on the bottom of the screen",
                                     position: .bottom,
                                     dismissTime: 3.0)
        alertView.style(backgroundColor: .black,
                        font: UIFont.systemFont(ofSize: 22),
                        textColor: .white)
        alertView.present()
    }
}

