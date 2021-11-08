//
//  File.swift
//  MartianRobots
//
//  Created by Marlon David Ruiz Arroyave on 8/11/21.
//

import Foundation

struct File { }

extension File {
    /**
     Read a file to return a Mars or print an error.

     - Parameters:
        - data: String that represents the position of the robot.

     - Returns: Instance of a new `Mars` or print an error.
     */
    static func readFile(_ resource: String = "input", type: String = "txt") -> Mars? {
        var mars: Mars?
        let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let bundleURL = URL(fileURLWithPath: "InputStub.bundle", relativeTo: currentDirectoryURL)

        guard let bundle = Bundle(url: bundleURL) else {
            print("There is not bundle")
            return nil
        }

        guard let path = bundle.path(forResource: resource, ofType: type) else {
            print("The file does not exist!")
            return nil
        }

        do {
            let string =  try String(contentsOfFile: path, encoding: String.Encoding.utf8)

            let components = string.components(separatedBy: "\n\n")
            for component in components {
                let nestedComponent: [(String)] = component.components(separatedBy: "\n").compactMap { element in
                    if !element.isEmpty {
                        return element
                    }
                    return nil
                }
                if nestedComponent.count == 3 {
                    mars = Mars.makeMarsPlanet(nestedComponent[0])
                    guard let robot = Robot.makeRobot(positionRaw: nestedComponent[1], instructionsRaw: nestedComponent[2]) else { continue }
                    mars?.addRobot(robot)
                } else {
                    guard let robot = Robot.makeRobot(positionRaw: nestedComponent[0], instructionsRaw: nestedComponent[1]) else { continue }
                    mars?.addRobot(robot)
                }
            }
            return mars
        } catch {
            print("Wrong encoding!")
            return nil
        }
    }

}
