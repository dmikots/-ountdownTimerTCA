//
//  CountdownTimerTCAApp.swift
//  CountdownTimerTCA
//
//  Created by Р71 on 18.03.2022.
//

import SwiftUI
import ComposableArchitecture

@main
struct CountdownTimerTCAApp: App {
    var body: some Scene {
        WindowGroup {
            TimerView(store: Store(initialState: TimerState(), reducer: timerReducer, environment: TimerEnvironment(mainQueue: .main)))
        }
    }
}
