//
//  ViewFinder.swift
//  UIPathAutomator
//
//  Created by Emanuel Jarnea on 10/06/2018.
//  Copyright © 2018 Emanuel Jarnea. All rights reserved.
//

import Foundation

class ViewFinder {
    
    static func currentViewController() -> UIViewController? {
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            // topController should now be your topmost view controller
            return topController
        }
        
        return nil
    }
    
    static func findSubviewInViewHierarchy(rootView: UIView, identifier: String) -> UIView? {
        
        if rootView.accessibilityIdentifier == identifier {
            return rootView
        }
        
        for subview in rootView.subviews {
            if let someView = ViewFinder.findSubviewInViewHierarchy(rootView: subview, identifier: identifier) {
                return someView
            }
        }
        
        return nil
    }
    
    static func findSubviewInViewHierarchy<ViewType>(rootView: UIView) -> ViewType? {
        
        if rootView is ViewType {
            return rootView as? ViewType
        }
        
        for subview in rootView.subviews {
            if let someView: ViewType = ViewFinder.findSubviewInViewHierarchy(rootView: subview) {
                return someView
            }
        }
        
        return nil
    }
    
    static func findSubviewInViewHierarchy(rootView: UIView, containing text: String) -> UIView? {
        
        if ViewFinder.isTextBeingDisplayed(in: rootView, text: text) {
            return rootView
        }
        
        for subview in rootView.subviews {
            if let someView = ViewFinder.findSubviewInViewHierarchy(rootView: subview, containing: text) {
                return someView
            }
        }
        
        return nil
    }
    
    static func findSubviewInViewHierarchy(rootView: UIView, displaying imagePNGRepresentation: Data) -> UIView? {
        
        if ViewFinder.isImageBeingDisplayed(in: rootView, imagePNGRepresentation: imagePNGRepresentation) {
            return rootView
        }
        
        for subview in rootView.subviews {
            if let someView = ViewFinder.findSubviewInViewHierarchy(rootView: subview, displaying: imagePNGRepresentation) {
                return someView
            }
        }
        
        return nil
    }
    
    static func findActionableSuperviewControl(for control: UIControl) -> UIControl? {
        
        var currentView: UIView = control
        
        while let superView = currentView.superview {
            if let parentControl = superView as? UIControl, parentControl.isUserInteractionEnabled {
                return parentControl
            }
            currentView = superView
        }
        
        return nil
    }

    private static func isTextBeingDisplayed(in view: UIView, text: String) -> Bool {
        if let label = view as? UILabel {
            return label.text?.lowercased().contains(text.lowercased()) ?? false
        }
        
        if let button = view as? UIButton {
            return button.currentTitle?.lowercased().contains(text.lowercased()) ?? false
        }
        
        // You can add other view types
        
        return false
    }
    
    private static func isImageBeingDisplayed(in view: UIView, imagePNGRepresentation: Data) -> Bool {
        if let imageView = view as? UIImageView, let displayedImage = imageView.image {
            return UIImagePNGRepresentation(displayedImage) == imagePNGRepresentation
        }
 
        if let button = view as? UIButton, let displayedImage = button.currentImage {
            return UIImagePNGRepresentation(displayedImage) == imagePNGRepresentation
        }
        
        // You can add other view types
        
        return false
    }
}
