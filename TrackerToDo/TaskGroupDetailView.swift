//
//  TaskGroupDetailView.swift
//  TrackerToDo
//
//  Created by David Emery on 5/12/26.
//

import SwiftUI

struct TaskGroupDetailView: View {
    @Binding var groups: TaskGroup
    @Environment(\.horizontalSizeClass) var sizeClass
    
    
    var body: some View {
        List{
            Section{
                if sizeClass == .regular{
                    GroupStatsView(tasks: groups.tasks)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color(.secondarySystemBackground))
                }
            }
            
            ForEach($groups.tasks) { $task in
                HStack{
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    foregroundStyle(task.isCompleted ? .blue : .gray)
                    onTapGesture {
                        withAnimation{
                            task.isCompleted.toggle()
                        }
                    }
                    TextField("Task title", text: $task.title)
                        .strikethrough(task.isCompleted)
                        .foregroundColor(task.isCompleted ? .brown : .primary)
                }
            }
            .onDelete { index in
                groups.tasks.remove(atOffsets: index)
            }
        }
        .navigationTitle(groups.title)
        .toolbar{
            Button("Add Task"){
                withAnimation{
                    groups.tasks.append(TaskItem(title: ""))
                }
            }
        }
    }
}
