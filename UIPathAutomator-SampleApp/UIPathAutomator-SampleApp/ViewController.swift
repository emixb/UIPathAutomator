//
//  ViewController.swift
//  UIPathAutomator-SampleApp
//
//  Created by Emanuel Jarnea on 10/06/2018.
//  Copyright © 2018 Emanuel Jarnea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func didPressRightBarButton(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

