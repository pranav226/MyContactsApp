//
//  ViewController.swift
//  MyContacts
//
//  Created by Pranav Jain on 05/09/20.
//  Copyright © 2020 Pranav Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func checkContactsButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContactDetailViewController") as? ContactDetailViewController
        if let myVC = vc{
            self.present(myVC, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

