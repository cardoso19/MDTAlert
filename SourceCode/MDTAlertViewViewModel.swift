//
//  MDTAlertViewViewModel.swift
//  MDTAlert
//
//  Created by Matheus Cardoso kuhn on 16/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

class MDTAlertViewViewModel {
    
    //MARK: - Constants
    let margin: CGFloat = 10
    let contentMargin: CGFloat = 15
    let minHeight: CGFloat = 40
    let defaultAnimationTime: TimeInterval = 0.25
    let dismissTime: TimeInterval
    let alertPosition: MDTAlertView.AlertPosition
    
    //MARK: - Init
    init(dismissTime: TimeInterval, alertPosition: MDTAlertView.AlertPosition) {
        self.dismissTime = dismissTime
        self.alertPosition = alertPosition
    }
    
    //MARK: - Functions
    private func calculateSize(with width: CGFloat) -> CGSize {
        return CGSize(width: width - 2 * 10,
                      height: minHeight)
    }
    
    func generateRect(withWidth width: CGFloat) -> CGRect {
        let size = calculateSize(with: width)
        return CGRect(origin: CGPoint(x: margin,
                                      y: -size.height),
                      size: size)
    }
    
    func calculateInScreenPosition() -> CGFloat {
        switch alertPosition {
        case .top:
            return margin
        case .bottom:
            return -margin
        }
    }
    
    func calculateOutScreenPosition(withHeight height: CGFloat) -> CGFloat {
        var outScreenPosition: CGFloat!
        switch alertPosition {
        case .top:
            outScreenPosition = -height
        case .bottom:
            outScreenPosition = height
        }
        if #available(iOS 11, *) {
            switch alertPosition {
            case .top:
                outScreenPosition -= UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
            case .bottom:
                outScreenPosition += UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            }
        }
        return outScreenPosition
    }
}
