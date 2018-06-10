//
//  Action.swift
//  UIPathAutomator
//
//  Created by Emanuel Jarnea on 10/06/2018.
//  Copyright © 2018 Emanuel Jarnea. All rights reserved.
//

import Foundation

public protocol Action {}

public enum ButtonAction: Action {
    case accessibility(id: String)
    case contains(text: String)
}

public enum CellAction: Action {
    case index(section: Int, row: Int)
    case contains(text: String)
}

public enum AlertAction: Action {
    case dismiss
}
