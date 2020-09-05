//
//  ContactInfoModel.swift
//  MyContacts
//
//  Created by Pranav Jain on 05/09/20.
//  Copyright © 2020 Pranav Jain. All rights reserved.
//

import Foundation

class ContactInfo{
    var name: String?
    var phoneNo: String?
    var landlineNo: String?
    var email: String?
    var ringtone: String?
    var isCellExpanded : Bool = false
    
    init(name: String?, phoneNo: String?, landlineNo: String?, email: String?, ringtone: String?){
        self.name = name
        self.phoneNo = phoneNo
        self.landlineNo = landlineNo
        self.email = email
        self.ringtone = ringtone
    }
}

class ContactInfoParser : NSObject{
    func getContactInfoFromDict(_ dict: [String:Any]) -> ContactInfo{
        let name = dict["name"] as? String ?? ""
        let phoneNo = dict["phoneNo"] as? String ?? ""
        let landlineNo = dict["landlineNo"] as? String ?? ""
        let email = dict["email"] as? String ?? ""
        let ringtone = dict["ringtone"] as? String ?? ""
        let item = ContactInfo(name: name, phoneNo: phoneNo, landlineNo: landlineNo, email: email, ringtone: ringtone)
        return item
    }
}
