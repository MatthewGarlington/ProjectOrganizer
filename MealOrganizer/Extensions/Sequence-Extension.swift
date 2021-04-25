//
//  Sequence-Extension.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import Foundation

extension Sequence {
    func sorted<Value>(by keyPath: KeyPath<Element,
                                           Value>,
                       using areInIncreasingOrder: (Value, Value) throws -> Bool)
    rethrows -> [Element] {
        try self.sorted {
            try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
        }
    }
    
    func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Element] {
        self.sorted(by: keyPath, using: <)
    }
}
