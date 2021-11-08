//
//  Position.swift
//  MartianRobots
//
//  Created by Marlon David Ruiz Arroyave on 7/11/21.
//

import Foundation

/// Represent a coordinate point (x, y) and the orientation (East, South, West, North)
struct Position {
    var coordinate: Point
    var orientation: Orientation
}

extension Position {
    /// The direction North corresponds to the direction from grid point (x, y) to grid point (x, y+1)
    mutating func north() {
        self.coordinate.y += 1
    }

    /// The direction South corresponds to the direction from grid point (x, y) to grid point (x, y-1)
    mutating func south() {
        self.coordinate.y -= 1
    }

    /// The direction South corresponds to the direction from grid point (x, y) to grid point (x+1, y)
    mutating func east() {
        self.coordinate.x += 1
    }

    /// The direction South corresponds to the direction from grid point (x, y) to grid point (x-1, y)
    mutating func west() {
        self.coordinate.x -= 1
    }

    /**
     Instantiate a new Positon or print an error

     - Parameters:
        - positionRaw: String that represents the position of the robot.
        - instructionRaw: String that represents all the instructions

     - Returns: Instance of a new `Position` or print an error
     */
    static func makePosition(_ data: String) -> Position? {
        let array = data.components(separatedBy: " ")
        guard array.count == 3, let x = Int(array[0]), let y = Int(array[1]) else {
            print("Creating robot's coordinate requires x and y need to be Int values\n Values sent: \(array[0]), \(array[1]).\n")
            return nil
        }
        guard let orientation = Orientation(rawValue: array[2]) else {
            print("Orientation should be one of these: N, S, E, W.\n Orientation sent: \(array[2]).\n")
            return nil
        }
        guard x <= 50, y <= 50 else {
            print("Creating robot's coordinate requires x and y need to be less or equal to 50\n Coordinate sent: \(array[0]), \(array[1]).\n")
            return nil
        }
        let point = Point(x: x, y: y)
        return Position(coordinate: point, orientation: orientation)
    }
}
