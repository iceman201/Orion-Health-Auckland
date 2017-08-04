//
//  DetailsTableViewController.swift
//  OrionHealth
//
//  Created by Liguo Jiao on 25/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = contact?.name
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
        tableviewSetup()
    }
    
    fileprivate func tableviewSetup() {
        let border = BorderDraw(frame: CGRect(x: 0, y: 5, width: self.tableView.frame.width - 20, height: self.tableView.frame.height - 70))
        border.center.x = self.tableView.center.x
        tableView.addSubview(border)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 45
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? ContactDetailsTableViewCell else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            cell.title.text = "USERNAME"
            cell.detailTitle.text = contact?.username
        case 1:
            cell.title.text = "PHONE"
            cell.detailTitle.text = contact?.phone
        case 2:
            cell.title.text = "ADDRESS"
            cell.detailTitle.text = "\(contact?.address?.suite ?? "")\n\(contact?.address?.street ?? "")\n\(contact?.address?.city ?? "")\n\(contact?.address?.zipCode ?? "")"
        case 3:
            cell.title.text = "WEBSITE"
            cell.detailTitle.text = contact?.website
        case 4:
            cell.title.text = "COMPANY"
            cell.detailTitle.text = "\(contact?.company?.name ?? "")\n\(contact?.company?.catchPhrase ?? "")\n\(contact?.company?.bs ?? "")"
        default:
            break
        }
        return cell
    }
    
}
