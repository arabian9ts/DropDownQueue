//
//  DropDownCell.swift
//  GroupMorning
//
//  Created by arabian9ts on 2017/08/08.
//  Copyright © 2017年 arabian9ts. All rights reserved.
//

import UIKit

public class DropDownCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var menuName: UILabel!

    override public func awakeFromNib() {
        super.awakeFromNib()
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
