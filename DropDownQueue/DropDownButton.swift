//
//  DropDownButton.swift
//  GroupMorning
//
//  Created by arabian9ts on 2017/08/10.
//  Copyright © 2017年 arabian9ts. All rights reserved.
//

import UIKit

public class DropDownButton: UIButton, UITableViewDelegate, UITableViewDataSource {
    public var table_width: CGFloat = 120
    public var table_height: CGFloat = 300
    public var delegate: DropDownDelegate?
    
    private let tableview = UITableView()
    private var icons: [UIImage] = []
    private var descriptions: [String] = []
    private var isClosed: Bool = true
    private var offImage: UIImage? = nil
    private var onImage: UIImage? = nil
    
    // storyboard
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    // code
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // code
    convenience public init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    }
    
    /* =============== Public Functions =============== */
    
    /* --- cell setting --- */
    public func setup(matrixes: [DropDownMatrix]) -> Void {
        for matrix in matrixes {
            self.icons.append(matrix.icon!)
            self.descriptions.append(matrix.description!)
        }
        self.initDropDown()
    }
    
    /* ============= Public Functions END ============= */
    
    
    /* ============== Private Functions =============== */
    
    /* --- set hilight images --- */
    public func setImages(on: UIImage?, off: UIImage?) -> Void {
        self.onImage = on
        self.offImage = off
    }
    
    /* --- initialize dropdown table --- */
    private func initDropDown() -> Void {
        self.addTarget(self, action: #selector(DropDownButton.self.toggle), for: UIControlEvents.touchUpInside)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        let nib = UINib(nibName: "DropDownCell", bundle: Bundle(for: DropDownButton.self))
        tableview.register(nib, forCellReuseIdentifier: "dropdown")
        
        /* --- tableview setting --- */
        self.tableview.isScrollEnabled = false
        self.tableview.tableHeaderView = UIView()
        self.tableview.tableFooterView = UIView()
        
        // adjust tableview height
        self.table_height = (self.tableview.visibleCells.last?.bounds.maxY)! * CGFloat(descriptions.count)
    }
    
    /* --- get front most vc --- */
    private func frontmost() -> UIView? {
        if let frontmost = UIApplication.frontmost() {
            return frontmost.view
        }
        return nil
    }
    
    /* ============ Private Functions END ============= */
    
    /* ==================== callback START ==================== */
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedItem(tableView.dequeueReusableCell(withIdentifier: "dropdown", for: indexPath) as! DropDownCell)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptions.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    @objc private func toggle() {
        let frontmost = self.frontmost()
        
        // open
        if isClosed {
            if self.onImage != nil {
                self.setImage(self.onImage, for: .normal)
            }
            
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
            if self.offImage != nil {
                self.setImage(self.offImage, for: .normal)
            }
            
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
