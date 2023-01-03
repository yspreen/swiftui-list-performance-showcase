//
//  ContentView.swift
//  performancetest
//
//  Created by Nick on 1/3/23.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		TestView()
			.environmentObject(globalState)
			.task {
				(0...10000).forEach { _ in
					globalState.newItem()
				}
				updateLater()
			}
	}

	func updateLater() {
		DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.5) {
			update()
		}
	}

	func update() {
		DispatchQueue.main.async {
			let id = globalState.itemIds[3]
			var item = globalState.itemDict[id]!
			item.newColor()
			item.text = "changed"
			globalState.itemDict[id] = item
		}
		updateLater()
	}
}

extension State {
	func newItem() {
		let item = Item()
		itemDict[item.id] = item
		itemIds.append(item.id)
	}
}

let globalState = State()
