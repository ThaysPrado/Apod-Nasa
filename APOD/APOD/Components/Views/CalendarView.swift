//
//  CalendarView.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    @Binding var isPresented: Bool
    
    private let minDate: Date
    private let maxDate: Date
    
    init(selectedDate: Binding<Date>, isPresented: Binding<Bool>) {
        self._selectedDate = selectedDate
        self._isPresented = isPresented
        self.minDate = Calendar.current.date(from: DateComponents(year: 1995, month: 06, day: 16)) ?? Date()
        self.maxDate = Date()
    }
    
    var body: some View {
        VStack {
            Text(String(localized: "ChooseDateTitle"))
                .font(.helvetica(with: .regular, forTextStyle: .callout))
            
            DatePicker(
                "",
                selection: $selectedDate,
                in: minDate...maxDate,
                displayedComponents: .date
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
            .onChange(of: selectedDate) { date in
                selectedDate = date
                isPresented = false
            }
        }
        .padding()
    }
}

#Preview {
    CalendarView(selectedDate: .constant(Date()), isPresented: .constant(true))
}
