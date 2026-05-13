//
//  ContentView.swift
//  TrackerToDo
//
//  Created by David Emery on 5/12/26.
//

import SwiftUI

struct ContentView: View {
    @State private var taskGroups = TaskGroup.sampleData
    @State private var selectedGroup: TaskGroup?
    @State private var columnVisilibity: NavigationSplitViewVisibility = .all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisilibity){
            List(selection: $selectedGroup) {
                ForEach(taskGroups){ group in
                    NavigationLink(value: group){
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            }
            .navigationTitle("Tracker ToDo App")
            .listStyle(.sidebar)
        } detail: {
            if let group = selectedGroup {
                if let index = taskGroups.firstIndex(where: {$0.id == group.id}){
                    TaskGroupDetailView(groups: $taskGroups[index])
                }
            }else {
                ContentUnavailableView("Select a group", image: "sidebar.left")
            }
        }
    }
}
