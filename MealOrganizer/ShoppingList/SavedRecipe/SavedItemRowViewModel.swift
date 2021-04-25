//
//  SavedItemRowViewModel.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/11/21.
//

import Foundation


extension SavedItemRow {
    class ViewModel: ObservableObject {
        
        let project: Project
        let item: Item

        var title: String {
            item.itemTitle
        }

        var icon: String {

            if item.completed {
                return "checkmark.circle"
            } else if item.priority == 3 {
                return  "exclamationmark.triangle"
            } else {
                return "circle"
            }
        }
        var color: String? {

            if item.completed {
                return nil
            } else if item.priority == 3 {
                return nil
            } else {
                return nil
            }
        }
        init(project: Project, item: Item) {
            self.project = project
            self.item = item
        }
    }
}

