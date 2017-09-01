//
//  DropDownDelegate.swift
//  DropDownQueue
//
//  Created by arabian9ts on 2017/09/01.
//  Copyright © 2017年 arabian9ts. All rights reserved.
//

import Foundation

public protocol DropDownDelegate {
    func selectedAt(_ index: Int)
    func selectedItem(_ dropDown: DropDownCell)
}