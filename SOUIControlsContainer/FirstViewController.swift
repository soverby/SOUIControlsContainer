//
//  FirstViewController.swift
//  SOUIControlsContainer
//
//  Created by Overby, Sean on 6/19/15.
//  Copyright (c) 2015 Sean Overby. All rights reserved.
//

import UIKit
import SOUIControls

class FirstViewController: UIViewController {

    @IBOutlet weak var progressCircleView: PercentCompleteControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func viewDidAppear(animated: Bool) {
        self.progressCircleView.animateProgress(45, ignoreDuration: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

