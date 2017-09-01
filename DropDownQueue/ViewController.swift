//
//  ViewController.swift
//  DropDown
//
//  Created by arabian9ts on 2017/08/29.
//  Copyright © 2017年 arabian9ts. All rights reserved.
//

import UIKit
import DropDown

class ViewController: UIViewController {
    
    var matrixes: [DropDownMatrix] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* --- code initializing --- */
        let dropdown = DropDownButton()
        dropdown.setImages(on: UIImage(), off: UIImage(named: "gear"))
        
        // setup way both storyboard initializing and code initializing
        self.matrixes.append(DropDownMatrix(UIImage(named: "gear"), "first", {print("first")}))
        self.matrixes.append(DropDownMatrix(UIImage(named: "gear"), "second", {print("second")}))
        self.matrixes.append(DropDownMatrix(UIImage(named: "gear"), "third", {print("third")}))
        dropdown.setup(matrixes: self.matrixes)
        
        /* --- code initializing --- */
        let customButton: UIBarButtonItem = UIBarButtonItem(customView: dropdown)
        self.navigationItem.setRightBarButton(customButton, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

