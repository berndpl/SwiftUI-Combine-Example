//
//  ContentView.swift
//  Shared
//
//  Created by Bernd Plontsch on 28.06.20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: Model
    
    @State var showEntry = false
        
    var groupedByDate: [Date: [Item]] {
        Dictionary(grouping: model.items, by: {$0.createDate})
    }
    
    var headers: [Date] {
        groupedByDate.map({ $0.key }).sorted()
    }
    
    var body: some View {
        VStack {
            HStack {
                entryButton(preset: defaultPresets()[0], model:model)
                entryButton(preset: defaultPresets()[1], model:model)
                entryButton(preset: defaultPresets()[2], model:model)
            }
            NavigationView {
                List {
                    ForEach(headers, id: \.self) { header in
                                    Section(header: Text(header, style: .date)) {
                                        ForEach(groupedByDate[header]!) { item in
                                            Text(item.title)
                            }
                        }
                    }.onDelete(perform: delete).navigationTitle("Snacked")
//                    Section(header: Text("Monday")) {
//                    ForEach (model.items, id: \.self) { item in
//                        HStack {
//                        Text(item.title)
//                        }
//                    }.onDelete(perform: delete).navigationTitle("Snacked")
//                    }
                }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        model.items.remove(atOffsets: offsets)
    }
}


fileprivate func entryButton(preset:Preset, model:Model) -> Button<Text> {
    return Button(action: { //showEntry.toggle()
        let newItem = Item(title: preset.title, calories: preset.calories, colorLiteral: preset.colorLiteral, createDate: Date())
        model.items.append(newItem)
        print("Items \(model.items)")
    }, label: {Text("\(preset.title)")})
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            let items = [Item(title: "🍕", calories: 300.0, colorLiteral: "pink", createDate: Date()),
                         Item(title: "🍔", calories: 300.0, colorLiteral: "pink", createDate: Date()),
                         Item(title: "🍱", calories: 300.0, colorLiteral: "pink", createDate: Date())]
            let model = Model()
            ContentView(model: model)
        }
    }
}
