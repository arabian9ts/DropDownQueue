//
//  DropDownButton.swift
//  GroupMorning
//
//  Created by arabian9ts on 2017/08/10.
//  Copyright © 2017年 arabian9ts. All rights reserved.
//

import UIKit

class DropDownButton: UIButton, UITableViewDelegate, UITableViewDataSource {
    public var table_width: CGFloat = 120
    public var table_height: CGFloat = 300
    private let tableview = UITableView()
    private var icons: [UIImage] = []
    private var descriptions: [String] = []
    private var actions: [() -> Void] = []
    private var isClosed: Bool = true
    
    // storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // code
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // code
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    }
    
    /* --- initialize dropdown table --- */
    private func initDropDown() -> Void {
        self.addTarget(self, action: #selector(self.toggle), for: UIControlEvents.touchUpInside)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        let nib = UINib(nibName: "DropDownCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "dropdown")
        
        /* --- tableview setting --- */
        self.tableview.isScrollEnabled = false
        self.tableview.tableHeaderView = UIView()
        self.tableview.tableFooterView = UIView()
        
        // adjust tableview height
        self.table_height = (self.tableview.visibleCells.last?.bounds.maxY)! * CGFloat(descriptions.count)
    }
    
    /* --- cell setting --- */
    public func setup(matrixes: [DropDownMatrix]) -> Void {
        for matrix in matrixes {
            self.icons.append(matrix.icon!)
            self.descriptions.append(matrix.description!)
            self.actions.append(matrix.action!)
        }
        self.initDropDown()
    }
    
    /* --- get front most vc --- */
    func frontmost() -> UIView? {
        if let frontmost = UIApplication.frontmost() {
            return frontmost.view
        }
        return nil
    }
    
    /* ==================== callback START ==================== */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row <= actions.count {
            self.actions[indexPath.row]()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DropDownCell = tableview.dequeueReusableCell(withIdentifier: "dropdown", for: indexPath) as! DropDownCell
        cell.contentView.backgroundColor = UIColor(red: 0.176, green: 0.21, blue: 0.286, alpha: 1.0)
        cell.selectionStyle = .none
        
        if self.icons.count == self.descriptions.count && indexPath.row <= self.icons.count {
            cell.icon.image = self.icons[indexPath.row]
            cell.menuName.text = descriptions[indexPath.row]
        }

        return cell
    }
    /* ===================== callback END ===================== */
    
    /* --- open/close dropdown --- */
    func toggle() {
        let frontmost = self.frontmost()
        
        // open
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
        
        // close
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