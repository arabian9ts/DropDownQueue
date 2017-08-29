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
    let items: [String]? = ["aiueo", "kkk", "girje", "fleapg"]
    var table_height: CGFloat = 300
    var table_width: CGFloat = 120
    var isClosed: Bool = true
    
    // storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initDropDown()
    }
    
    // code
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initDropDown()
    }
    
    // code
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 150, height: 300))
    }
    
    func initDropDown() -> Void {
        self.addTarget(self, action: #selector(self.toggle), for: UIControlEvents.touchUpInside)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        let nib = UINib(nibName: "DropDownCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "dropdown")
        self.tableview.isScrollEnabled = false
        self.tableview.tableHeaderView = UIView()
        self.tableview.tableFooterView = UIView()

        self.table_height = (self.tableview.visibleCells.last?.bounds.maxY)! * CGFloat((items?.count)!)
        print(self.tableview.visibleCells)
    }
    
    func frontmost() -> UIView? {
        if let frontmost = UIApplication.frontmost() {
            return frontmost.view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DropDownCell = tableview.dequeueReusableCell(withIdentifier: "dropdown", for: indexPath) as! DropDownCell
        cell.contentView.backgroundColor = UIColor(red: 0.176, green: 0.21, blue: 0.286, alpha: 1.0)
        cell.selectionStyle = .none
        cell.menuName.text = items?[indexPath.row]
        return cell
    }
    
    func toggle() {
        let frontmost = self.frontmost()
        if isClosed {
            self.tableview.frame = CGRect(
                x: (frontmost?.bounds.size.width)!-self.table_width,
                y: -table_height,
                width: self.table_width,
                height: self.table_height)
            self.tableview.separatorStyle = .none
            self.tableview.separatorInset = .zero
            frontmost?.addSubview(self.tableview)
            self.tableview.alpha = 0.0
            UIView.animate(withDuration: 0.2, animations: {_ in
                self.tableview.frame = CGRect(
                    x: (frontmost?.bounds.size.width)!-self.table_width,
                    y: 64,
                    width: self.table_width,
                    height: self.table_height);
                self.tableview.alpha = 1.0
            })
        }
        else {
            UIView.animate(withDuration: 0.2, animations: {_ in
                self.tableview.frame = CGRect(
                    x: (frontmost?.bounds.size.width)!-self.table_width,
                    y: -self.table_height,
                    width: self.table_width,
                    height: self.table_height);
                self.tableview.alpha = 0.0
            }, completion: {_ in
                self.tableview.removeFromSuperview()
            })
        }
        isClosed = !isClosed
    }

}
