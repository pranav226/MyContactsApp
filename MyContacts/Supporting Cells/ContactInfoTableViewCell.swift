//
//  ContactInfoTableViewCell.swift
//  MyContacts
//
//  Created by Pranav Jain on 05/09/20.
//  Copyright © 2020 Pranav Jain. All rights reserved.
//

import UIKit

protocol ContactInfoProtocol: class{
    func showAlert(withTitle title: String, withMessage message: String)
}

final class ContactInfoTableViewCell: UITableViewCell {

    @IBOutlet private weak var contactNameLabel: UILabel!
    @IBOutlet weak var arrowStateImageView: UIImageView!
    
    @IBOutlet weak var contactInfoStackView: UIStackView!
    
    @IBOutlet private weak var mobileNumberHelperLabel: UILabel!
    @IBOutlet private weak var mobileNumberLabel: UILabel!
    @IBOutlet private weak var landlineHelperLabel: UILabel!
    @IBOutlet private weak var landlineNumberLabel: UILabel!
    @IBOutlet private weak var emailAddressHelperLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var ringtoneHelperLabel: UILabel!
    @IBOutlet private weak var ringtoneLabel: UILabel!
    
    @IBAction func callMobileButtonTapped(_ sender: Any) {
        self.callNumber(phoneNumber: mobileNumberLabel.text ?? "")
    }
    
    @IBAction func callLandlineButtonTapped(_ sender: Any) {
        self.callNumber(phoneNumber: landlineNumberLabel.text ?? "")
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        self.delegate?.showAlert(withTitle: "Not Available", withMessage: "Sorry! This functionality is not yet available")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViewStyling()
    }
    
    weak var delegate: ContactInfoProtocol?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    override func prepareForReuse() {
//        self.contactInfoStackView.isHidden = true
//    }
    
    func configureViewStyling(){
//        self.contentView.clipsToBounds = true
//        self.contentView.layer.cornerRadius = 14.0
//        self.contentView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    func configureCell(fromContact contact: ContactInfo){
        self.contactNameLabel.text = contact.name
        self.mobileNumberLabel.text = contact.phoneNo
        self.landlineNumberLabel.text = contact.landlineNo
        self.emailLabel.text = contact.email
        self.ringtoneLabel.text = contact.ringtone
        if contact.isCellExpanded{
            arrowStateImageView.image = UIImage(systemName: "arrow.up")
        }else{
            arrowStateImageView.image = UIImage(systemName: "arrow.down")
        }
    }
    
    private func callNumber(phoneNumber:String) {

        if let phoneUrl = URL(string: "tel://\(phoneNumber)") {
            
            if UIApplication.shared.canOpenURL(phoneUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
                } else {
                     UIApplication.shared.openURL(phoneUrl as URL)
                }
            }
        }
    }
    
    
}
