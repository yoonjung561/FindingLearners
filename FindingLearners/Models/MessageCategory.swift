//
//  MessageCategory.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/20/26.
//

import Foundation

enum MessageCategory: String, CaseIterable, Identifiable {
    case incoming, outgoing
    var id: Self { self }
}
