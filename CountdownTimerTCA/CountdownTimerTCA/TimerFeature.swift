//
//  TimerFeature.swift
//  CountdownTimerTCA
//
//  Created by Р71 on 18.03.2022.
//

import Foundation
import ComposableArchitecture

struct TimerState: Equatable{
    var minute = 5
    var seconds = 00
    var paidTimer = false
}

enum TimerAction {
    case timerTicked
    case timerAction
    case startTimer
}

struct TimerEnvironment {
    //You can create mainQueue at SystemEnvironment
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let timerReducer = Reducer<
    TimerState,
    TimerAction,
TimerEnvironment
> { state, action, environment in
    struct TimerId: Hashable {}
    switch action {
    case .timerTicked:
        print(state.seconds)
        print(state.minute)
        if state.seconds == 00, state.minute == 00 {
            state.paidTimer = false
            state.minute = 5
            state.seconds = 00
            return Effect(value: .timerAction)
        }
        if state.seconds == 0 {
            state.seconds = 59
            state.minute -= 1
        } else {
            state.seconds -= 1
        }
        return Effect(value: .timerAction)
    case .timerAction:
        print(state.paidTimer)
        return state.paidTimer
            ? Effect.timer(
                id: TimerId(),
                every: .seconds(1),
                tolerance: .zero,
                on: environment.mainQueue
            )
            .map { _ in TimerAction.timerTicked }
            : Effect.cancel(id: TimerId())
    case .startTimer:
        state.paidTimer.toggle()
        return Effect(value: .timerAction)
    default:
        return .none
    }
    return .none
}

