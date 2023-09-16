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
    @Environment(\.isSearching) private var isSearching: Bool
    
    var body: some View {
        NavigationView {
            
            List(viewModel.list, id: \.id){ beer in
                NavigationLink(destination: DetailView(food: beer)) {
                    TableRow(food: beer)
                }
                if viewModel.list.last === beer {
                    if viewModel.isAvailableForFetch() {
                        Text("loading...")
                            .onAppear(perform: {
                                viewModel.addCurrentPage()
                                viewModel.fetchBeersScrollDown(food: searchText)
                            })
                    }
                }
            }
        }
        .autocorrectionDisabled()
        .searchable(text: $searchText, prompt: "Search Foods")
        .onChange(of: searchText) { newValue in
            withAnimation {
                viewModel.fetchBeers(food: newValue)
            }
            if searchText.isEmpty && !isSearching {
                viewModel.cancelFetch()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
