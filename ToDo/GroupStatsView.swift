//
//  GroupStatsView.swift
//  ToDo
//
//  Created by Nar Rasaily on 1/26/26.
//

import  SwiftUI

struct GroupStatsView: View {
    var tasks: [TaskItem]
    var completedCount: Int { tasks.filter { $0.isCompleted }.count}
    var progress: Double {
        tasks.isEmpty ? 0 : Double(completedCount) / Double(tasks.count)
    }
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(.purple)
                    .accessibilityIdentifier("Progress_background")
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .foregroundColor(.purple)
                    .rotationEffect(.degrees(-90))
                    .accessibilityIdentifier("Progress_circle")
                
                Text("\(Int(progress * 100))%")
                    .font(.caption)
                    .bold()
                    .accessibilityIdentifier("Progress")
            }
            .frame(width: 60, height: 60)
            .padding()
            
            VStack(alignment: .leading) {
                Text("Task Progress")
                    .accessibilityIdentifier("Task_Progress")
                Text("\(completedCount)/\(tasks.count)completed")
                    .accessibilityIdentifier("Completed_count: \(tasks.count)")
            }
            Spacer()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)
        }
    }
    
}
