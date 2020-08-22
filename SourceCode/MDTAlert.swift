//
//  MDTAlert.swift
//  MDTAlertExample
//
//  Created by Matheus Cardoso Kuhn on 22/08/20.
//  Copyright © 2020 MDT. All rights reserved.
//

import UIKit

public protocol MDTAlerting: UIView {
    var isHideAnimated: Bool { get set }
    func setText(_ text: String)
    func setStyle(textColor: UIColor, font: UIFont, textAligment: NSTextAlignment)
    func setAttributedText(_ attributedText: NSAttributedString)
    func present(animated: Bool)
    func hide(animated: Bool)
}

open class MDTAlert {
    private init() {}
    
    @discardableResult
    open class func showAlert(text: String, position: AlertPosition = .top, dismissTime: TimeInterval = 3, parentView: UIView? = UIApplication.shared.keyWindow, animated: Bool = true) -> MDTAlerting {
        let view = alertConstructor(position: position, dismissTime: dismissTime, parentView: parentView)
        view.setText(text)
        view.present(animated: animated)
        return view
    }
    
    @discardableResult
    open class func showAlert(attributedText: NSAttributedString, position: AlertPosition = .top, dismissTime: TimeInterval = 3, parentView: UIView? = UIApplication.shared.keyWindow, animated: Bool = true) -> MDTAlerting {
        let view = alertConstructor(position: position, dismissTime: dismissTime, parentView: parentView)
        view.setAttributedText(attributedText)
        view.present(animated: animated)
        return view
    }
    
    open class func createAlert(text: String, position: AlertPosition = .top, dismissTime: TimeInterval = 3, parentView: UIView? = UIApplication.shared.keyWindow) -> MDTAlerting {
        let view = alertConstructor(position: position, dismissTime: dismissTime, parentView: parentView)
        view.setText(text)
        return view
    }
    
    open class func createAlert(attributedText: NSAttributedString, position: AlertPosition = .top, dismissTime: TimeInterval = 3, parentView: UIView? = UIApplication.shared.keyWindow) -> MDTAlerting {
        let view = alertConstructor(position: position, dismissTime: dismissTime, parentView: parentView)
        view.setAttributedText(attributedText)
        return view
    }
    
    private static func alertConstructor(position: AlertPosition, dismissTime: TimeInterval, parentView: UIView?) -> MDTAlerting {
        let viewModel = MDTAlertViewModel(dismissTime: dismissTime)
        return MDTAlertView(viewModel: viewModel, alertPosition: position, parentView: parentView)
    }
}
