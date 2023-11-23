//
//  DropDownPickerView.swift
//  DropDownPicker
//
//  Created by Alexis Schotte on 22/11/2023.
//

import SwiftUI

struct DropDownPickerView: View {
    
    var hint: String
    var options: [String]
    var anchor: Anchor = .bottom
    var maxWidth: CGFloat = 180
    var cornerRadius: CGFloat = 15
    @Binding var selection: String?
    @Environment(\.colorScheme) private var scheme
    @State private var showOptions: Bool = false
    @SceneStorage("drop_down_zindez") var index: Double = 1000
    @State private var zIndex: Double = 1000
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 0) {
                
                if showOptions && anchor == .top {
                    optionsView
                }
                
                HStack(spacing: 0) {
                    Text(selection ?? hint)
                        .foregroundStyle(selection == nil ? .gray : .primary)
                        .lineLimit(1)
                    Spacer(minLength: 0)
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.gray)
                        .font(.title3)
                        .rotationEffect(showOptions ? Angle(degrees: 180) : Angle(degrees: 0))
                }
                .padding(.horizontal, 15)
                .frame(width: size.width, height: size.height)
                .background(scheme == .dark ? .black : .white)
                .contentShape(.rect)
                .onTapGesture {
                    index += 1
                    zIndex = index
                    withAnimation(.snappy) {
                        showOptions.toggle()
                    }
                }
                .zIndex(10)
                
                if showOptions && anchor == .bottom {
                    optionsView
                }
            }
            .clipped()
            .contentShape(.rect)
            .background((scheme == .dark ? Color.black : Color.white).shadow(.drop(color: .primary.opacity(0.15), radius: 4)), in: .rect(cornerRadius: cornerRadius))
            .frame(width: size.width, height: size.height, alignment: anchor == .bottom ? .top : .bottom )
        }
        .frame(width: maxWidth, height: 50)
        .zIndex(zIndex)
    }
    
    private var optionsView: some View {
        VStack(spacing: 10) {
            ForEach(options, id: \.self) { option in
                HStack(spacing: 0) {
                    Text(option)
                        .lineLimit(1)

                    Spacer(minLength: 0)
                    
                    Image(systemName: "checkmark")
                        .font(.caption)
                        .opacity(selection == option ? 1 : 0)
                }
                .foregroundStyle(selection == option ? Color.primary : .gray)
                .animation(.none, value: selection)
                .frame(height: 40)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selection = option
                        showOptions = false
                    }
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .transition(.move(edge: anchor == .top ? .bottom : .top))
    }
}

#Preview {
    ContentView()
}

enum Anchor {
    case top, bottom
}
