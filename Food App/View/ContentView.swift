//
//  ContentView.swift
//  Food App
//
//  Created by marlon arteaga on 14/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @StateObject var viewModel = BeerViewModel()
    
    var body: some View {
        NavigationView {
            let currentList: [DataModel] = viewModel.filterList.isEmpty ? viewModel.list : viewModel.filterList
            
            List(currentList, id: \.id){ beer in
                TableRow(food: beer)
                if viewModel.isLast(beer: beer) {
                    if viewModel.isAvailableForFetch() {
                        Text("loading...")
                            .onAppear(perform: {
                                viewModel.addCurrentPage()
                                //viewModel.getBeers()
                                viewModel.getBeers(food: searchText)
                            })
                    }
                }
            }
                
            
        }
        .searchable(text: $searchText, prompt: "Search Foods")
        .onChange(of: searchText) { newValue in
            withAnimation {
                viewModel.getBeers(food: newValue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
