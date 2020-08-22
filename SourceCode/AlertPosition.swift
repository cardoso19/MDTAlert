//
//  AlertPosition.swift
//  MDTAlertExample
//
//  Created by Matheus Cardoso Kuhn on 22/08/20.
//  Copyright © 2020 MDT. All rights reserved.
//

import UIKit

typealias AlertConstraints = (constraints: [NSLayoutConstraint], verticalConstraint: NSLayoutConstraint)

public enum AlertPosition {
    case top
    case bottom
    
    func inScreenValue(margin: CGFloat) -> CGFloat {
        switch self {
        case .top:
            return margin
        case .bottom:
            return -margin
        }
    }
    
    func outScreenValue(alertFrame: CGRect, edgeInsets: UIEdgeInsets) -> CGFloat {
        switch self {
        case .top:
            let value = alertFrame.height + edgeInsets.top
            return -value
        case .bottom:
            let value = alertFrame.height + edgeInsets.bottom
            return value
        }
    }
    
    func createConstraints(alert: UIView, parentView: UIView, margin: CGFloat) -> AlertConstraints {
        switch self {
        case .top:
            return createTopConstraints(alert: alert, parentView: parentView, margin: margin)
        case .bottom:
            return createBottomConstraints(alert: alert, parentView: parentView, margin: margin)
        }
    }
    
    private func createTopConstraints(alert: UIView, parentView: UIView, margin: CGFloat) -> AlertConstraints {
        let verticalConstraint = alert.safeLayoutGuide.topAnchor.constraint(equalTo: parentView.safeLayoutGuide.topAnchor, constant: inScreenValue(margin: margin))
        var constraints = createHorizontalConstraints(alert: alert, parentView: parentView, margin: margin)
        constraints.append(verticalConstraint)
        return (constraints, verticalConstraint)
    }
    
    private func createBottomConstraints(alert: UIView, parentView: UIView, margin: CGFloat) -> AlertConstraints {
        let verticalConstraint = alert.safeLayoutGuide.bottomAnchor.constraint(equalTo: parentView.safeLayoutGuide.bottomAnchor, constant: inScreenValue(margin: margin))
        var constraints = createHorizontalConstraints(alert: alert, parentView: parentView, margin: margin)
        constraints.append(verticalConstraint)
        return (constraints, verticalConstraint)
    }
    
    private func createHorizontalConstraints(alert: UIView, parentView: UIView, margin: CGFloat) -> [NSLayoutConstraint] {
        [
            alert.safeLayoutGuide.leadingAnchor.constraint(equalTo: parentView.safeLayoutGuide.leadingAnchor, constant: margin),
            alert.safeLayoutGuide.trailingAnchor.constraint(equalTo: parentView.safeLayoutGuide.trailingAnchor, constant: -margin)
        ]
    }
}
