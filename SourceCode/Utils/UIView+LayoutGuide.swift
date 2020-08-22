//
//  UIView+LayoutGuide.swift
//  MDTAlertExample
//
//  Created by Matheus Cardoso Kuhn on 22/08/20.
//  Copyright © 2020 MDT. All rights reserved.
//

import UIKit

extension UIView {
    var safeLayoutGuide: LayoutGuide {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide
        } else {
            return self
        }
    }
}
