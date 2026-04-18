//
//  Learner.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/17/26.
//

import Foundation
import SwiftData

@Model
class Learner {
    var isCurrentUser: Bool
    var name: String
    var email: String
    var favTopics: [String]
    
    init(isCurrentUser: Bool, name: String, email: String, favTopics: [String]) {
        self.isCurrentUser = isCurrentUser
        self.name = name
        self.email = email
        self.favTopics = favTopics
    }
}
