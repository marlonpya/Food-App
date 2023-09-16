//
//  BeerViewModel.swift
//  Food App
//
//  Created by marlon arteaga on 14/09/23.
//

import Foundation

class BeerViewModel: ObservableObject {
    @Published var list = [DataModel]()
    
    private var currentPage = Constants.View.currenPageDefault
    
    func fetchBeers(food: String) {
        let searchFood = food.trimmingCharacters(in: .whitespacesAndNewlines)
        if searchFood.isEmpty {
            return
        }
        RemoteManager.shared.fetchBeers(food: searchFood) { result in
            DispatchQueue.main.async {
                switch result {
                case.success(let list):
                    self.list = list
                    self.currentReset()
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchBeersScrollDown(food: String) {
        let searchFood = food.trimmingCharacters(in: .whitespacesAndNewlines)
        RemoteManager.shared.fetchBeers(page: String(self.currentPage), perPage: String(Constants.perPage), food: searchFood) { result in
            DispatchQueue.main.async {
                switch result {
                case.success(let list):
                    self.list.append(contentsOf: list)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func addCurrentPage() {
        self.currentPage += 1
    }
    
    func isAvailableForFetch() -> Bool {
        return self.list.count >= Constants.perPage && self.currentPage < Constants.maxPage
    }
    
    func cancelFetch() {
        self.currentReset()
        self.list.removeAll()
    }
    
    private func currentReset() {
        self.currentPage = Constants.View.currenPageDefault
    }

}
