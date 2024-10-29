//
//  CalendarView.swift
//  learningJournayApp
//
//  Created by Eng.Arwa on 26/04/1446 AH.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    @State private var hasLearnedToday = false
    @State private var isDayFreezed = false
    @State private var streakCount = 10
    @State private var freezesUsed = 2
    @State private var totalFreezes = 6

    
    @State private var date = Date.now
    let daysOfWeek = Date.capitalizedFirstThreeLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    @State   var Todate = Date()
    
    
    var body: some View {
        
        VStack{
            
            Text(Todate, style: .date)
                .foregroundStyle(.secondary.opacity(0.99))
        }
        .padding(.trailing,260)
        HStack {
            Text("Learning Swift")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding(.trailing, 93)
                .multilineTextAlignment(.leading)
            
            
            NavigationLink(destination: UpdatePage())
            {
               ZStack {
                   Text("🔥")
                       Circle()
                       .fill(Color.gray.opacity(0.2))
                       .frame(width: 60)
                       .font(.system(size: 30))
                }
                
                
            }
            
        }
        VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.black)
                            .frame(width:390 ,height: 210)
                            .cornerRadius(13)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                        
                        VStack{
                            HStack(spacing: 180) {
                                HStack {
                                    
                                    Text(formattedDate(date))
                                        .font(.system(size: 17, weight: .semibold))
                                    
                                }
                                
                                HStack(spacing: 28) {
                                    Button(action: {
                                        // Move to the previous week
                                        date = Calendar.current.date(byAdding: .weekOfMonth, value: -1, to: date) ?? date
                                    }) {
                                        Image(systemName: "chevron.backward")
                                            .font(.system(size: 20,weight: .medium))
                                        
                                            .foregroundColor(.orange)
                                    }
                                    Button(action: {
                                        // Move to the next week
                                        date = Calendar.current.date(byAdding: .weekOfMonth, value: 1, to: date) ?? date
                                    }) {
                                        Image(systemName: "chevron.forward")
                                            .font(.system(size: 20,weight: .medium))
                                            .foregroundColor(.orange)
                                    }
                                }
                            }
                            .padding(.horizontal, 7.0)
                            .padding(.bottom, 8.0)
                            
                            HStack{
                                LazyVGrid(columns: Array(columns.prefix(7)), content: {
                                    ForEach(0..<7, id: \.self) { index in
                                        let calendar = Calendar.current
                                        let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
                                        let day = calendar.date(byAdding: .day, value: index, to: weekStart)!
                                        
                                        VStack(spacing: 16) {
                                            Text(daysOfWeek[index])
                                                .font(.system(size: 13,weight: .semibold))
                                                .foregroundColor(day == Calendar.current.startOfDay(for: Date()) ? Color.white : Color.gray.opacity(0.3))
                                            
                                            
                                            Text(day.formatted(.dateTime.day()))
                                                .foregroundColor(day == Calendar.current.startOfDay(for: Date()) ? Color.orange : Color.white)
                                            
                                        }
                                    }
                                })
                                .padding(.horizontal, 8)
                            }
                            Rectangle()
                                .fill(Color.gray.opacity(0.5)) // Change color here
                                .frame(width:370 ,height: 1) // Change thickness here
                                .padding([.top, .leading, .trailing], 10.0)
                            
                            HStack(spacing: 60){
                                VStack{
                                    HStack{
                                        Text("10🔥")
                                            .font(.system(size: 24,weight: .semibold))
                                    }
                                    
                                    Text("Day streak")
                                        .foregroundColor(Color.gray.opacity(0.4))
                                        .font(.system(size: 16))
                                }
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(width: 1, height: 70)
                                
                                VStack{
                                    HStack{
                                        
                                        Text("2🧊")
                                            .font(.system(size: 24,weight: .semibold))
                                    }
                                    
                                    Text("Day Freezed")
                                        .foregroundColor(Color.gray.opacity(0.4))
                                        .font(.system(size: 16))
                                }
                            } .padding(.top,-2)
                        }
                        }//close
                    
                    //.padding(.top)
                   
                    
                    .onAppear() {
                        days = date.calendarDisplayDays
                    }
                    .onChange(of: date) {
                        days = date.calendarDisplayDays
                        
                        
                    }
            
                }
                .navigationBarBackButtonHidden(true)
        
        // Action Buttons
        VStack(alignment: .center, spacing: 30) {
            if hasLearnedToday {
                Text("Learned Today")
                    .font(.title)
                    .frame(width: 300, height: 300)
                    .background(Color.brown.opacity(1))
                    .foregroundColor(.orange)
                    .clipShape(Circle())
                    .padding()
            } else if isDayFreezed {
                Text("Day Freezed")
                    .font(.title)
                    .frame(width: 300, height: 300)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding()
            } else {
                Button(action: {
                    hasLearnedToday = true
                }) {
                    Text("Log today as Learned")
                        .font(.title)
                        .frame(width: 300, height: 300)
                        .background(Color.orange)
                        .foregroundColor(.black)
                        .bold()
                        .clipShape(Circle())
                        .padding()
                }
                
                Button(action: {
                    isDayFreezed = true
                }) {
                    Text("Freeze day")
                        .font(.title)
                        .frame(width: 200, height: 50)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }
                
                Text("\(freezesUsed) out of \(totalFreezes) freezes used")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        Spacer()
    }

    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy" // Display month and year
        return formatter.string(from: date)
    }
   

    private func daysOfMonth(for date: Date) -> [Date] {
            let calendar = Calendar.current
            let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
            let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
            return range.compactMap { day -> Date? in
                calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
            }
        }
    

    private func getFormattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMM" // Format: Day of week, day, month
        return formatter.string(from: date)
    }
    
    

#Preview {
    CalendarView()
        .preferredColorScheme(.dark)
}
