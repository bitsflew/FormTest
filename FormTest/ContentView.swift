//
//  ContentView.swift
//  FormTest
//
//  Created by Henk on 16/09/2025.
//

import Foundation
import SwiftUI

let date = Date()

struct Customer: Identifiable {
    let id: Int?
    var name: String?
    var city: String?
}

extension Date {
    var formattedDateOnly: String {
        self.formatted(
            Date.VerbatimFormatStyle(
                format: "\(month: .twoDigits)-\(year: .defaultDigits)",
                locale: Locale(identifier: "en_US"),
                timeZone: TimeZone(secondsFromGMT: 0)!,
                calendar: Calendar(identifier: .gregorian)
            )
        )
    }
}

func validateDateOnly(_ value: String?) -> Date? {
    guard let value else { return nil }
    let pattern = /^(\d{1,2})(\d{4})$/

    if let match = value.firstMatch(of: pattern) {
        let month = Int(match.1)
        let year = Int(match.2)
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1 // Default to the 1st day of the month
            
        // Set the timezone to Europe/West (e.g., Lisbon)
        let timeZone = TimeZone(identifier: "Europe/Lisbon") ?? .gmt
        components.timeZone = timeZone
            
        // Use Gregorian calendar
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.date(from: components)
        return date
    } else {
        return nil
    }
}

struct OptionalTextField: View {
    let prompt: String
    @Binding
    var value: String?
    
    let pattern = /^(\d{1,2})(\d{4})$/
    
    var body: some View {
        TextField(prompt, text: Binding(
            get: { value ?? "" },
            set: { value = $0.isEmpty ? nil : $0 }
        ))
        .onSubmit {
            print("")
        }
    }
}

extension Date {
    var nextYear: Date {
        Calendar.current.date(byAdding: .year, value: 1, to: self)!
    }
}

/*
 Binding(
     get: { value ?? "" },
     set: { value = $0.isEmpty ? nil : $0 }
 )
 */

struct ContentView: View {
    @State
    var value1: String?
    
    @State
    var value2: String?
    
    @State
    var score: Double = 0
    
    @State
    var date: Date = Date()
   
    @State
    var date2: Date?
   
    @State
    var note: String?
    
    @State
    var code: String = ""
    
    @State
    var customer = Customer(
        id: nil, name: "", city: ""
    )
    
    @State
    var postalCode: String?
    
    
    enum Field: Hashable {
        case postalCode
        case date2
    }
        
    // Step 2: Bind focus to a specific field
    @FocusState private var focusedField: Field?

    
    /*
     let isoWeekNumber = date.formatted(.dateTime.week(.weekOfYear))

     */
    
    
    var body: some View {
        VStack {
           // ContentUnavailableView.search(text: "1234")
            
            TextField("Enter your postalcode", value: $postalCode,
                format: .dutchPostalCode
            )
                .focused($focusedField, equals: .postalCode)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            TextField("Enter your score", value: $date2, format: .dateTime.day().month().year())
                .focused($focusedField, equals: .date2)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            TextField("Enter name", value: $customer.name, format: NoOpFormatStyle())
                .textFieldStyle(.roundedBorder)
                .padding()
            
            TextField("Enter city", value: $customer.city, format: NoOpFormatStyle())
                .textFieldStyle(.roundedBorder)
                .padding()
            
            if let date = date2 {
                Text("\(date.formatted(.dateTime.day().month().year()))")
                Text("Wee; \(date.formatted(.dateTime.week()))")
            } else {
                Text("nil")
            }
            TextField("Code", value: $code, format: .alphanumeric)
                .textFieldStyle(.roundedBorder)
            Text("Formatted: \(code.formatted(.alphanumeric))")

            OptionalTextField(
                prompt: "optional text",
                value: $value1)
            
            Text(value1 ?? "nil")
        }
        .padding()
    }
}
