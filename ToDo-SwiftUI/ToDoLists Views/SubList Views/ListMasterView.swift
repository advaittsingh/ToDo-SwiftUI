//
//  ListMasterView.swift
//  ToDo-SwiftUI
//
//  Created by Saumil Shah on 7/1/20.
//  Copyright © 2020 Saumil Shah. All rights reserved.
//

import SwiftUI

struct ListMasterView: View {
    
    @ObservedObject var toDoList: ToDoList
    
    @State private var tappedTask: ToDoTask = ToDoTask(name: "none")
    
    @State private var showingModal: Bool = false
    @State private var showingDelete: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack {
                
                if self.toDoList.todoTasks.isEmpty {
                    
                    Spacer()
                    
                    Text("No Tasks Found")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                } else {
                    
                    ScrollView {
                        
                        Divider()
                        
                        ForEach(self.toDoList.todoTasks, id: \.self) { tasks in
                            
                            // MARK: Call ListCellView
                            ListCellView(task: tasks)
                        }
                        .onDelete { (IndexSet) in
                            self.toDoList.todoTasks.remove(atOffsets: IndexSet)
                        }
                    }
                }
            }
            
            FloatingActionButton(systemImageName: "plus", fontSize: 20,
                                 action: {
                                    withAnimation(.easeInOut) {
                                        self.toDoList.todoTasks.append(ToDoTask())
                                        self.showingModal = true
                                    }
            })
                .position(x: UIScreen.main.bounds.midX * 1.70,
                          y: UIScreen.main.bounds.maxY * 0.77)
            
        }
        .navigationBarTitle(Text(self.toDoList.todoListName),
                            displayMode: .automatic)
            
            .sheet(isPresented: self.$showingModal, onDismiss: {self.showingModal = false}) {
                
                // MARK: Call ListDetailView
                ListDetailView(task: self.toDoList.todoTasks[self.toDoList.todoTasks.underestimatedCount-1],
                               showModal: self.$showingModal)
        }
    }
}

struct ListMasterView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            
            ForEach( [toDoListLite, toDoListLite2, toDoListRandom], id: \.id ) { list in
                
                NightAndDay {
                    
                    ListMasterView(toDoList: list)
                }
            }
        }
    }
}
