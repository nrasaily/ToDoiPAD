//
//  TaskModels.swift
//  ToDo
//
//  Created by Nar Rasaily on 1/24/26.
//
import Foundation
import SwiftUI

enum Priority: String, Codable, CaseIterable {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}

struct TaskItem: Identifiable, Hashable, Codable {
    
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    var dueDate: Date = Date()
    var priority: Priority = .medium
    
}
struct TaskGroup: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

// Mock Data
extension TaskGroup {
    static var sampleData: [TaskGroup] = [
        TaskGroup(title: "School", symbolName: "book.fill", tasks: [TaskItem(title: "Grade Assignments"),
            TaskItem(title: "Prepare Lecture")]),
        TaskGroup(title: "Home", symbolName: "house.fill", tasks: [
            TaskItem(title: "Buy Groceries", isCompleted:true),
            TaskItem(title: "Walk the dog")])
        
    ]
}
