//
//  ContentView.swift
//  DropDownPicker
//
//  Created by Alexis Schotte on 22/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State var selection: String?
    @State var selection1: String?
    @State var selection2: String?

    var body: some View {
        NavigationStack {
            VStack {
                Button("Testing") {
                    //
                }
                
                DropDownPickerView(
                    hint: "Selection",
                    options: [
                        "YouTube",
                        "Instagram",
                        "TikTok",
                        "Netflix",
                        "Amazon Prime"
                    ],
                    anchor: .bottom,
                    selection: $selection)
                
                DropDownPickerView(
                    hint: "Selection",
                    options: [
                        "Short Form",
                        "Long Form",
                        "Both"
                    ],
                    anchor: .top,
                    selection: $selection1)
                
                Button("Testing") {
                    //
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
