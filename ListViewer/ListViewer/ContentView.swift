//
//  ContentView.swift
//  ListViewer
//
//  Created by Bernd Plontsch on 23.06.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import SwiftUI

// MARK: Data

let urlWithJSON = "https://pokeapi.co/api/v2/pokemon?limit=151"

struct APIResults:Decodable {
    var results:[Item]
}

struct Item:Identifiable, Codable {
    var id:UUID = UUID()
    var title:String
    private enum CodingKeys: String, CodingKey {
        case title = "name"
    }
}

// MARK: Model

class ItemsViewModel: ObservableObject {
    @Published var items:[Item] = [Item]()
    
    init() {
        shouldRefresh()
    }
    
    func shouldRefresh() {
        guard let url = URL(string:urlWithJSON) else { return }
        URLSession.shared.dataTask(with: url) { (data, error, _) in
            guard let data = data else { return }
            let pokemonList = try! JSONDecoder().decode(APIResults.self, from: data)
            DispatchQueue.main.async {
                self.items = pokemonList.results
            }
        }.resume()
    }
}

// MARK: List

struct ContentView:View {
    @ObservedObject var viewModel: ItemsViewModel
    @State var showingEntry = false
    
    var body: some View {
        NavigationView {
            List(viewModel.items) { item in
                NavigationLink(destination: ItemDetail(item: item)){
                    ItemRow(item: item)
                }
            }.navigationBarTitle("Items").navigationBarItems(leading:
                    Button("Refresh") {
                        self.viewModel.shouldRefresh()
                    }, trailing: Button(action: { self.showingEntry.toggle() }) {
                        Text("Add")
                    }.sheet(isPresented: $showingEntry) {
                        ItemEntry()
                }
            )
        }
    }
}

// MARK: View

struct ItemEntry:View {
    var body:some View {
        VStack(){
            Text("Entry")
            }
        }
}


struct ItemDetail:View {
    var item:Item
    var body:some View {
            Text(item.title)
    }
}

// MARK: Row

struct ItemRow:View {
    var item:Item
    var body: some View {
        Text(item.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
