//
//  ContentView.swift
//  ToDo
//
//  Created by Nar Rasaily on 1/24/26.
//

import SwiftUI

struct ContentView: View {
    @State private var taskGroups: [TaskGroup] = []
    @State private var selectedGroup: TaskGroup?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    @State private var isShowingAddGroup = false
    @Environment(\.scenePhase) private var scenePhase
    let saveKey = "SavedTaskGroups"
    @Binding var profile: Profile
    // MARK: - Adding the functionallity of dark mode
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("isDarkModeOn") private var isDarkModeOn: Bool = false
    
    var body: some View {
        
        NavigationSplitView(columnVisibility: $columnVisibility) {
            
            List(selection: $selectedGroup) {
                ForEach(profile.groups) { group in
                    
                    
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                        
                    }
                    .accessibilityIdentifier("taskGroup_\(group.title)") // here
                }
            }
            
            .navigationTitle("ToDo App iPAD")
            .listStyle(.sidebar)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isDarkModeOn.toggle()
                    } label: {
                        Image(systemName: isDarkModeOn ? "sun.max.fill" : "moon.fill")
                    }
                    .accessibilityIdentifier("Dark_Mode_Button")  // here
                }
                ToolbarItem {
                    Button {
                        isShowingAddGroup = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityIdentifier("Show_Add_Group_Button")   // here
                    
                }
            }
            
        } detail: {
            if let group = selectedGroup {
                if let index = profile.groups.firstIndex(where: { $0.id == group.id }) {
                    TaskGroupDetailView(group: $profile.groups[index])
                }
            } else {
                ContentUnavailableView("Select a group to see more details.", systemImage: "sidebar.left")
            }
        }
        .onAppear(perform: loadData)
        .onChange(of: scenePhase) {
            oldValue, newValue in
            if newValue == .active {
                print("App us running active")
            } else if newValue == .background {
                print("App is in background mode - saving data!")
                saveData()
            }
        }
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                profile.groups.append(newGroup)
                
            }
        }
    }
    func saveData() {
        if let encodedData = try? JSONEncoder().encode(profile.groups) {
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
        //        let encoder = JSONEncoder()
        //        if let encoded = try? encoder.encode(taskGroups) {
        //            UserDefaults.standard.set(encoded, forKey: saveKey)
        //        }
    }
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
          if let decodedgroups = try? JSONDecoder ().decode([TaskGroup].self, from: savedData) {
                profile.groups = decodedgroups
              return
            }
        }
    
        taskGroups = TaskGroup.sampleData
    }
}


