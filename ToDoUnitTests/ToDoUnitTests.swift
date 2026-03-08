//
//  ToDoUnitTests.swift
//  ToDoUnitTests
//
//  Created by Nar Rasaily on 2/9/26.
//

import XCTest
@testable import ToDo

class ToDoTests: XCTestCase {
    
    // Always needs to starts with the word test
    func testProgressCalculation() {
        // Arrange: have all the variable we need to make the rteset work
        
        let tasks = [
            TaskItem(title: "test1", isCompleted: false),
            TaskItem(title: "test2", isCompleted: true),
            TaskItem(title: "test3", isCompleted: true),
            TaskItem(title: "test4", isCompleted: false),
        ]
        
        let group = TaskGroup(title: "GroupTest", symbolName: "house.fill", tasks: tasks)
        
        // ACT: Calculating the logic
        let completedCount = group.tasks.filter{$0.isCompleted}.count
        let progress = Double(completedCount) / Double(group.tasks.count)
        
        // ASSERT: What is the final output of the logic
        XCTAssertEqual(progress, 0.5, "Progress should be 50% when half the tasks are done.")
    }
    
    //func test{
        
    //}
}
