//
//  Message.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/20/26.
//

import Foundation
import SwiftData

struct MessageData: Decodable {
    var sender: LearnerData
    var recipient: LearnerData
    var message: String
    var timestamp: Date
}

@Model
class Message {
    var sender: Learner
    var recipient: Learner
    var message: String
    var timestamp: Date
    
    init(fromStruct message: MessageData) {
        self.sender = Learner(fromStruct: message.sender)
        self.recipient = Learner(fromStruct: message.recipient)
        self.message = message.message
        self.timestamp = message.timestamp
    }
    
    init(sender: Learner, recipient: Learner, message: String) {
        self.sender = sender
        self.recipient = recipient
        self.message = message
        self.timestamp = .now
    }
}
