//
//  ViewController.swift
//  PoppingNav
//
//  Created by Matan Cohen on 7/11/18.
//  Copyright © 2018 Matan Cohen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    let tableView: UITableView = UITableView.init()
    let headerHeight = 130
    let footerHeight = CGFloat(50)
    var poppingHeightContraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 320, height: headerHeight))
        header.backgroundColor = UIColor.gray
        
        let popingFooter = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 320, height: 50))
        self.view.addSubview(popingFooter)
        
        popingFooter.translatesAutoresizingMaskIntoConstraints = false
        popingFooter.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        popingFooter.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        popingFooter.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.poppingHeightContraint = popingFooter.heightAnchor.constraint(equalToConstant: 0)
        self.poppingHeightContraint?.isActive = true
        self.poppingHeightContraint?.constant = 0
        popingFooter.backgroundColor = UIColor.gray
        
        self.view.addSubview(self.tableView)
        self.view.backgroundColor = UIColor.blue
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.tableHeaderView = header
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: popingFooter.topAnchor).isActive = true
        self.navigationController?.hidesBarsOnSwipe = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.view.layoutIfNeeded()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if( Int(scrollView.contentOffset.y) > headerHeight ) {
            self.poppingHeightContraint?.constant = footerHeight
        } else {
            self.poppingHeightContraint?.constant = 0
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - UITableView data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Row \((indexPath as NSIndexPath).row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Header"
    }
}


