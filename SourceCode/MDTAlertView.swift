//
//  MDTAlertView.swift
//  MDTAlert
//
//  Created by Matheus Cardoso kuhn on 31/03/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

public class MDTAlertView: UIView {

    //MARK: - AlertPostion
    public enum AlertPosition {
        case top
        case bottom
    }
    
    //MARK: - Visual Components
    private var labelMessage: UILabel!

    //MARK: - Variables
    private var viewModel: MDTAlertViewViewModel!
    private var horizontalConstraint: NSLayoutConstraint?

    //MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        fatalError("This was not implemented")
    }
    
    init(message: String, position: AlertPosition, dismissTime: TimeInterval) {
        super.init(frame: CGRect.zero)
        viewModel = MDTAlertViewViewModel(dismissTime: dismissTime, alertPosition: position)
        frame = viewModel.generateRect(withWidth: UIScreen.main.bounds.width)
        translatesAutoresizingMaskIntoConstraints = false
        createLabelMessage(with: message)
        configCorners(with: 6.0)
        configGestureRecognizer()
    }
    
    private func createLabelMessage(with message: String) {
        labelMessage = UILabel()
        labelMessage.text = message
        labelMessage.translatesAutoresizingMaskIntoConstraints = false
        labelMessage.numberOfLines = 0
        addSubview(labelMessage)
        configConstraints(of: labelMessage)
        configLabelCompressResistence()
    }
    
    private func configCorners(with cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    private func configGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hide))
        addGestureRecognizer(tapRecognizer)
    }
    
    private func configLabelCompressResistence() {
        labelMessage.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    //MARK: - Constraints
    private func configViewConstraints(onView view: UIView) {
        createMarginConstraint(on: self,
                               attribute: .left,
                               to: view,
                               constant: viewModel.margin)
        createMarginConstraint(on: self,
                               attribute: .right,
                               to: view,
                               constant: -viewModel.margin)
        configViewVerticalConstraint(onView: view)
    }
    
    private func configViewVerticalConstraint(onView view: UIView) {
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            switch viewModel.alertPosition {
            case .top:
                horizontalConstraint = topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0)
            case .bottom:
                horizontalConstraint = bottomAnchor.constraint(equalToSystemSpacingBelow: guide.bottomAnchor, multiplier: 1.0)
            }
        } else {
            switch viewModel.alertPosition {
            case .top:
                horizontalConstraint = topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0)
            case .bottom:
                horizontalConstraint = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
            }
        }
        horizontalConstraint?.constant = viewModel.calculateOutScreenPosition(withHeight: bounds.size.height)
        if let topConstraint = horizontalConstraint {
            NSLayoutConstraint.activate([topConstraint])
        }
    }

    private func configConstraints(of label: UILabel) {
        createMarginConstraint(on: label,
                               attribute: .left,
                               to: self,
                               constant: viewModel.contentMargin)
        createMarginConstraint(on: label,
                               attribute: .right,
                               to: self,
                               constant: -viewModel.contentMargin)
        createMarginConstraint(on: label,
                               attribute: .top,
                               to: self,
                               constant: viewModel.contentMargin)
        createMarginConstraint(on: label,
                               attribute: .bottom,
                               to: self,
                               constant: -viewModel.contentMargin)
    }
    
    private func createMarginConstraint(on item: Any, attribute: NSLayoutConstraint.Attribute, to item2: Any, constant: CGFloat) {
        NSLayoutConstraint(item: item,
                           attribute: attribute,
                           relatedBy: .equal,
                           toItem: item2,
                           attribute: attribute,
                           multiplier: 1,
                           constant: constant).isActive = true
    }

    //MARK: - Presentation Controls
    private func scheduledHide() {
        DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.dismissTime) { [weak self] in
            self?.hide()
        }
    }

    public func style(backgroundColor color: UIColor, font: UIFont, textColor: UIColor) {
        backgroundColor = color
        labelMessage.font = font
        labelMessage.textColor = textColor
    }
    
    public func present() {
        UIApplication.shared.keyWindow?.addSubview(self)
        if let keyWindow = UIApplication.shared.keyWindow {
            configViewConstraints(onView: keyWindow)
        }
        UIApplication.shared.keyWindow?.layoutIfNeeded()
        horizontalConstraint?.constant = viewModel.calculateInScreenPosition()
        UIView.animate(withDuration: viewModel.defaultAnimationTime, animations: {
            UIApplication.shared.keyWindow?.layoutIfNeeded()
        }) { [weak self] _ in
            self?.scheduledHide()
        }
    }

    @objc public func hide() {
        horizontalConstraint?.constant = viewModel.calculateOutScreenPosition(withHeight: self.bounds.size.height)
        UIView.animate(withDuration: viewModel.defaultAnimationTime, animations: {
            UIApplication.shared.keyWindow?.layoutIfNeeded()
        }) { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
}
