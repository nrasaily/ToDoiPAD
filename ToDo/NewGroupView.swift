//
//  NewGroupView.swift
//  ToDo
//
//  Created by Nar Rasaily on 1/26/26.
//
import SwiftUI

struct NewGroupView: View {
    @Environment(\.dismiss) var dismiss
    @State var groupName: String = ""
    @State private var selectedIcon = "list.bullet"
    
    let icons = ["list.bullet", "bookmark.fill", "graduationcap.fill", "cart.fill", "house.fill", "star.fill"]
    
    var onSave: (TaskGroup) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Group Name") {
                    TextField("Type in the name of your group", text: $groupName)
                }
                Section("Select Icon") {
                    LazyVGrid(columns:[ GridItem(.adaptive(minimum: 40))]) {
                        ForEach(icons, id: \.self) { icon in
                            Image(systemName: icon)
                                .font(.title2)
                                .frame(width: 40, height: 40)
                            // UI for the selected icon
                                .background(selectedIcon == icon ? Color.cyan : Color.clear)
                                .foregroundStyle(selectedIcon == icon ? Color.blue : Color.gray)
                                .clipShape(Circle())
                                
                            // add the functionality when the taps it
                                .onTapGesture {
                                    selectedIcon = icon
                                }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("New Group")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        let newGroup = TaskGroup(title: groupName, symbolName: selectedIcon, tasks: [])
                        onSave(newGroup)
                        dismiss()
                    }
                    .disabled(groupName.isEmpty)
                }
            }
        }
    }
}
