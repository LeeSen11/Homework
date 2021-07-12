//
//  SimulationView.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 5/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import SwiftUI
import ComposableArchitecture
import Simulation
import Grid

public struct SimulationView: View {
    let store: Store<SimulationState, SimulationState.Action>

    public init(store: Store<SimulationState, SimulationState.Action>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text("Simulation")
                    .font(.system(size: 32))
                    .padding([.leading], 16.0)
                Spacer()
            }
            .padding([.bottom], 12.0)
            
            self.buttonStack(self.store)
                .background(Color.white)
                .padding([.bottom], 12.0)
            
            HStack {
                Spacer()
                self.gridView(self.store)
                Spacer()
            }
            .background(Color("simulationBackground"))
            
            Spacer()
                .background(Color.white)
        }
    }
    
    func gridView(_ store: Store<SimulationState, SimulationState.Action>) -> some View {
        GridView(
            store: self.store.scope(
                state: \.gridState,
                action: SimulationState.Action.grid(action:)
            )
        )
    }

    func buttonView(
        _ viewStore: ViewStore<SimulationState, SimulationState.Action>,
        title: String,
        action: SimulationState.Action,
        onOff: Bool
    ) -> some View {
        Button(action: { viewStore.send(action) }) {
            Text(title)
                .font(.system(size: 12.0))
                .multilineTextAlignment(.center)
        }
        .padding([.top, .bottom], 8.0)
        .padding([.leading, .trailing], 4.0)
        .disabled(onOff)
    }

    func buttonStack(_ store: Store<SimulationState, SimulationState.Action>) -> some View {
        WithViewStore(store) { viewStore in
            HStack {
                Spacer()
                Group {
                    self.buttonView(viewStore, title: "Place\nHolder", action: .none, onOff: true)
                    self.buttonView(viewStore, title: "Empty\nGrid", action: .resetGridToEmpty, onOff: !viewStore.isRunningTimer)
                    self.buttonView(viewStore, title: "Random\nGrid", action: .resetGridToRandom, onOff: !viewStore.isRunningTimer)
                    self.buttonView(viewStore, title: "Start\nTimer", action: .startTimer, onOff: viewStore.isRunningTimer)
                    self.buttonView(viewStore, title: "Stop\nTimer", action: .stopTimer, onOff: !viewStore.isRunningTimer)
                    self.buttonView(viewStore, title: "Reset\nTicks", action: .reset, onOff: !viewStore.isRunningTimer)
                }
                Spacer()
            }
        }
    }
}

public struct SimulationView_Previews: PreviewProvider {
    static let previewState = SimulationState()
    public static var previews: some View {
        SimulationView(
            store: Store(
                initialState: previewState,
                reducer: simulationReducer,
                environment: SimulationEnvironment()
            )
        )
    }
}
