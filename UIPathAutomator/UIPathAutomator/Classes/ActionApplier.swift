//
//  ActionApplier.swift
//  UIPathAutomator
//
//  Created by Emanuel Jarnea on 10/06/2018.
//  Copyright © 2018 Emanuel Jarnea. All rights reserved.
//

import Foundation

class ActionApplier {
    
    func performAction(action: Action) -> Bool {
        
        guard let currentViewController = ViewFinder.currentViewController() else { return false }
        
        if let buttonAction = action as? ButtonAction {
            return performButtonAction(action: buttonAction, in: currentViewController.view)
        }
        
        if let cellAction = action as? CellAction {
            return performTableViewCellAction(action: cellAction, in: currentViewController.view)
        }
        
        if let alertAction = action as? AlertAction, let alertController = currentViewController as? UIAlertController {
            return performAlertAction(action: alertAction, controller: alertController)
        }
        
        return false
    }
    
    private func performButtonAction(action: ButtonAction, in rootView: UIView) -> Bool {
        
        let view: UIView?
        
        switch action {
        case .accessibility(let id):
            view = ViewFinder.findSubviewInViewHierarchy(rootView: rootView, identifier: id)
        case .contains(let text):
            view = ViewFinder.findSubviewInViewHierarchy(rootView: rootView, containing: text)
        }
        
        guard let control = view as? UIControl else {
            return false
        }
        
        guard !control.isHidden && control.isEnabled else {
            return false
        }
        
        //Needed to handle moder tab bar buttons
        if control.isUserInteractionEnabled {
            control.sendActions(for: .touchUpInside)
            return true
        }
        else {
            // The implementation is tricky for Bar Buttons. It seems one ancestor is a button as well.
            if let barButton = ViewFinder.findActionableSuperviewControl(for: control) {
                barButton.sendActions(for: .touchUpInside)
                return true
            }
        }
        
        return false
    }
    
    private func performTableViewCellAction(action: CellAction, in rootView: UIView) -> Bool {
        
        guard let tableView: UITableView = ViewFinder.findSubviewInViewHierarchy(rootView: rootView) else {return false}
        guard tableView.allowsSelection else { return false }
        
        var cellIndexPath: IndexPath?
        
        switch action {
        case .index(let section, let row):
            cellIndexPath = IndexPath(row: row, section: section)
        case .contains(let text):
            
            cellLoop:
                for section in 0..<tableView.numberOfSections {
                    for row in 0..<tableView.numberOfRows(inSection: 0) {
                        
                        let indexPath = IndexPath(row: row, section: section)
                        let cell = tableView.dataSource!.tableView(tableView, cellForRowAt: indexPath)
                        
                        if let _ = ViewFinder.findSubviewInViewHierarchy(rootView: cell, containing: text) {
                            cellIndexPath = indexPath
                            break cellLoop
                        }
                    }
            }
        }
        
        if let indexPath = cellIndexPath {
            tableView.delegate!.tableView!(tableView, didSelectRowAt: indexPath)
            return true
        }
        
        return false
    }
    
    private func performAlertAction(action: AlertAction, controller: UIAlertController) -> Bool {
        
        switch action {
        case .dismiss:
            controller.dismiss(animated: true, completion: nil)
        }
        
        return true
    }
}
