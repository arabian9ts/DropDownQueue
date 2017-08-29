//
//  ViewController.swift
//  DropDown
//
//  Created by arabian9ts on 2017/08/29.
//  Copyright © 2017年 arabian9ts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var matrixes: [DropDownMatrix] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dropdown = DropDownButton()
        dropdown.setImage(UIImage(named: "gear"), for: .normal)
        
        self.matrixes.append(DropDownMatrix(UIImage(named: "gear"), "first", {print("first")}))
        self.matrixes.append(DropDownMatrix(UIImage(named: "gear"), "second", {print("second")}))
        self.matrixes.append(DropDownMatrix(UIImage(named: "gear"), "third", {print("third")}))
        
        dropdown.setup(matrixes: self.matrixes)
        
        let customButton: UIBarButtonItem = UIBarButtonItem(customView: dropdown)
        self.navigationItem.setRightBarButton(customButton, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

