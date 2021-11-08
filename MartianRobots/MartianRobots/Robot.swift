//
//  Robot.swift
//  MartianRobots
//
//  Created by Marlon David Ruiz Arroyave on 7/11/21.
//

import Foundation

/*
 There is also a possibility that additional command types may be required in the future and provision should be made for this.

 Applying the principle YAGNI: You ain't gonna need it!
 */

struct Robot {
    var position: Position
    private(set) var instructions: [Instruction]
    var lost: Bool?

    /**
     Instantiate a new Robot

     - Parameters:
        - position: The position of the robot.
        - instruction: A string that represents all the instructions

     - Returns: Instance of a new `Robot`
     */
    init(position: Position, instruction: String) {
        self.position = position
        self.instructions = instruction.compactMap { Instruction(rawValue: String($0)) }
    }

    /// The robot turns left 90 degrees and remains on the current grid point.
    mutating func left() {
        position.orientation.nextLeft()
    }

    /// the robot turns right 90 degrees and remains on the current grid point.
    mutating func right() {
        position.orientation.nextRight()
    }

    /// the robot moves forward one grid point in the direction of the current orientation
    /// and maintains the same orientation.
    mutating func forward() {
        switch position.orientation {
        case .e:
            position.east()
        case .s:
            position.south()
        case .w:
            position.west()
        case .n:
            position.north()
        }
    }

    /// Return the position and orientation of the robot.
    func location() -> String {
        return "\(position.coordinate.x) \(position.coordinate.y) \(position.orientation.rawValue) \(lost ?? false ? "LOST" : "")"
    }
}

extension Robot {
    /**
     Instantiate a new Robot or print an error

     - Parameters:
        - positionRaw: String that represents the position of the robot.
        - instructionRaw: String that represents all the instructions

     - Returns: Instance of a new `Robot` or print an error
     */
    static func makeRobot(positionRaw: String, instructionsRaw: String) -> Robot? {
        guard instructionsRaw.count <= 100 else {
            print("Robot's instruction strings need to be less than 100 characters in length.\n Value: \(instructionsRaw), \n Lenght is: \(instructionsRaw.count)\n")
            return nil
        }

        guard let position = Position.makePosition(positionRaw) else {
            return nil
        }

        let filter = instructionsRaw.filter { "LFR".contains($0) }
        guard filter.count == instructionsRaw.count else {
            print("Robot's instructions accepted are L, R, F.\n Instructions sent are: \(instructionsRaw)\n")
            return nil
        }

        return Robot(position: position, instruction: instructionsRaw)
    }
}
