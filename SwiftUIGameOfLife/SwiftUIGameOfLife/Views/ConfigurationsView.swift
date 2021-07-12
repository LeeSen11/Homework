//
//  ConfigurationView.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 5/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import SwiftUI
import ComposableArchitecture
import Configurations
import Configuration

public struct ConfigurationsView: View {
    let store: Store<ConfigurationsState, ConfigurationsState.Action>

    public init(store: Store<ConfigurationsState, ConfigurationsState.Action>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                HStack {
                    Text("Configuration")
                        .font(.system(size: 32))
                        .padding([.leading], 16.0)
                    Spacer()
                }
                Spacer()
                
                List {
//                    ForEachStore(viewStore.configs, content: viewStore.)
//                    ForEachStore(viewStore, content: )
                }
                
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        viewStore.send(ConfigurationsState.Action.fetch)
                    }) {
                        Text("Fetch").font(.system(size: 24.0))
                    }
                    .padding([.top, .bottom], 8.0)
                    
                    Spacer()
                    
                    Button(action: {
                        viewStore.send(ConfigurationsState.Action.fetch)
                    }) {
                        Text("Clear").font(.system(size: 24.0))
                    }
                    .padding([.top, .bottom], 8.0)
                    
                    Spacer()
                }
                .padding([.top, .bottom], 8.0)
            }
        }
    }
}

public struct ConfigurationsView_Previews: PreviewProvider {
    static let previewState = ConfigurationsState()
    public static var previews: some View {
        ConfigurationsView(
            store: Store(
                initialState: previewState,
                reducer: configurationsReducer,
                environment: ConfigurationsEnvironment()
            )
        )
    }
}
