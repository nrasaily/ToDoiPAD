//
//  DarkModeView.swift
//  ToDo
//
//  Created by Nar Rasaily on 1/31/26.
//
import SwiftUI

struct DarkModeView: View {
    var body: some View {
        Toggle("Dark Mode", isOn: .constant(false))
    }
}
