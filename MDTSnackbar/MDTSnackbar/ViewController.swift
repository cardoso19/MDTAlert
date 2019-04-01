//
//  ViewController.swift
//  MDTSnackbar
//
//  Created by Matheus Cardoso kuhn on 31/03/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var buttonShowSnackbar: UIButton!

    //MARK: - Variables
    var snackbar: MDTSnackbar?

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        snackbar = MDTSnackbar(cornerRadius: 6.0, dismissTime: 3.0)
        snackbar?.style(backgroundColor: .red,
                        font: UIFont.systemFont(ofSize: 14),
                        textColor: .black)
        snackbar?.labelMessage?.text = "Test Message"
    }
    
    //MARK: - IBActions
    @IBAction func actionShow(_ sender: UIButton) {
        snackbar?.present()
    }
}

