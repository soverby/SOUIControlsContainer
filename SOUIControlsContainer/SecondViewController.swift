//
//  SecondViewController.swift
//  SOUIControlsContainer
//
//  Created by Overby, Sean on 6/19/15.
//  Copyright (c) 2015 Sean Overby. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPress(sender: AnyObject) {
        self.myLabel.text = "Button Pressed!"
    }

}

