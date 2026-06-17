//
//  TaskModels.swift
//  TrackerToDo
//
//  Created by David Emery on 5/12/26.
//

import Foundation

struct TaskItem: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct TaskGroup: Identifiable, Hashable, Codable {
    var id: UUID
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

struct Profile: Identifiable, Hashable, Codable {
    var id: UUID
    var name: String
    var profileImage: String
    var groups: [TaskGroup]
}

extension TaskGroup{
    static let sampleData: [TaskGroup] = [
        TaskGroup(id: UUID(),title: "School", symbolName: "book.fill", tasks: [
            TaskItem(title: "Do Homework"),
            TaskItem(title: "Exam", isCompleted: true)
        
        ]),
        TaskGroup(id: UUID(),title: "Home", symbolName: "house.fill", tasks: [
            TaskItem(title: "Buy groceries", isCompleted: true)
        ])
        ]
}


extension Profile{
    static let sample: [Profile] = [
        Profile(id: UUID(),name: "Student", profileImage: "Studentimg", groups: TaskGroup.sampleData),
        Profile(id: UUID(),name: "John Smith", profileImage: "professorimg", groups: [])
        ]
}




