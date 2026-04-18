//
//  FindingLearnersApp.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 3/25/26.
//

import SwiftUI
import SwiftData

@main
struct FindingLearnersApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Learner.self)
    }
}
