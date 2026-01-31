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
    // MARK: - Adding the functionallity of dark mode
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("isDarkModeOn") private var isDarkModeOn: Bool = false
    
    var body: some View {
        
        NavigationSplitView(columnVisibility: $columnVisibility) {
            
            List(selection: $selectedGroup) {
                ForEach(taskGroups) { group in
                    
                    
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
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
                }
                ToolbarItem {
                    Button {
                        isShowingAddGroup = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
            }
            
        } detail: {
            if let group = selectedGroup {
                if let index = taskGroups.firstIndex(where: { $0.id == group.id }) {
                    TaskGroupDetailView(group: $taskGroups[index])
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
                taskGroups.append(newGroup)
                selectedGroup = newGroup
            }
        }
    }
    func saveData() {
        if let encodedData = try? JSONEncoder().encode(taskGroups) {
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
        //        let encoder = JSONEncoder()
        //        if let encoded = try? encoder.encode(taskGroups) {
        //            UserDefaults.standard.set(encoded, forKey: saveKey)
        //        }
    }
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            //            let decoder = JSONDecoder()
            //            if let loadedTaskGroups = try? decoder.decode([TaskGroup].self, from: savedData) {
            //                taskGroups = loadedTaskGroups
            if let decodeGroups = try? JSONDecoder().decode([TaskGroup].self, from: savedData) {
                taskGroups = decodeGroups
                return print("Data loaded successfully")
            }
        }
        taskGroups = TaskGroup.sampleData
    }
}


