//
//  Labels.swift
//  ContactsSwiftUI
//
//  Created by Bruce Wade on 2020-05-16.
//  Copyright © 2020 Warply Designed Inc. All rights reserved.
//

import Foundation

enum PhoneNumberLabel: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    case home
    case work
    case school
    case iPhone
    case mobile
    case main
    case homeFax
    case workFax
    case pager
    case other
}

enum EmailLabel: String, CaseIterable, Identifiable {
    var id: String { rawValue}
    case home
    case work
    case school
    case iCloud
    case other
}
