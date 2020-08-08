//
//  UserData.swift
//  ToDo-SwiftUI
//
//  Created by Saumil Shah on 8/8/20.
//

import Combine
import Foundation

final class UserData: ObservableObject {
    
    let willChange = PassthroughSubject<Void, Never>()
    
    // MARK: user items
    @Published var currentUserList: [ToDoList] = [ToDoList]() {
        willSet {
            willChange.send()
        }
    }
    
    
    // MARK: todo items
    @Published var someTasks:[ToDoTask] = sampleTasks {
        willSet {
            willChange.send()
        }
    }
    
    @Published var someTasksLite:[ToDoTask] = sampleTasksLite {
        willSet {
            willChange.send()
        }
    }
    
    @Published var someRandomTasks:[ToDoTask] = randomTasks {
        willSet {
            willChange.send()
        }
    }
    
    
    //MARK: todo lists
    @Published var someListLite:ToDoList = toDoListLite {
        willSet {
            willChange.send()
        }
    }
    
    @Published var someListLite2:ToDoList = toDoListLite2 {
        willSet {
            willChange.send()
        }
    }
    
    @Published var someLists:[ToDoList] = sampleLists {
        willSet {
            willChange.send()
        }
    }
    
    @Published var someRandomLists:[ToDoList] = randomLists {
        willSet {
            willChange.send()
        }
    }
    
}
