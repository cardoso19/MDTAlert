//
//  MDTAlertViewModel.swift
//  MDTAlert
//
//  Created by Matheus Cardoso kuhn on 16/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MDTAlertViewModeling {
    func scheduleTimer(completion: @escaping () -> Void)
}

final class MDTAlertViewModel {
    //MARK: - Constants
    let dismissTime: TimeInterval
    private var timer: Timer?
    
    //MARK: - Life Cycle
    init(dismissTime: TimeInterval) {
        self.dismissTime = dismissTime
    }
}

// MARK: - MDTAlertViewModeling
extension MDTAlertViewModel: MDTAlertViewModeling {
    func scheduleTimer(completion: @escaping () -> Void) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: dismissTime, target: self, selector: #selector(timerBlock), userInfo: completion, repeats: false)
    }
    
    @objc
    private func timerBlock(_ timer: Timer) {
        guard let completion = timer.userInfo as? () -> Void else {
            return
        }
        completion()
    }
}
