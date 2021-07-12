//
//  GridView.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 5/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import SwiftUI
import ComposableArchitecture
import Grid

public struct GridView: View {
    let store: Store<GridState, GridState.Action>

    public init(store: Store<GridState, GridState.Action>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Spacer()
                
                Text("Ticks: \(viewStore.ticks)")
                    .font(.system(size: 24.0))
                    .padding([.top, .bottom], 8.0)
                
                Text("# Living: \(viewStore.grid.count([.alive], in: viewStore.grid.allOffsets))")
                    .font(.system(size: 24.0))
                    .padding([.top, .bottom], 8.0)
                
                Spacer()
            }
        }
    }
}

public struct GridView_Previews: PreviewProvider {
    static let previewState = GridState()
    public static var previews: some View {
        GridView(
            store: Store(
                initialState: previewState,
                reducer: gridReducer,
                environment: GridEnvironment()
            )
        )
    }
}
