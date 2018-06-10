//
//  Automator.swift
//  UIPathAutomator
//
//  Created by Emanuel Jarnea on 10/06/2018.
//  Copyright © 2018 Emanuel Jarnea. All rights reserved.
//

import Foundation

public class Automator {
    
    private let actions: [Action]
    private var nextActionIndex = 0
    
    private var startDate = Date()
    
    private let retryInterval   = DispatchTimeInterval.milliseconds(100)
    public var nextActionWaitInterval  = DispatchTimeInterval.milliseconds(500)
    
    private let debugName = "~~[UIPathAutomator]"
    
    public init(actions: [Action]) {
        self.actions = actions
    }
    
    deinit {
        let timeInterval: Double = Date().timeIntervalSince(startDate)
        print("\(debugName) Path automated in \(timeInterval) seconds!")
    }
    
    public func start() {
        
        startDate = Date()
        
        nextActionIndex = 0
        
        if nextActionIndex < actions.count {
            sendAction()
        }
    }
    
    private func sendAction() {
        
        let action = actions[nextActionIndex]
        
        let actionSucceeded = ActionApplier().performAction(action: action)
        
        if actionSucceeded {
            nextActionIndex += 1
            let actionName = String(describing: type(of: action)).padding(toLength: 20, withPad: " ", startingAt: 0)
            print("\(debugName) Step \(nextActionIndex) of \(actions.count) completed: \(actionName) \(action)")
        }
        
        if nextActionIndex < actions.count {
            let waitInterval = actionSucceeded ? nextActionWaitInterval : retryInterval
            DispatchQueue.main.asyncAfter(deadline: .now() + waitInterval) {
                self.sendAction()
            }
        }
    }
}
