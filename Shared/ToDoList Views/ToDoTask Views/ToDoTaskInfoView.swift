//
//  ToDoTaskInfoView.swift
//  ToDo-SwiftUI
//
//  Created by Saumil Shah on 8/8/20.
//

import SwiftUI

struct ToDoTaskInfoView: View {
    
    @ObservedObject var task: ToDoTask
    @Binding var showModal: Bool
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Text(task.todoName)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundOverlay(
                        myGradient(type: task.todoGradientScheme,
                                   colors: [task.todoGradientStartColor.color,
                                            task.todoGradientEndColor.color]))
                
                Spacer()
                
                getSystemImage(name: "xmark.circle.fill",
                               weight: .medium, scale: .medium)
                    .padding(.trailing, -16)
                    .foregroundOverlay(
                        myGradient(type: task.todoGradientScheme,
                                   colors: [task.todoGradientStartColor.color,
                                            task.todoGradientEndColor.color]))
                    .onTapGesture { showModal.toggle() }
                
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
                            
                            TextField("Name here...", text: $task.todoName)
                                .foregroundColor(Color.primary.opacity(0.50))
                                .lineSpacing(2)
                                .offset(x: 0, y: 1)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                        }
                        .padding(.vertical)
                    }
                }
                
                Section(header: headerItemGroup(imageName: "square.on.circle.fill", text: "Choose Shape")) {
                    
                    VStack(alignment: .center) {
                        
                        
                        Picker(selection: $task.todoShape, label: EmptyView()) {
                            
                            ForEach(BaseShapes.allCases, id: \.id) { shapeName in
                                
                                getSystemImage(name: shapeName.rawValue+".fill", fontSize: 22,
                                               scale: .medium)
                                    .tag(shapeName)
                                    .rotationEffect(Angle(degrees: -90.0))
                                    
                                    .foregroundOverlay(
                                        myGradient(type: task.todoGradientScheme,
                                                   colors: [task.todoGradientStartColor.color,
                                                            task.todoGradientEndColor.color]))
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 40, alignment: .center)
                        .rotationEffect(Angle(degrees: 90.0))
                        .scaledToFit()
                        .clipped()
                        .padding(.vertical, 4)
                        
                        Divider()
                        
                        myGradient(type: task.todoGradientScheme,
                                   colors: [task.todoGradientStartColor.color,
                                            task.todoGradientEndColor.color])
                            .cornerRadius(8)
                            .frame(height: 24)
                            .padding(.bottom, 4)
                        
                    }
                }
                
                Section(header: headerItemGroup(imageName: "dial.fill", text: "Change Look & Feel")) {
                    
                    VStack(alignment: .center) {
                        
                        Picker(selection: $task.todoGradientScheme, label: Text("Color")) {
                            ForEach(GradientTypes.allCases, id: \.id) { gcolorName in
                                
                                Text(gcolorName.id).tag(gcolorName)
                                    .foregroundColor(.blue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.vertical, 4)
                        
                        Divider()
                        
                        GradientColorRoll(text: "Start Color",
                                          selectedColor: $task.todoGradientStartColor)
                        
                        Divider()
                        
                        GradientColorRoll(text: "End Color",
                                          selectedColor: $task.todoGradientEndColor)
                        
                    }
                }
                
                Section(header: headerItemGroup(imageName: "calendar", text: "Reminde me on the")) {
                    
                    DatePicker(selection: $task.dueDateTime,
                               in: Date()...,
                               displayedComponents: [.hourAndMinute, .date] ,
                               label: {Text("Date & Time")} )
                    
                }
                
                
                Section(header: headerItemGroup(imageName: "text.badge.star", text: "More details")) {
                    
                    VStack (alignment: .center) {
                        
                        VStack (alignment: .leading, spacing: 10) {
                            
                            Text("Notes").bold()
                            
                            commonUserInput(keyboard: .default,
                                            placeholder: "Note so you don't forget...",
                                            textfield: $task.notes, lineLimit: 10,
                                            fontDesign: .rounded,
                                            fontSize: .body,
                                            scale: 0.83)
                                
                                .padding()
                                .textFieldStyle(PlainTextFieldStyle())
                                .foregroundColor(Color.primary.opacity(0.75))
                                
                                .background(Color.primary.opacity(0.05))
                                .cornerRadius(10)
                            
                        }
                        .padding(.vertical)
                        
                        Divider()
                        
                        
                        HStack {
                            
                            getSystemImage(name: task.isMyFavorite ?
                                            "star.fill" : "star",
                                           color: .yellow)
                            
                            Text("Add to Favorites")
                            
                            Spacer()
                        }
                        .padding(-12)
                        .onTapGesture { task.isMyFavorite.toggle() }
                        
                    }
                    
                }
                
            }
//            .padding(.bottom, keyboard.currentHeight)
//            .edgesIgnoringSafeArea(.bottom)
        }
        
    }
    
//    func endEditing(_ force: Bool) {
//        UIApplication.shared.endEditing()
//    }
}

struct ToDoTaskInfoView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ForEach(sampleTasksLite, id: \.id) { task in
            
            Group {
                
                NightAndDay {
                    ToDoTaskInfoView(task: task,
                                   showModal: .constant(true))
                }
            }
        }
    }
}
