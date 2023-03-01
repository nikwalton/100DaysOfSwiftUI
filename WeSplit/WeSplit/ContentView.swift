//
//  ContentView.swift
//  WeSplit
//
//  Created by Nikolaus Walton on 2/28/23.
//

import SwiftUI

struct ContentView: View {
	@State private var check_amount = 0.0
	@State private var num_people = 2
	@State private var tip_percentage = 20
	
	@FocusState private var amount_is_focused: Bool
	
	let tip_percentages = [10, 15, 20, 25, 0]
	var total_per_person: Double {
		//calcuate the total each person needs to pay
		let people_count = Double(num_people + 2)
		let tip_selection = Double(tip_percentage)
		
		let tip_val = check_amount / 100 * tip_selection
		let grand_total = check_amount + tip_val
		let amount_per_person = grand_total / people_count
		
		return amount_per_person
	}
	var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Amount", value: $check_amount, format: .currency(code: Locale.current.currency?.identifier ??  "USD"))
						.keyboardType(.decimalPad)
						.focused($amount_is_focused)
					Picker("Number of People", selection: $num_people) {
						ForEach(2 ..< 100) {
							Text("\($0) people")
						}
					}
				}
				Section {
					Text("How much of a tip are we leaving?")
					Picker("Tip Percentage", selection: $tip_percentage) {
						ForEach(0 ..< 101) {
							Text($0, format: .percent)
						}
					}
				}
				Section {
					Text("Total Amount Including Tip")
					let grand_total = total_per_person * Double(num_people + 2)
					Text(grand_total, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
				}
				Section {
					Text("Amount Per Person")
					Text(total_per_person, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
				}
				
			}
			
			.navigationTitle("WeSplit")
			.toolbar {
				ToolbarItemGroup(placement: .keyboard) {
					Spacer()
					Button("Done") {
						amount_is_focused = false
					}
				}
			}
		}
	}
	
	struct ContentView_Previews: PreviewProvider {
		static var previews: some View {
			ContentView()
		}
	}
}
