//
//  ApplicationModelPersistence.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 7/4/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import Foundation

extension AppState {
    func save() {
        guard let data = self.data else { return }
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: AppState.defaultsKey)
        defaults.synchronize()
    }

    static func restore() -> AppState {
        guard let savedData = UserDefaults.standard.data(forKey: AppState.defaultsKey) else {
            return AppState()
        }
        return AppState(data: savedData) ?? AppState()
    }
}

extension AppState {
    static let defaultsKey = "AppState"
    static let jsonDecoder = JSONDecoder()
    static let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return encoder
    }()

    var data: Data? {
        try? Self.jsonEncoder.encode(self) 
    }

    init?(data: Data) {
        do {
            self = try Self.jsonDecoder.decode(AppState.self, from: data)
        } catch {
            return nil
        }
    }
}

extension AppState.Tab: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        switch rawValue {
            case 0: self = .simulation
            case 1: self = .configuration
            case 2: self = .statistics
            default: throw CodingError.unknownValue
        }
    }

    enum Key: CodingKey {
        case rawValue
    }

    enum CodingError: Error {
        case unknownValue
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
            case AppState.Tab.simulation: try container.encode(0, forKey: .rawValue)
            case AppState.Tab.configuration: try container.encode(1, forKey: .rawValue)
            case AppState.Tab.statistics: try container.encode(2, forKey: .rawValue)
        }
    }
}
