//
//  AddContactView.swift
//  ContactsSwiftUI
//
//  Created by Bruce Wade on 2020-05-15.
//  Copyright © 2020 Warply Designed Inc. All rights reserved.
//

import SwiftUI

struct AddContactView: View {
    
    @State var phoneNumbers: [ContactPhoneNumber] = []
    @State var emails: [ContactEmail] = []
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    Button(action: cancel) {
                        Text("Cancel")
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Button(action: {}) {
                            Text("Edit Picture")
                        }
                    }
                    Spacer()
                    Button(action: done) {
                        Text("Done")
                    }
                }
                .padding()
                Rectangle()
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                List {
                    Text("First Name")
                    Text("Last Name")
                    Text("Company")
                    
                    PhoneNumbersSelectionView(phoneNumbers: self.$phoneNumbers)
                    
                    EmailsSelectionView(emails: self.$emails)
                    
                    Group {
                        Section(header: Text("")) {
                            NavigationLink(destination: RingTonesListView()) {
                                HStack {
                                    Text("Ringtone")
                                    Text("Default")
                                        .foregroundColor(.blue)
                                }
                                .font(.subheadline)
                            }
                        }
                        
                        Section {
                            NavigationLink(destination: RingTonesListView()) {
                                HStack {
                                    Text("Text Tone")
                                    Text("Default")
                                        .foregroundColor(.blue)
                                }
                                .font(.subheadline)
                            }
                        }
                    }
                    
                    
                    
                    Section(header: Text("")) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                            Text("add url")
                                .font(.subheadline)
                        }
                    }
                    
                    Group {
                        Section {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                Text("add address")
                                    .font(.subheadline)
                            }
                        }
                        
                        Section {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                Text("add birthday")
                                    .font(.subheadline)
                            }
                        }
                    }
                    
                    Group {
                        Section {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                Text("add social profile")
                                    .font(.subheadline)
                            }
                        }
                        
                        Section {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                Text("add instant message")
                                    .font(.subheadline)
                            }
                        }
                    }
                    
                    Group {
                        Section(header: Text("")) {
                            Text("Notes")
                        }
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
    
    func cancel() {
        print("Clicked cancel")
    }
    
    func done() {
        print("Clicked done")
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}

struct PhoneNumbersSelectionView: View {
    @Binding var phoneNumbers: [ContactPhoneNumber]
    
    var body: some View {
        Section(header: Text("")) {
            ForEach(phoneNumbers) { phoneNumber in
                HStack {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                    NavigationLink(destination: SelectPhoneLabel()) {
                        Text("home")
                            .foregroundColor(.blue)
                    }
                    .frame(minWidth: 0, maxWidth: 100)
                    Rectangle()
                        .frame(width: 1, height: 30)
                        .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    Spacer()
                    Text("phone")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            Button(action: addPhone) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                    Text("add phone")
                        .font(.subheadline)
                    
                }
            }
        }
    }
    
    func addPhone() {
        self.phoneNumbers.append(ContactPhoneNumber(label: .home, number: ""))
    }
}

struct EmailsSelectionView: View {
    @Binding var emails: [ContactEmail]
    
    var body: some View {
        Section(header: Text("")) {
            ForEach(emails) { email in
                HStack {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                    NavigationLink(destination: SelectEmailLabel()) {
                        Text("home")
                            .foregroundColor(.blue)
                    }
                    .frame(minWidth: 0, maxWidth: 100)
                    Rectangle()
                        .frame(width: 1, height: 30)
                        .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    Spacer()
                    Text("email")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            Button(action: addEmail) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                    Text("add email")
                        .font(.subheadline)
                }
            }
        }
    }
    
    func addEmail() {
        self.emails.append(ContactEmail(label: .home, email: ""))
    }
}
