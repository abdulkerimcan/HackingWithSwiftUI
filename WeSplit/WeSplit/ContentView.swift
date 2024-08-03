//
//  ContentView.swift
//  WeSplit
//
//  Created by Abdulkerim Can on 3.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isAmountFocused: Bool
    
    private let currentCurrency = Locale.current.currency?.identifier ?? "USD"
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = (checkAmount / 100 ) * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currentCurrency))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.navigationLink)

                } header: {
                    Text("How much do you want to tip?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: currentCurrency))
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(checkAmount, format: .currency(code: currentCurrency))
                } header: {
                    Text("Total Amount")
                }
            }.navigationTitle("WeSplit")
                .toolbar {
                    if isAmountFocused {
                        Button("Done") {
                            isAmountFocused = false
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
