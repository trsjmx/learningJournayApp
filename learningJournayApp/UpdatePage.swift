//
//  UpdatePage.swift
//  learningJournayApp
//
//  Created by Eng.Arwa on 21/04/1446 AH.
//



import SwiftUI
struct UpdatePage: View {
    @State private var learningGoal = ""
    @State private var selectedTimeframe = "Month"
    @State private var textInput = ""
    @State private var selectedOption = "Month"  // Only one @State declaration for selectedOption
    

    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20){
                
                VStack {
                    
                }
                //.padding()
                .navigationBarTitle("Learning goal", displayMode: .inline)
                .navigationBarItems(
                    leading: Button("< Back") {
                        
                        // Action for the back button
                    },
                    trailing: Button("Update") {
                        // Action for the update button
                        
                    }
                )
                .accentColor(.orange)
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    
                    
                    // ADD fake HStack to fix the spaces
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("I want to learn")
                                .foregroundColor(.white)
                                .bold()
                            
                            TextField("Swift", text: $textInput)
                            //.padding()
                                .textFieldStyle(.automatic)
                                .frame(width: 345, height: 44)
                                .accentColor(.orange)
                            
                            Divider()
                            
                            
                            
                        }
                        //.padding(.top, 15)
                        //Spacer()
                        
                        
                        
                    } // end of fake HStack#2
                    
                    
                    // ADD fake HStack to fix the spaces
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
                        
                        //Spacer()
                        
                        
                    } // end of fake HStack#2
                    
                    
                    
                    // Move OptionButton struct outside ContentView to avoid scope issues
                    
                    
                    
                    
                }
            }
            .padding(.bottom,500)
            .padding(.leading,20)
        }
        .navigationBarBackButtonHidden()
       
    }
   

        
    
}

struct page5Previews: PreviewProvider {
    static var previews: some View {
        UpdatePage()
            .preferredColorScheme(.dark)
    }
}
