//
//  ContentView.swift
//  learningJournayApp
//
//  Created by Eng.Arwa on 17/04/1446 AH.
//

// ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var textInput = ""
    @State private var selectedOption = "Month"  // Only one @State declaration for selectedOption

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                Text("🔥")
                    .font(.system(size: 52))
                    .background(Circle().fill(Color.gray.opacity(0.3)).frame(width: 118, height: 118))
                    .padding(.bottom,50)
                
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Hello, Learner!")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                        
                        Text("This app will help you learn every day")
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                
                // Learning Input
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("I want to learn")
                            .foregroundColor(.white)
                            .bold()
                        
                        TextField("Swift", text: $textInput)
                            .padding()
                            .textFieldStyle(.automatic)
                            .frame(width: 345, height: 44)
                            .accentColor(.orange)
                        
                        Divider()
                    }
                    .padding(.top, 15)
                    Spacer()
                }
                
                // Learning Duration Option
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("I want to learn it in")
                            .foregroundColor(.white)
                            .bold()
                            .padding(.bottom,10)
                        
                        HStack(spacing: 20) {
                            OptionButton(title: "Week", selectedOption: $selectedOption)
                            OptionButton(title: "Month", selectedOption: $selectedOption)
                            OptionButton(title: "Year", selectedOption: $selectedOption)
                        }
                    }
                    Spacer()
                }
                
                // Start Button with Navigation
                VStack {
                    NavigationLink(destination: CalendarView()) {
                        Text("Start →")
                            .frame(width: 151, height: 51)
                            .foregroundColor(.black)
                            .background(Color.orange)
                            .cornerRadius(8)
                    }
                }
                .padding(.top, 50)
            }
            .padding()
        }
    }
}

struct OptionButton: View {
    let title: String
    @Binding var selectedOption: String

    var body: some View {
        Button(action: {
            selectedOption = title
        }) {
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(selectedOption == title ? Color.black : Color.orange)
                .frame(width: 68, height: 37)
                .background(selectedOption == title ? Color.orange : Color.gray.opacity(0.3))
                .cornerRadius(8)
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
