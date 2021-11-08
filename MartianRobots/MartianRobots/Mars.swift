//
//  Mars.swift
//  MartianRobots
//
//  Created by Marlon David Ruiz Arroyave on 7/11/21.
//

import Foundation

protocol MarsProtocol {
    var upperRight: Point { get }
    mutating func addRobot(_ robot: Robot)
    mutating func moveOff(_ robot: inout Robot)
    mutating func walkRobots()
}

struct Mars: MarsProtocol {
    /// The first line of input is the upper-right coordinates of the rectangular world.
    let upperRight: Point

    /// The scent is left at the last grid position the robot occupied before disappearing over the edge.
    private var scents: [Point]?
    private var robots: [Robot]?

    init(upperRight: Point) {
        self.upperRight = upperRight
    }

    /// Add a robot into the robot's array.
    mutating func addRobot(_ robot: Robot) {
        if robots == nil {
            robots = [Robot]()
        }
        self.robots?.append(robot)
    }

    /// Read the robot's instructions to know where to move it.
    private mutating func readRobotInstructions(_ robot: inout Robot) {
        for instruction in robot.instructions {
            if robot.lost ?? false {
                break
            }
            switch instruction {
            case .l:
                robot.left()
            case .r:
                robot.right()
            case .f:
                if shouldRobotMoveOff(robot.position) {
                    guard shouldRobotForwardFromPosition(robot.position) else { continue }
                    moveOff(&robot)
                } else {
                    robot.forward()
                }
            }
        }
    }

    /// Validate if a robot should move forward from its current position.
    /// Returns true if it can move forward, otherwise false.
    private func shouldRobotForwardFromPosition(_ position: Position) -> Bool {
        guard let scents = scents else { return true }
        return !scents.contains(position.coordinate)
    }

    /// Validate if a robot should move off from its current position.
    /// Returns true if it can move off, otherwise false.
    private func shouldRobotMoveOff(_ position: Position) -> Bool {
        switch position.orientation {
        case .e:
            let x = position.coordinate.x + 1
            return upperRight.x >= x ? false : true
        case .s:
            let y = position.coordinate.y - 1
            return Self.lowerLeft.y <= y ? false : true
        case .w:
            let x = position.coordinate.x - 1
            return Self.lowerLeft.x <= x ? false : true
        case .n:
            let y = position.coordinate.y + 1
            return upperRight.y >= y ? false : true
        }
    }

    /// Print the robot's location.
    private func outputRobotLocation(_ robot: Robot) {
        print("\(String(describing: robot.location()))")
    }

    /// An instruction to move “off” the world from a grid point from which a robot has been previously lost is simply ignored by the current robot.
    mutating func moveOff(_ robot: inout Robot) {
        if scents == nil {
            scents = [Point]()
        }
        scents?.append(robot.position.coordinate)
        robot.lost = true
    }

    mutating func walkRobots() {
        guard let robots = robots else { return }
        for var robot in robots {
            readRobotInstructions(&robot)
            outputRobotLocation(robot)
        }
    }
}

extension Mars {
    /// the lower-left coordinates are assumed to be 0, 0.
    static let lowerLeft: Point = Point(x: 0, y: 0)

    /**
     Instantiate a new Mars or print an error

     - Parameters:
        - data: String that represents the position of the robot.

     - Returns: Instance of a new `Mars` or print an error
     */
    static func makeMarsPlanet(_ data: String) -> Mars? {
        let array = data.components(separatedBy: " ")
        guard array.count == 2, let x = Int(array[0]), let y = Int(array[1]) else {
            print("Creating mars requires x and y need to be Int values\n Values sent: \(array[0]), \(array[1]).\n")
            return nil
        }
        guard x <= 50, y <= 50 else {
            print("Creating mars requires x and y need to be less or equal to 50\n Position sent: \(array[0]), \(array[1]).\n")
            return nil
        }
        let upperRight = Point(x: x, y: y)
        return Mars(upperRight: upperRight)
    }
}
