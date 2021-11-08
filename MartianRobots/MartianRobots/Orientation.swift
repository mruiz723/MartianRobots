//
//  Orientation.swift
//  MartianRobots
//
//  Created by Marlon David Ruiz Arroyave on 7/11/21.
//

import Foundation

enum Orientation: String, CaseIterable {
    /// East
    case e = "E"
    /// South"
    case s = "S"
    /// Weast
    case w = "W"
    /// North
    case n = "N"
}

extension Orientation {
    /// Turns left 90 degrees from its orientation
    mutating func nextLeft() {
        switch self {
        case .e:
            self = .n
        case .n:
            self = .w
        case .w:
            self = .s
        case .s:
            self = .e
        }
    }

    /// Turns right 90 degrees from its orientation
    mutating func nextRight() {
        switch self {
        case .e:
            self = .s
        case .s:
            self = .w
        case .w:
            self = .n
        case .n:
            self = .e
        }
    }
}
