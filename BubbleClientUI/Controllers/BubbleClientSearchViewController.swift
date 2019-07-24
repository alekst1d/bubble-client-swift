//
//  BubbleClientSearchViewController.swift
//  BubbleClientUI
//
//  Created by yan on 2019/7/24.
//  Copyright © 2019 Mark Wilson. All rights reserved.
//

import UIKit
import BubbleClient
import CoreBluetooth

class BubbleClientSearchViewController: UITableViewController {
    public var cgmManager: BubbleClientManager?
    private var list = [BubblePeripheral]()
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        cgmManager?.found = {
            [weak self] bubblePeripheral in
            var insert = true
            if let mac = bubblePeripheral.mac {
                for temp in self?.list ?? [] {
                    if temp.mac == mac {
                        insert = false
                        break
                    }
                }
                if insert {
                    self?.list.append(bubblePeripheral)
                    self?.tableView.reloadData()
                }
            }
        }
        
        title = cgmManager?.localizedTitle
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 55
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        self.navigationItem.setRightBarButton(button, animated: false)
    }
    
    @objc func cancelAction() {
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row].mac
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cgmManager?.connect(peripheral: list[indexPath.row].peripheral)
        navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}