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
    
    /// Tap on a button identified by an accessibility id.
    case accessibility(id: String)
    
    /// Tap on a button that contains some text. This includes bar buttons.
    /// The comparison is case-insensitive.
    case contains(text: String)
    
    /// Tap on a button that displays an image. This includes bar buttons.
    case displays(image: UIImage)
}

public enum NavigationAction: Action {
    
    /// Go back one step on the navigation stack.
    case back
}

public enum CellAction: Action {
    
    /// Tap on a cell found at given section and row.
    case index(section: Int, row: Int)
    
    /// Tap on a cell that contains some text. The comparison is case-insensitive.
    case contains(text: String)
}

public enum AlertAction: Action {
    
    /// Dismiss the current alert.
    case dismiss
}
