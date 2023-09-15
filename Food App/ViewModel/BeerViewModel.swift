//
//  BeerViewModel.swift
//  Food App
//
//  Created by marlon arteaga on 14/09/23.
//

import Foundation

class BeerViewModel: ObservableObject {
    @Published var list = [DataModel]()
    @Published var filterList = [DataModel]()
    
    var currentPage = 1
    var currentPageFilter = 1
    var lastSearchBeer = ""
    
    init() {
        getBeers()
    }
    
    func getBeers() {
        RemoteManager.shared.getBeer(page: String(self.currentPage), perPage: String(Constants.perPage)) { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result {
                case.success(let list):
                    self.resetFilter()
                    self.list.append(contentsOf: list)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getBeers(food: String) {
        let cleanFood = food.trimmingCharacters(in: .whitespacesAndNewlines)
        if food.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || self.lastSearchBeer.caseInsensitiveCompare(cleanFood) == .orderedSame{
            return
        }
        
        self.lastSearchBeer = food.trimmingCharacters(in: .whitespacesAndNewlines)
        RemoteManager.shared.getBeer(page: String(self.currentPageFilter), perPage: String(Constants.perPage), food: food) { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result {
                case.success(let list):
                    self.filterList.append(contentsOf: list)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func isLast(beer: DataModel) -> Bool {
        if !self.list.isEmpty && self.filterList.isEmpty {
            return self.list.last === beer
        } else if !self.list.isEmpty && !self.filterList.isEmpty {
            return self.filterList.last === beer
        }
        return false
    }
    
    func addCurrentPage() {
        if self.filterList.isEmpty {
            self.currentPage += 1
        } else {
            self.currentPageFilter += 1
        }
    }
    
    func isAvailableForFetch() -> Bool {
        let currentPage = self.filterList.isEmpty ? self.currentPage : self.currentPageFilter
        return currentPage < Constants.maxPage
    }
    
    func resetFilter() {
        self.currentPageFilter = 1
        self.filterList.removeAll()
    }

}
