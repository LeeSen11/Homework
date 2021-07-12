//
//  Application.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 5/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import ComposableArchitecture
import Combine
import FunctionalProgramming
import Simulation
import Configurations
import Statistics
import Foundation

struct AppState: Equatable {
    var selectedTab = Tab.simulation
    var simulationState = SimulationState()
    var configurationState = ConfigurationsState()
    var statisticsState = StatisticsState()
}

extension AppState: Codable { }

extension AppState {
    enum Tab {
        case simulation
        case configuration
        case statistics
    }
}

extension AppState {
    enum Action {
        case setSelectedTab(tab: Tab)
        case simulationAction(action: SimulationState.Action)
        case configurationAction(action: ConfigurationsState.Action)
        case statisticsAction(action: StatisticsState.Action)
    }
}

struct AppEnvironment {
    var simulationEnvironment = SimulationEnvironment()
    var configurationsEnvironment = ConfigurationsEnvironment()
    var statisticsEnvironment = StatisticsEnvironment()
}

let _appReducer = Reducer<AppState, AppState.Action, AppEnvironment>.combine(
    /// Submodel reducers
    simulationReducer.pullback(
        state: \.simulationState,
        action: /AppState.Action.simulationAction,
        environment: \.simulationEnvironment
    ),
    configurationsReducer.pullback(
        state: \.configurationState,
        action: /AppState.Action.configurationAction,
        environment: \.configurationsEnvironment
    ),
    statisticsReducer.pullback(
        state: \.statisticsState,
        action: /AppState.Action.statisticsAction,
        environment: \.statisticsEnvironment
    ),
    /// Main reducer
    Reducer { state, action, env in
        switch action {
            case .setSelectedTab(let tab):
                state.selectedTab = tab
            default:
                ()
        }
        state.save()
        return .none
    }
)

var appReducer: Reducer<AppState, AppState.Action, AppEnvironment> {
    #if DEBUG
    return _appReducer.debug()
    #else
    return _appReducer
    #endif
}
