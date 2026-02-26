//
//  TaskGroupDetailView.swift
//  ToDo
//
//  Created by Nar Rasaily on 1/24/26.
///System/Applications/Calculator.app
import SwiftUI

struct TaskGroupDetailView: View {
    @Binding var group: TaskGroup
    @Environment(\.horizontalSizeClass) var sizeClass
    //@Binding private var selectedPriority: String
    
    var body: some View {
        List {
            Section {
                if sizeClass == .regular {
                    GroupStatsView(tasks: group.tasks)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color(.secondarySystemBackground))
                }
            }
            
            ForEach($group.tasks) {$task in
                HStack {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(task.isCompleted ? .cyan : .gray)
                        .onTapGesture {
                            withAnimation {
                                task.isCompleted.toggle()
                            }
                        }
                        .accessibilityIdentifier("task-toggle-button \(task.id)") 
                    TextField("Task title", text: $task.title)
                        .strikethrough(task.isCompleted)
                        .foregroundStyle(task.isCompleted ? .gray : .primary)
                        .accessibilityIdentifier("Task: \(task.title)")
                }
                HStack {
                    DatePicker("Goal Date", selection: $task.dueDate,
                               displayedComponents: .date)
                        .labelsHidden()
                        .scaleEffect(0.8)
                        .accessibilityIdentifier("TaskDatePicker")
                    
                    Text("Due: \(task.dueDate.formatted( date: .abbreviated, time: .omitted))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .accessibilityIdentifier("TaskDateLabel")
                    
                    Picker("Priority", selection: $task.priority) {
                        Text("Low").tag(Priority.low)
                        Text("Medium").tag(Priority.medium)
                        Text("High").tag(Priority.high)
                    }
                    .accessibilityIdentifier("priority_picker")
                }
            }
            .onDelete { index in
                group.tasks.remove(atOffsets: index)
            }
        }
        .navigationTitle(group.title)
        .toolbar {
            Button("Add Task") {
                withAnimation {
                    group.tasks.append(TaskItem(title: ""))
                }
            }
            .accessibilityIdentifier("Add Task")
        }
    }
}

