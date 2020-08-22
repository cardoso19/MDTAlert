//
//  ViewController.swift
//  MDTAlertExample
//
//  Created by Matheus Cardoso kuhn on 17/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var messageTextField: UITextField! {
        didSet {
            defaultMessage = messageTextField.text ?? ""
        }
    }
    
    // MARK: - Variables
    private var message: String {
        return messageTextField.text ?? ""
    }
    private var defaultMessage = ""
    private var functionIntex = 0
    private lazy var functions: [(AlertPosition) -> Void] = [
        self.createAndPresentAlertWithText,
        self.createAndPresentAlertWithAttributedText,
        self.presentAlertWithText,
        self.presentAlertWithAttributedText
    ]
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func getExampleAlert(alertPosition: AlertPosition) {
        if functionIntex >= functions.count {
            functionIntex = 0
        }
        functions[functionIntex](alertPosition)
        functionIntex += 1
    }
    
    // MARK: - Examples
    private func createAndPresentAlertWithAttributedText(alertPosition: AlertPosition) {
        let attributes: [NSAttributedString.Key : Any]? = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.white
        ]
        let attributedText = NSAttributedString(string: message, attributes: attributes)
        let alert = MDTAlert.createAlert(attributedText: attributedText, position: alertPosition)
        alert.backgroundColor = .red
        alert.present(animated: true)
    }
    
    private func createAndPresentAlertWithText(alertPosition: AlertPosition) {
        let alert = MDTAlert.createAlert(text: message, position: alertPosition)
        alert.setStyle(textColor: .white, font: UIFont.systemFont(ofSize: 22), textAligment: .center)
        alert.backgroundColor = .black
        alert.present(animated: true)
    }
    
    private func presentAlertWithAttributedText(alertPosition: AlertPosition) {
        let attributes: [NSAttributedString.Key : Any]? = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.green
        ]
        let attributedText = NSAttributedString(string: message, attributes: attributes)
        MDTAlert.showAlert(attributedText: attributedText, position: alertPosition)
    }
    
    private func presentAlertWithText(alertPosition: AlertPosition) {
        MDTAlert.showAlert(text: message, position: alertPosition)
    }
    
    
    //MARK: - IBActions
    @IBAction func actionShowAlertTop(_ sender: UIButton) {
        getExampleAlert(alertPosition: .top)
    }
    
    @IBAction func actionShowAlertBottom(_ sender: UIButton) {
        getExampleAlert(alertPosition: .bottom)
    }
}

