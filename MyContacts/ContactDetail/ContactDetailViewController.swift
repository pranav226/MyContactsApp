//
//  ContactDetailViewController.swift
//  MyContacts
//
//  Created by Pranav Jain on 05/09/20.
//  Copyright © 2020 Pranav Jain. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController, ContactInfoProtocol{
    
    @IBOutlet weak var contactTableView: UITableView!
    

    @IBAction func backBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? ViewController
        if let myVC = vc{
            self.present(myVC, animated: true, completion: nil)
        }
    }
    
    var contactInfo : Array<ContactInfo> = []
    var previousSelectedIndexPath : IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        getContactsInfo()
        registerCells()
        contactTableView.delegate = self
        contactTableView.dataSource = self
        contactTableView.separatorStyle = .none

    }
    
    func registerCells(){
        contactTableView.register(UINib(nibName: "ContactInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactInfoTableViewCell")
    }
    
    func getContactsInfo(){
        let parser = ContactInfoParser()
        for dict in contactDict{
            let item = parser.getContactInfoFromDict(dict)
            //contactInfo.append(item)
            contactInfo.append(item)
        }
    }
    
    internal func showAlert(withTitle title: String, withMessage message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){
            (action:UIAlertAction!)in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ContactDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ContactInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactInfoTableViewCell", for: indexPath) as! ContactInfoTableViewCell
        cell.delegate = self
        cell.accessibilityIdentifier = "cell\(indexPath.row)"
        cell.selectionStyle = .none
        cell.contactInfoStackView.isHidden = !contactInfo[indexPath.row].isCellExpanded
        cell.configureCell(fromContact: contactInfo[indexPath.row])
        return cell
    }
    
    
}

extension ContactDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var indexArray : [IndexPath] = []
        
        //logic for expansion & collapsion
        if(previousSelectedIndexPath != nil && previousSelectedIndexPath != indexPath){
            contactInfo[previousSelectedIndexPath?.row ?? 0].isCellExpanded = false
            indexArray.append(previousSelectedIndexPath!)
        }
        previousSelectedIndexPath = indexPath
        indexArray.append(indexPath)
        contactInfo[indexPath.row].isCellExpanded = !contactInfo[indexPath.row].isCellExpanded
        print("\(indexPath.row) \(contactInfo[indexPath.row].isCellExpanded)")
        tableView.reloadRows(at: indexArray, with: UITableView.RowAnimation.none)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Deselected")
    }
}
