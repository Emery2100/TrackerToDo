//
//  NewGroupView.swift
//  TrackerToDo
//
//  Created by David Emery on 5/16/26.
//

import SwiftUI


struct NewGroupView: View {
    @Environment(\.dismiss) var dismiss
    @State private var groupName = ""
    @State private var selectedIcon = "list.bullet"
    var onSave: (TaskGroup) -> ()
    let icons = ["list.bullet, person.fill, book.fill, flag.fill, person.2.fill, house.fill, pencil.and.outline"]
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Group Name"){
                    TextField("e.g. Work, School...", text: $groupName)
                }
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum:40))]){
                    ForEach(icons, id: \.self) { icon in
                        Image(systemName:icon)
                            .font(.title2)
                            .frame(width: 40, height: 40)
                            .background(selectedIcon == icon ? Color.blue.opacity(0.2) : Color.gray)
                            .foregroundStyle(selectedIcon == icon ? Color.blue : Color.gray)
                            .clipShape(Circle())
                            .onTapGesture {selectedIcon = icon}
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("New Group")
        .toolbar{
            ToolbarItem(placement: .cancellationAction){
                Button("Cancel"){ dismiss() }
            }
            
            ToolbarItem(placement: .confirmationAction){
                Button("Save"){
                    let newGroup = TaskGroup(id: UUID(),title: groupName, symbolName: selectedIcon, tasks:[])
                    onSave(newGroup)
                    dismiss()
                }
                .disabled(groupName.isEmpty)
            }
        }
    }
}
