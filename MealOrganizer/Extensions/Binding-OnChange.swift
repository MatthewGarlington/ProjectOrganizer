//
//  Binding-OnChange.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: {  newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}
