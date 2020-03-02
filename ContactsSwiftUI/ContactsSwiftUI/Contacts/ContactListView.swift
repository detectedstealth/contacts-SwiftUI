//
//  ContactListView.swift
//  ContactsSwiftUI
//
//  Created by Bruce Wade on 2020-03-01.
//  Copyright © 2020 Warply Designed Inc. All rights reserved.
//

import SwiftUI
import Contacts

struct ContactListView: View {
    let store = CNContactStore()
    @State var contacts = [Contact]()
    @State var fetchedContacts = [Contact]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contacts) { contact in
                    NavigationLink(destination: ContactDetailsView(contact: contact)) {
                        ContactListRow(contact: contact)
                        .padding(.vertical)
                    }
                }
            }
            .navigationBarTitle("Contacts")
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                    
                }
            )
            .onAppear() {
                print("Launced")
                let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
                
                if authorizationStatus == .notDetermined {
                    self.store.requestAccess(for: .contacts) {  (didAuthorize, error) in
                        if didAuthorize {
                            self.retrieveContacts()
                        }
                    }
                } else if authorizationStatus == .authorized {
                    self.retrieveContacts()
                }
            }
        }
    }
    
    func retrieveContacts(with customFilter: NSPredicate? = nil) {
        let containerId = store.defaultContainerIdentifier()
        let filter = CNContact.predicateForContactsInContainer(withIdentifier: containerId)
        
        let keysToFetch = [
            CNContactGivenNameKey as CNKeyDescriptor,
            CNContactFamilyNameKey as CNKeyDescriptor,
            CNContactEmailAddressesKey as CNKeyDescriptor,
            CNContactPhoneNumbersKey as CNKeyDescriptor,
            CNContactImageDataAvailableKey as CNKeyDescriptor,
            CNContactImageDataKey as CNKeyDescriptor
        ]
        
        do {
            if let customFilter = customFilter {
                fetchedContacts.removeAll(keepingCapacity: false)
                fetchedContacts = try store.unifiedContacts(matching: customFilter, keysToFetch: keysToFetch).map { Contact(contact: $0) }
                print(fetchedContacts)
            } else {
                contacts = try store.unifiedContacts(matching: filter, keysToFetch: keysToFetch).map { Contact(contact: $0) }
                print(contacts)
            }
        } catch {
            print(error)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
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
        let content = ContactListView(contacts: [Contact(contact: contact)])
        return content
    }
}
