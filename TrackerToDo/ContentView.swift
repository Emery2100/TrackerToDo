//
//  ContentView.swift
//  TrackerToDo
//
//  Created by David Emery on 5/12/26.
//

import SwiftUI

struct ContentView: View {
    @State private var taskGroups : [TaskGroup] = []
    @State private var selectedGroup: TaskGroup?
    @State private var columnVisilibity: NavigationSplitViewVisibility = .all
    @State private var isShowingAddGroup = false
    @Environment(\.scenePhase) private var scenePhase
    let saveKey = "SavedTaskGroups"
    
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
            
            .toolbar {
                Button {
                    isShowingAddGroup = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        } detail: {
            if let group = selectedGroup {
                if let index = taskGroups.firstIndex(where: {$0.id == group.id}){
                    TaskGroupDetailView(groups: $taskGroups[index])
                }
            }else {
                ContentUnavailableView("Select a group", image: "sidebar.left")
            }
        }
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                taskGroups.append(newGroup)
                selectedGroup = newGroup
            }
        }
        
        .onAppear(){
            loadData()
        }
        .onChange(of: scenePhase){ oldValue, newValue in
            if newValue == .active{
                print("APP IS ACTIVE")
            } else if newValue == .inactive {
                print("Look out user is going out (INACTIVE)")
            }else if newValue == .background{
                saveData()
            }
        }
    }
    
    func saveData(){
        if let encodedData = try? JSONEncoder().encode(taskGroups){
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }
    
    func loadData(){
        if let savedData = UserDefaults.standard.data(forKey: saveKey){
            
            if let decodedGroups = try? JSONDecoder().decode([TaskGroup].self, from: savedData){
                taskGroups = decodedGroups
                return
            }
        }
        taskGroups = TaskGroup.sampleData
    }
}

