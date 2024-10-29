import SwiftUI

struct LearningProgressView: View {
    @State private var selectedDate = Date()
    @State private var hasLearnedToday = false
    @State private var isDayFreezed = false
    @State private var streakCount = 10
    @State private var freezesUsed = 2
    @State private var totalFreezes = 6
    @State private var currentWeek: [Date] = []
    @State private var showDatePicker = false
    
    init() {
        _currentWeek = State(initialValue: getCurrentWeek())
    }
    
    var body: some View {
        VStack() {
            // Header section remains the same
            VStack(alignment: .leading, spacing: 16) {
                Text(Date.now, format: .dateTime.day().month().year())
                    .foregroundColor(.gray)
                    .padding(.top, 100)
                    .padding(.leading, 10)
                
                Text("Learning Swift")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.leading, 10)
            }
            .padding(.trailing, 142.0)
            
            // Week View Calendar
            VStack(alignment: .leading, spacing: 16) {
                // Month and navigation
                HStack {
                    // Month/Year with selection arrow
                    Button(action: { showDatePicker.toggle() }) {
                        HStack(spacing: 4) {
                            Text(currentWeek.first ?? Date(), format: .dateTime.month().year())
                                .foregroundColor(.white)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.orange)
                        }
                    }
                    .sheet(isPresented: $showDatePicker) {
                        DatePicker("Select Date",
                                 selection: $selectedDate,
                                 displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                            .onChange(of: selectedDate) { _ in
                                currentWeek = getCurrentWeekDates(for: selectedDate)
                                showDatePicker = false
                            }
                            .presentationDetents([.height(400)])
                    }
                    
                    Spacer()
                    
                    // Week navigation remains the same
                    HStack(spacing: 16) {
                        Button(action: { moveWeek(by: -1) }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.orange)
                        }
                        Button(action: { moveWeek(by: 1) }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.orange)
                        }
                    }
                }
                
                // Rest of the view remains exactly the same
                HStack(spacing: 0) {
                    ForEach(["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"], id: \.self) { day in
                        Text(day)
                            .fontWeight(.semibold)
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal)
                
                // Calendar Days
                HStack(spacing: 0) {
                    ForEach(currentWeek, id: \.self) { date in
                        let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
                        let isToday = Calendar.current.isDateInToday(date)
                        let dayNumber = Calendar.current.component(.day, from: date)
                        
                        Button(action: {
                            selectedDate = date
                        }) {
                            Text("\(dayNumber)")
                                .frame(width: 35, height: 35)
                               // .background(
                                // Circle()
                                        //.fill(backgroundColor(for: date))
                              //  )
                                .foregroundColor(isSelected || isToday ? .orange : .gray)
                                .fontWeight(.regular)
                                .font(.system(size: 20))
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal)
                Divider()
                
                
                // Streak and Freeze Count
                HStack {
                    VStack {
                        HStack(spacing: 4) {
                            Text("\(streakCount)")
                                .bold()
                            Text("🔥")
                        }
                      
                        Text("Day streak")
                            .foregroundColor(.gray)
                    }
                   
                    Spacer()
                    Divider().frame(width: 3)
                        .padding()
                        .frame(width: 200, height: 75)
                    
                    
                   
                    VStack {
                        HStack(spacing: 4) {
                            Text("\(freezesUsed)")
                                .bold()
                            Text("🧊")
                        }
                        Text("Day freezed")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
            }// end of calander view
            
            .background(Color.black.opacity(0.3))
            //.border(.gray, width: 1)
            .cornerRadius(13)
            .padding()
            
            // Rest of the view remains exactly the same...
            Spacer()
            
            // Action Buttons
            VStack(alignment: .center, spacing: 30) {
                if hasLearnedToday {
                    Text("Learned Today")
                        .font(.title)
                        .frame(width: 300, height: 300)
                        .background(Color.orange)
                        .foregroundColor(.white)
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
                            .foregroundColor(.white)
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
    
    // Helper methods remain the same
    private func getCurrentWeek() -> [Date] {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - 1), to: today)!
        return (0...6).map { day in
            calendar.date(byAdding: .day, value: day, to: startOfWeek)!
        }
    }
    
    private func moveWeek(by value: Int) {
        if let newDate = Calendar.current.date(byAdding: .day, value: value * 7, to: currentWeek[0]) {
            currentWeek = getCurrentWeekDates(for: newDate)
        }
    }
    
    private func getCurrentWeekDates(for date: Date) -> [Date] {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - 1), to: date)!
        return (0...6).map { day in
            calendar.date(byAdding: .day, value: day, to: startOfWeek)!
        }
    }
    
    private func backgroundColor(for date: Date) -> Color {
        if Calendar.current.isDateInToday(date) {
            return .orange
        } else if isDayFreezed && Calendar.current.isDate(date, inSameDayAs: selectedDate) {
            return .blue
        } else if hasLearnedToday && Calendar.current.isDate(date, inSameDayAs: selectedDate) {
            return .orange
        }
        return .clear
    }
}

#Preview {
    LearningProgressView()
        .preferredColorScheme(.dark)
}
