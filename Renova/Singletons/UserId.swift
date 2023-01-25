//
//  UserId.swift
//  Renova
//
//  Created by Igor Fernandes on 24/01/23.
//

import Foundation

class UserId {
    static let shared = UserId()
    var userId: String?
    private init() {}
}
