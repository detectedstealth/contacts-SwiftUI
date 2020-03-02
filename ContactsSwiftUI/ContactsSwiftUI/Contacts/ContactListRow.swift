//
//  ContactListRow.swift
//  ContactsSwiftUI
//
//  Created by Bruce Wade on 2020-03-01.
//  Copyright © 2020 Warply Designed Inc. All rights reserved.
//

import SwiftUI
import Contacts

struct ContactListRow: View {
    var contact: Contact
    @State var contactImage: Image? = nil
    
    var body: some View {
        HStack(spacing: 15.0) {
            if contactImage != nil {
                contactImage!
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(5)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
            }
            
                
            VStack(alignment: .leading) {
                Text(contact.fullName)
                    .font(.title)
                Text(contact.phoneNumber)
                    .font(.subheadline)
                Text(contact.emails)
                    .font(.caption)
            }
            Spacer()
        }
        .onAppear() {
            self.contact.fetchImageIfNeeded { (image) in
                self.contactImage = image
            }
        }
    }
}

struct ContactListRow_Previews: PreviewProvider {
    static var previews: some View {
        let contact = CNMutableContact()
        contact.givenName = "John"
        contact.familyName = "Appleseed"
        
        let homeEmail = CNLabeledValue(label:CNLabelHome, value: "john@example.com" as NSString)
        let workEmail = CNLabeledValue(label:CNLabelWork, value: "j.appleseed@icloud.com" as NSString)
        contact.emailAddresses = [homeEmail, workEmail]
        
        contact.phoneNumbers = [
            CNLabeledValue(label: CNLabelPhoneNumberiPhone, value: CNPhoneNumber(stringValue: "(408) 555-0126"))
        ]
        
        return ContactListRow(contact: Contact(contact: contact))
    }
}
