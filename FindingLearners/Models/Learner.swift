//
//  Learner.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/17/26.
//

import Foundation
import SwiftData
import UIKit

struct LearnerData: Decodable {
    var isCurrentUser: Bool
    var name: String
    var email: String
    var favTopics: [String]
    var imageData: Data?
}

@Model
class Learner {
    var id = UUID()
    var isCurrentUser: Bool
    var name: String
    var email: String
    var favTopics: [String]
    var imageData: Data?
    
    init(fromStruct learner: LearnerData) {
        self.isCurrentUser = learner.isCurrentUser
        self.name = learner.name
        self.email = learner.email
        self.favTopics = learner.favTopics
        self.imageData = learner.imageData
    }
    
    init(isCurrentUser: Bool, name: String, email: String, favTopics: [String], imageData: Data? = nil) {
        self.isCurrentUser = isCurrentUser
        self.name = name
        self.email = email
        self.favTopics = favTopics
        self.imageData = imageData
    }
    
    var image: UIImage? {
        imageData.flatMap {
            UIImage(data: $0)
        }
    }
}
