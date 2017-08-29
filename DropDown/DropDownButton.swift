//
//  DropDownButton.swift
//  GroupMorning
//
//  Created by arabian9ts on 2017/08/10.
//  Copyright © 2017年 arabian9ts. All rights reserved.
//

import UIKit

class DropDownButton: UIButton, UITableViewDelegate, UITableViewDataSource {
    let tableview = UITableView()
    let items: [String] = ["アラーム", "退出"]
    var table_height: CGFloat = 150
    var table_width: CGFloat = 120
    var isClosed: Bool = true
    var root: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    }
    
    init(view: UIView) {
        super.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        root = view
        tableview.delegate = self
        tableview.dataSource = self
        let nib = UINib(nibName: "DropDownCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "dropdown")
        
        tableview.layoutIfNeeded()
        self.table_height = tableview.contentSize.height
        self.table_width = tableview.contentSize.width
//        tableview.frame = CGRect(x: root.bounds.size.width-120, y: -table_height, width: 120, height: table_height)
        print("bounds: \(tableview.bounds.size.height)")
        print("content: \(tableview.contentSize.height)")
        tableview.frame = CGRect(x: root.bounds.size.width-table_width, y: -table_height, width: table_width, height: table_height)
        
        tableview.tableFooterView = UIView()
        root.addSubview(tableview)
        
        self.setImage(UIImage(named: "direction_down"), for: UIControlState.normal)
        self.addTarget(self, action: #selector(DropDownButton.toggle), for: UIControlEvents.touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DropDownCell = tableview.dequeueReusableCell(withIdentifier: "dropdown", for: indexPath) as! DropDownCell
        cell.menuName.text = items[indexPath.row]
        return cell
    }
    
    func toggle() {
        if isClosed {
            UIView.animate(withDuration: 0.2, animations: {_ in
                self.tableview.frame = CGRect(x: self.root.bounds.size.width-120, y: 64, width: 120, height: self.table_height)})
        }
        else {
            UIView.animate(withDuration: 0.2, animations: {_ in
                self.tableview.frame = CGRect(x: self.root.bounds.size.width-120, y: -self.table_height, width: 120, height: self.table_height)})
        }
        isClosed = !isClosed
    }

}
