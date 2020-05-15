//
//  AddContactView.swift
//  ContactsSwiftUI
//
//  Created by Bruce Wade on 2020-05-15.
//  Copyright © 2020 Warply Designed Inc. All rights reserved.
//

import SwiftUI

struct AddContactView: View {
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
                    
                    Section(header: Text("")) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                            Text("add phone")
                                .font(.subheadline)
                        }
                    }
                    
                    Section {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                            Text("add email")
                                .font(.subheadline)
                        }
                    }
                    
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
