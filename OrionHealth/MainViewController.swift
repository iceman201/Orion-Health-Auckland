//
//  ViewController.swift
//  OrionHealth
//
//  Created by Liguo Jiao on 24/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit
import SVProgressHUD

class MainViewController: UITableViewController {
    var contactList: [Contact]?
    var selectContact: Contact?
    let pullForRefresh = UIRefreshControl()
    var rightSideButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        requestData()
        setupNavController()

        rightSideButton = UIBarButtonItem(title: "A-Z", style: .plain, target: self, action: #selector(MainViewController.sort))
        rightSideButton?.tag = 1
        
        pullForRefresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        pullForRefresh.addTarget(self, action: #selector(MainViewController.pullRefresh), for: UIControlEvents.valueChanged)
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(pullForRefresh)
        }
    }
    
    // MARK: UI Setup
    
    fileprivate func setupNavController() {
        let specialColor = UIColor(red: 111.0/255.0, green: 168.0/255.0, blue: 220.0/255.0, alpha: 1)
        navigationController?.navigationBar.setBackgroundImage(imageWithColor(tintColor: UIColor.white), for:.default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.setNavigationBarHidden(false, animated:true)
        navigationController?.navigationBar.layer.cornerRadius = 10
        navigationController?.navigationBar.layer.borderWidth = 2
        navigationController?.navigationBar.layer.borderColor = specialColor.cgColor
        navigationController?.navigationBar.backgroundColor = specialColor
        navigationItem.rightBarButtonItem = rightSideButton
    }
    
    fileprivate func imageWithColor(tintColor: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        tintColor.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    // MARK: Data Action
    
    @objc fileprivate func pullRefresh() {
        requestData()
    }
    
    @objc fileprivate func sort(sender: UIBarButtonItem) {
        if sender.tag == 1 {
            sender.tag = 2
            sender.title = "A-Z"
            contactList = contactList?.sorted{$0.name! < $1.name!}
            tableView.reloadData()
        } else {
            sender.tag = 1
            sender.title = "Z-A"
            contactList = contactList?.sorted{$0.name! > $1.name!}
            tableView.reloadData()
        }
    }
    
    fileprivate func requestData() {
        SVProgressHUD.show(withStatus: "Loading contact")
        DispatchQueue.global().async {
            JSONDownloader.download(url: .contacts, completion: { (contact:[Contact]?, error:Error?) in
                if error == nil {
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.contactList = contact
                        self.tableView.reloadData()
                        SVProgressHUD.dismiss()
                    })
                    self.pullForRefresh.endRefreshing()
                } else {
                    assertionFailure(error?.localizedDescription ?? "Could not fetch Data")
                }
            })
        }
    }
    
    // MARK: Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = contactList?[indexPath.row].name
        cell.detailTextLabel?.text = contactList?[indexPath.row].email
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let list = contactList else {
            return
        }
        selectContact = list[indexPath.row]
        self.performSegue(withIdentifier: "goDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetails" {
            if let newController = segue.destination as? DetailsTableViewController {
                guard let contact = selectContact else {
                    return
                }
                newController.contact = contact
            }
        }
    }
}

