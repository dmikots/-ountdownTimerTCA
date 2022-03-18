//
//  ContentView.swift
//  CountdownTimerTCA
//
//  Created by Р71 on 18.03.2022.
//

import SwiftUI
import ComposableArchitecture

struct TimerView: View {
    let store: Store<TimerState, TimerAction>
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack{
                Text("\(viewStore.state.minute) minuts \(viewStore.state.seconds) seconds " )
            .padding()
            .background(
                Color.blue
            )
                Button(action: {
                    viewStore.send(.startTimer)
                }) {
                    Text(viewStore.state.paidTimer ?  "Stop Timer" :  "Start timer")
                        .foregroundColor(.white)
                        .padding()
                }
                .background(
                    Color.red
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(store: Store(initialState: TimerState(), reducer: timerReducer, environment: TimerEnvironment(mainQueue: .main)))
    }
}
