//
//  MDTAlertView.swift
//  MDTAlert
//
//  Created by Matheus Cardoso kuhn on 31/03/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

private enum Layout {
    static let margin: CGFloat = 10
    
    enum Size {
        static let cornerRadius: CGFloat = 6
        static let minHeight: CGFloat = 44
    }
}

final class MDTAlertView: UIView {
    //MARK: - Visual Components
    private let labelMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()

    //MARK: - Variables
    private let viewModel: MDTAlertViewModeling
    private let alertPosition: AlertPosition
    private var verticalConstraint: NSLayoutConstraint?
    private weak var parentView: UIView?
    public var isHideAnimated: Bool = true

    //MARK: - Life Cycle
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("This was not implemented")
    }
    
    init(viewModel: MDTAlertViewModeling, alertPosition: AlertPosition, parentView: UIView?) {
        self.viewModel = viewModel
        self.alertPosition = alertPosition
        self.parentView = parentView
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        buildLayout()
    }
    
    private func buildLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    private func buildViewHierarchy() {
        addSubview(labelMessage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            labelMessage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.margin),
            labelMessage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.margin),
            labelMessage.topAnchor.constraint(equalTo: topAnchor, constant: Layout.margin),
            labelMessage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.margin)
        ])
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: Layout.Size.minHeight)
        ])
    }
    
    private func setupConstraintsToParentView() {
        guard let parentView = parentView else {
            return
        }
        parentView.addSubview(self)
        let alertConstraints = alertPosition.createConstraints(alert: self, parentView: parentView, margin: Layout.margin)
        NSLayoutConstraint.activate(alertConstraints.constraints)
        UIApplication.shared.keyWindow?.layoutIfNeeded()
        verticalConstraint = alertConstraints.verticalConstraint
    }
    
    private func configureViews() {
        configGestureRecognizer()
        layer.cornerRadius = Layout.Size.cornerRadius
        clipsToBounds = true
    }
    
    private func configGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc
    private func tapGesture() {
        hide(animated: isHideAnimated)
    }
    
    private func getParentViewEdgeInsets() -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return parentView?.safeAreaInsets ?? .zero
        } else {
            return .zero
        }
    }
    
    private func scheduleTimer(animated: Bool) {
        viewModel.scheduleTimer { [weak self] in
            self?.hide(animated: animated)
        }
    }
}

// MARK: - MDTAlerting
extension MDTAlertView: MDTAlerting {
    public func setText(_ text: String) {
        labelMessage.text = text
    }
    
    public func setStyle(textColor: UIColor, font: UIFont, textAligment: NSTextAlignment) {
        labelMessage.textColor = textColor
        labelMessage.font = font
        labelMessage.textAlignment = textAligment
    }
    
    public func setAttributedText(_ attributedText: NSAttributedString) {
        labelMessage.attributedText = attributedText
    }
    
    public func present(animated: Bool) {
        setupConstraintsToParentView()
        verticalConstraint?.constant = alertPosition.outScreenValue(alertFrame: frame, edgeInsets: getParentViewEdgeInsets())
        parentView?.layoutIfNeeded()
        verticalConstraint?.constant = alertPosition.inScreenValue(margin: Layout.margin)
        if animated {
            UIView.animate(withDuration: 0.25, animations: {
                self.parentView?.layoutIfNeeded()
            }, completion: { _ in
                self.scheduleTimer(animated: animated)
            })
        } else {
            parentView?.layoutIfNeeded()
        }
    }

    public func hide(animated: Bool) {
        verticalConstraint?.constant = alertPosition.outScreenValue(alertFrame: frame, edgeInsets: getParentViewEdgeInsets())
        if animated {
            UIView.animate(withDuration: 0.25, animations: {
                self.parentView?.layoutIfNeeded()
            }, completion: { _ in
                self.removeFromSuperview()
            })
        } else {
            removeFromSuperview()
        }
    }
}
