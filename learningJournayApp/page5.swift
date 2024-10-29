//
//  page5.swift
//  learningJournayApp
//
//  Created by Eng.Arwa on 26/04/1446 AH.
//

import SwiftUI

struct page5: View {
    @State private var learningGoal = ""
    @State private var selectedTimeframe = "Month"
    
    let timeframes = ["Week", "Month", "Year"]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("I want to learn")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                TextField("", text: $learningGoal)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                
                Text("I want to learn it in a")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                HStack {
                    ForEach(timeframes, id: \.self) { timeframe in
                        Button(action: {
                            selectedTimeframe = timeframe
                        }) {
                            Text(timeframe)
                                .padding()
                                .background(selectedTimeframe == timeframe ? Color.orange.opacity(1.5) : Color.black)
                                .foregroundColor(selectedTimeframe == timeframe ? .white : .orange)
                                .cornerRadius(10)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Learning goal", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Back") {
                    // Action for the back button
                },
                trailing: Button("Update") {
                    // Action for the update button
                }
            )
        }
        .accentColor(.orange)
    }
}
#Preview {
    page5()
        .preferredColorScheme(.dark)
}


