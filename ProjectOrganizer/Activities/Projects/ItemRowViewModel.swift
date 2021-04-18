//
//  ItemRowViewModel.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/3/21.
//

import Foundation

extension ItemRowView {
    class ViewModel: ObservableObject {
       
        let project: Project
        let item: Item
        
        var title: String {
            item.itemTitle
        }

        var amount: String {
            item.itemAmount
        }
        var icon: String {
            
            if item.completed {
                return "checkmark"
            } else if item.priority == 3 {
                return  "exclamationmark"
            } else {
                return "circlebadge"
            }
        }
        var color: String? {
            
            if item.completed {
                return project.projectColor
            } else if item.priority == 3 {
                return project.projectColor
            } else {
                return project.projectColor
            }
        }
         init(project: Project, item: Item) {
            self.project = project
            self.item = item
        }
    }
}

extension CheckButton {
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
                return project.projectColor
            } else if item.priority == 3 {
                return project.projectColor
            } else {
                return project.projectColor
            }
        }
         init(project: Project, item: Item) {
            self.project = project
            self.item = item
        }



    }
}

extension CheckOffItemButton {
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
                return project.projectColor
            } else if item.priority == 3 {
                return project.projectColor
            } else {
                return project.projectColor
            }
        }
         init(project: Project, item: Item) {
            self.project = project
            self.item = item
        }



    }
}
