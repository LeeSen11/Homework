//
//  GridModel.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 5/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import ComposableArchitecture
import Combine
import GameOfLife
import Foundation

public struct GridState {
    public var grid: Grid = Grid(10, 10, Grid.Initializers.random)
    public var ticks: Int = 0

    public init(grid: Grid = Grid(10, 10, Grid.Initializers.random), ticks: Int = 0) {
        self.grid = grid
        self.ticks = ticks
    }
}

extension GridState: Equatable { }

extension GridState: Codable { }

public extension GridState {
    enum Action {
        case step
    }
}

public let gridReducer = Reducer<GridState, GridState.Action, GridEnvironment> { state, action, env in
    switch action {
    case .step:
        state.grid = state.grid.next
        return .none
    }
}

public struct GridEnvironment {
    public init() { }
}

public struct GridTestEnvironment {
    public init() { }
}
