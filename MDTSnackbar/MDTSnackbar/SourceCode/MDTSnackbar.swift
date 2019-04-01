//
//  MDTSnackbar.swift
//  MDTSnackbar
//
//  Created by Matheus Cardoso kuhn on 31/03/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

class MDTSnackbar: UIView {
    //MARK: - Visual Components
    public weak var labelMessage: UILabel?

    //MARK: - Constants
    fileprivate let margin: CGFloat = 10
    fileprivate let minHeight: CGFloat = 150
    fileprivate let defaultAnimationTime: TimeInterval = 0.25

    //MARK: - Variables
    private var dismissTime: TimeInterval = 3.0
    private var topLayoutConstraint: NSLayoutConstraint?

    //MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        fatalError("This was not implemented")
    }
    
    init(cornerRadius: CGFloat, dismissTime: TimeInterval) {
        super.init(frame: CGRect.zero)
        UIApplication.shared.keyWindow?.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        createLabelMessage()
        configViewConstraints()
        self.dismissTime = dismissTime
    }
    
    private func configViewConstraints() {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        createMarginConstraint(on: self,
                               attribute: .left,
                               to: keyWindow,
                               constant: margin)
        createMarginConstraint(on: self,
                               attribute: .right,
                               to: keyWindow,
                               constant: -margin)
        if #available(iOS 11, *) {
            let guide = keyWindow.safeAreaLayoutGuide
            topLayoutConstraint = self.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0)
        } else {
            topLayoutConstraint = self.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8.0)
        }
        topLayoutConstraint?.constant = -self.frame.size.height
        guard let topConstraint = topLayoutConstraint else { return }
        NSLayoutConstraint.activate([topConstraint])
    }
    
    private func createLabelMessage() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        configConstraints(of: label)
    }

    private func configConstraints(of label: UILabel) {
        createMarginConstraint(on: label,
                               attribute: .left,
                               to: self,
                               constant: margin)
        createMarginConstraint(on: label,
                               attribute: .right,
                               to: self,
                               constant: -margin)
        createMarginConstraint(on: label,
                               attribute: .top,
                               to: self,
                               constant: margin)
        createMarginConstraint(on: label,
                               attribute: .bottom,
                               to: self,
                               constant: -margin)
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
    
    private func configCorners(with cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }

    private func calculateSize(with width: CGFloat) -> CGSize {
        return CGSize(width: width - 2 * 10,
                      height: minHeight)
    }

    private func generateRect(with size: CGSize) -> CGRect {
        return CGRect(origin: CGPoint(x: margin,
                                      y: -size.height),
                      size: size)
    }

    //MARK: - Presentation Controls
    private func scheduledHide() {
        DispatchQueue.main.asyncAfter(deadline: .now() + dismissTime) {
            self.hide()
        }
    }

    public func style(backgroundColor: UIColor, font: UIFont, textColor: UIColor) {
        self.backgroundColor = backgroundColor
        labelMessage?.font = font
        labelMessage?.textColor = textColor
    }
    
    public func present() {
        topLayoutConstraint?.constant = margin
        UIView.animate(withDuration: defaultAnimationTime, animations: {
            self.layoutIfNeeded()
        }) { _ in
            self.scheduledHide()
        }
    }

    public func hide() {
        topLayoutConstraint?.constant = -self.frame.size.height
        UIView.animate(withDuration: defaultAnimationTime) {
            self.layoutIfNeeded()
        }
    }
}
