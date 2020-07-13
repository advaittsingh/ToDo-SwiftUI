//
//  ListDetailView.swift
//  ToDo-SwiftUI
//
//  Created by Saumil Shah on 6/24/20.
//  Copyright © 2020 Saumil Shah. All rights reserved.
//

import SwiftUI

struct ListDetailView: View {
    
    @Binding var task: ToDoTask
    @Binding var showModal: Bool
    
    @ObservedObject private var keyboard = KeyboardResponder()
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Text(self.task.todoName)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(self.task.todoColor.color)
                
                Spacer()
                
                getSystemImage(name: "xmark.circle.fill",
                               color: self.task.todoColor.color,
                               font: .headline, scale: .medium)
                    .onTapGesture { self.showModal.toggle() }
                
            }
            .padding(.horizontal)
            .padding(.top, 4)
            .padding(.bottom, -10)
            
            Form {
                
                Section(header: headerItemGroup(imageName: "text.cursor", text: "Basic Info")) {
                    
                    VStack(alignment: .center) {
                        
                        HStack {
                            
                            Text("Name")
                            
                            Spacer()
                            
                            commonUserInput(keyboard: .numbersAndPunctuation,
                                            placeholder: "Type a new task name...",
                                            textfield: self.$task.todoName, lineLimit: 2,
                                            fontDesign: .rounded,
                                            fontSize: .body,
                                            scale: 0.88)
                                
                                .textFieldStyle(PlainTextFieldStyle())
                                .foregroundColor(Color.primary.opacity(0.50))
                        }
                        .padding(.vertical)
                    }
                }
                
                Section(header: headerItemGroup(imageName: "paintbrush.fill", text: "Customize")) {
                    
                    VStack(alignment: .center) {
                        
                        Picker(selection: self.$task.todoColor, label: Text("Color")) {
                            ForEach(BaseColors.allCases, id: \.id) { colorName in
                                
                                Text(colorName.id).tag(colorName)
                                    .foregroundColor(.blue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.vertical, 4)
                        
                        
                        Picker(selection: self.$task.todoShape, label: EmptyView()) {
                            
                            ForEach(BaseShapes.allCases, id: \.id) { shapeName in
                                
                                shapeName.filled.tag(shapeName)
                                    .rotationEffect(Angle(degrees: -90.0))
                                    .foregroundColor( self.task.todoColor.color )
                                    .imageScale(.medium)
                                
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 32, alignment: .center)
                        .rotationEffect(Angle(degrees: 90.0))
                        .scaledToFit()
                        .clipped()
                        .padding(.vertical, 4)
                    }
                }
                
                Section(header: headerItemGroup(imageName: "calendar", text: "Reminde me on the")) {
                    
                    DatePicker(selection: self.$task.dueDateTime,
                               in: Date()...,
                               displayedComponents: [.hourAndMinute, .date] ,
                               label: {Text("Date & Time")} )
                    
                }
                
                Section(header: headerItemGroup(imageName: "text.badge.star", text: "More details")) {
                    
                    VStack (alignment: .leading, spacing: 10) {
                        
                        Text("Notes").bold()
                        
                        commonUserInput(keyboard: .default,
                                        placeholder: "Note so you don't forget...",
                                        textfield: self.$task.notes, lineLimit: 10,
                                        fontDesign: .rounded,
                                        fontSize: .body,
                                        scale: 0.88)
                            
                            .padding()
                            .textFieldStyle(PlainTextFieldStyle())
                            .foregroundColor(Color.primary.opacity(0.75))
                            
                            .background(Color.primary.opacity(0.05))
                            .cornerRadius(10)
                        
                    }
                    .padding(.vertical)
                    
                    HStack {
                        
                        getSystemImage(name: self.task.isMyFavorite ? "star.fill" : "star",
                                       color: .yellow, font: .body)
                        
                        Text("Add to Favorites")
                    }
                    .onTapGesture { self.task.isMyFavorite.toggle() }
                    
                }
            }
            .padding(.bottom, keyboard.currentHeight)
            .edgesIgnoringSafeArea(.bottom)
        }
        .background(Color.primary.colorInvert())
        
    }
    
    func endEditing(_ force: Bool) {
        UIApplication.shared.endEditing()
    }
    
}

struct ListDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        
        ForEach(sampleTasksLite, id: \.todoID) { task in
            
            Group {
                
                NightAndDay {
                    ListDetailView(task: .constant(task),
                                   showModal: .constant(true))
                }
            }
        }
    }
}


final class KeyboardResponder: ObservableObject {
    private var notificationCenter: NotificationCenter
    @Published private(set) var currentHeight: CGFloat = 0
    
    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            currentHeight = keyboardSize.height
        }
    }
    
    @objc func keyBoardWillHide(notification: Notification) {
        currentHeight = 0
    }
}
