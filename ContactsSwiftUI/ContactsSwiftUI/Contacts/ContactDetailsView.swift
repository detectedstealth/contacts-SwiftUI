//
//  ContactDetailsView.swift
//  ContactsSwiftUI
//
//  Created by Bruce Wade on 2020-03-01.
//  Copyright © 2020 Warply Designed Inc. All rights reserved.
//

import SwiftUI
import Contacts
import MessageUI

struct ContactDetailsView: View {
    @State var contact: Contact
    
    private let mailComposeDelegate = MailComposerDelegate()
    private let messageComposeDelegate = MessageComposerDelegate()
    
    var body: some View {
        ScrollView {
            VStack {
                if contact.image != nil {
                    contact.image!
                        .resizable()
                        .frame(width: 60, height: 60, alignment: .center)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 60, height: 60, alignment: .center)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .padding(5)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                }
                Text(contact.fullName)
                
                HStack(spacing: 25.0) {
                    ActionButton(text: "message", icon: "message.fill") {
                        let numberUrl = "sms:\(self.contact.phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression))"
                        print(numberUrl)
                        UIApplication.shared.open(URL(string: numberUrl)!)
                    }
                    ActionButton(text: "call", icon: "phone.fill", isEnabled: false)
                    ActionButton(text: "video", icon: "video.fill", isEnabled: false)
                    ActionButton(text: "mail", icon: "envelope.fill") {
//                        self.presentMailCompose(to: self.contact.email)
                        UIApplication.shared.open(URL(string: "mailto:\(self.contact.email)")!)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.top, 10)
            .background(Color("DetailsBackground"))
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct ContactDetailsView_Previews: PreviewProvider {
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
        
        return ContactDetailsView(contact: Contact(contact: contact))
    }
}

struct ActionButton: View {
    var text: String
    var icon: String
    var isEnabled = true
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16, alignment: .center)
                    .padding(8)
                    .foregroundColor(isEnabled ? Color.white : Color.gray)
                    .background(isEnabled ? Color.blue : Color.clear)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                Text(text)
                    .font(.caption)
                    .foregroundColor(isEnabled ? Color.blue : Color.gray)
            }
        }
    }
}

extension ContactDetailsView {

    private class MailComposerDelegate: NSObject, MFMailComposeViewControllerDelegate {
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            
            controller.dismiss(animated: true)
        }
    }
    
    private func presentMailCompose(to recipient: String) {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let vc = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = mailComposeDelegate
        composeVC.setToRecipients([recipient])
        
        vc?.present(composeVC, animated: true)
    }
    
}

extension ContactDetailsView {
    
    private class MessageComposerDelegate: NSObject, MFMessageComposeViewControllerDelegate {
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            // Customize here
            controller.dismiss(animated: true)
        }
    }
    /// Present an message compose view controller modally in UIKit environment
    private func presentMessageCompose(to recipient: String) {
        guard MFMessageComposeViewController.canSendText() else {
            return
        }
        let vc = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = messageComposeDelegate
        composeVC.recipients = [recipient]

        vc?.present(composeVC, animated: true)
    }
}
