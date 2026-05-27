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
    @Environment(\.dismiss) var dismiss
    @Binding var profile: Profile
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisilibity){
            List(selection: $selectedGroup) {
                ForEach(profile.groups){ group in
                    NavigationLink(value: group){
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            }
            .navigationTitle(profile.name)
            .listStyle(.sidebar)
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        dismiss()
                    }label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                            .padding(8)
                            .foregroundStyle(.primary)
                            .background(Circle().fill(Color.primary.opacity(0.1)))
                    }
                }
                ToolbarItem(placement: .primaryAction){
                    Button {
                        isShowingAddGroup = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        } detail: {
            if let group = selectedGroup {
                if let index = profile.groups.firstIndex(where: {$0.id == group.id}){
                    TaskGroupDetailView(groups: $profile.groups[index])
                }
            }else {
                ContentUnavailableView("Select a group", image: "sidebar.left")
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                profile.groups.append(newGroup)
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
        if let encodedData = try? JSONEncoder().encode(profile.groups){
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }
    
    func loadData(){
        if let savedData = UserDefaults.standard.data(forKey: saveKey){
            
            if let decodedGroups = try? JSONDecoder().decode([TaskGroup].self, from: savedData){
                profile.groups = decodedGroups
                return
            }
        }
        if profile.groups.isEmpty{
            profile.groups = TaskGroup.sampleData
        }
    }
}

