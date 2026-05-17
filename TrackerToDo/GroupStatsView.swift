//
//  GroupStatsView.swift
//  TrackerToDo
//
//  Created by David Emery on 5/16/26.
//

import SwiftUI

struct GroupStatsView: View {
    var tasks: [TaskItem]
    var completedCount: Int {tasks.filter {$0.isCompleted}.count}
    var progress: Double { tasks.isEmpty ? 0 : Double(completedCount) / Double(tasks.count)}
    
    
    var body: some View {
        HStack{
            ZStack{
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(.cyan)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .foregroundColor(.cyan)
                    .rotationEffect(.degrees(-90))
                
                Text("\(Int(progress * 100))%")
                    .font(.caption)
                    .bold()
            }
            .frame(width: 40, height: 40)
            .padding()
            
            VStack(alignment: .leading){
                Text("Tasks Progress")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                Text("\(completedCount) out of \(tasks.count) Completed")
                    .font(.title2)
                    .bold()
            }
        }
    }
}
