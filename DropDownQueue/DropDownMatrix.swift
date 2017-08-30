//
//  DropDownMatrix.swift
//  DropDown
//
//  Created by arabian9ts on 2017/08/29.
//  Copyright © 2017年 arabian9ts. All rights reserved.
//

import Foundation
import UIKit

public struct DropDownMatrix {
    var icon: UIImage?
    var description: String?
    var action: (() -> Void)?
    
    /*
    public init() {
        self.init(UIImage(named: "gear"), "None", {print("not initialized")})
    }
     */
    
    public init(_ icon: UIImage?, _ description: String?, _ action: (() -> Void)?) {
        self.icon = icon
        self.description = description
        self.action = action
    }
}
