//
//  TestView.swift
//  performancetest
//
//  Created by Nick on 1/3/23.
//

import SwiftUI

struct TestView: View {
	@EnvironmentObject var state: State

	var items: [Item] {
		state.itemList.filter {
			!$0.text.isEmpty
		}
	}

	var body: some View {
		ScrollView {
			LazyVStack {
				ForEach(items, id: \.id) { item in
					row(item)
				}
			}
		}
	}

	func row(_ item: Item) -> some View {
		Button {

		} label: {
			Text(item.text)
				.frame(maxWidth: .infinity)
				.padding()
				.background(item.color.opacity(0.2))
		}
	}
}

class State: ObservableObject {
	@Published var itemIds: [UUID] = []
	@Published var itemDict: [UUID: Item] = [:]

	var itemList: [Item] {
		itemIds.compactMap {
			itemDict[$0]
		}
	}
}

func randomColor() -> Color { Color(hue: .random(in: 0...1), saturation: 0.9, brightness: 0.5) }

struct Item {
	var id = UUID()
	var text = "Hello"
	var color = randomColor()

	mutating func newColor() {
		color = randomColor()
	}
}

