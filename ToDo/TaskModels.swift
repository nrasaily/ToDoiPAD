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

struct Profile: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    var name: String
    var profileImage: String
    var groups: [TaskGroup]
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

extension Profile {
    static let sample: [Profile] = [
        Profile(name: "Nar Rasaily", profileImage: "professor_img", groups: TaskGroup.sampleData),
        Profile(name: "John Doe", profileImage: "student_img", groups: [])
    ]
}
