//
//  DestinationViewController.swift
//  CountryDisplay
//
//  Created by Giridhar Bhujanga on 24/05/17.
//  Copyright © 2017 Giridhar Bhujanga. All rights reserved.
//

import UIKit

class DestinationViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var titleText : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleText

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
