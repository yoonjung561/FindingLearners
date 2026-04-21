//
//  Learner.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/17/26.
//

import Foundation
import SwiftData
import UIKit

@Model
class Learner {
    var isCurrentUser: Bool
    var name: String
    var email: String
    var favTopics: [String]
    var imageData: Data?
    
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
