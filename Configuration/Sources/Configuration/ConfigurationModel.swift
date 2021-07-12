//
//  ConfigurationModel.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 6/1/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import ComposableArchitecture
import Combine
import GameOfLife

public struct ConfigurationState {
    public var configuration: Grid.Configuration
    public init(configuration: Grid.Configuration) {
        self.configuration = configuration
    }
}

extension ConfigurationState {
    public enum Action {
        case none
    }
}

extension ConfigurationState: Equatable, Identifiable {
    public var id: UUID {
        configuration.id
    }
}

extension ConfigurationState: Codable { }

public struct ConfigurationEnvironment {
    public init() { }
}

public struct ConfigurationTestEnvironment {
    public init() { }
}

public let configurationReducer = Reducer<ConfigurationState, ConfigurationState.Action, ConfigurationEnvironment>{ state, action, env in
    switch action {
    case .none:
        return .none
    }
}

