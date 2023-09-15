//
//  TableRow.swift
//  Food App
//
//  Created by marlon arteaga on 14/09/23.
//

import Foundation
import SwiftUI

struct TableRow: View {
    
    var food: DataModel? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(String(food?.id ?? -1))
            Text(food?.name ?? "")
        }
    }
}

struct TableRow_ViewProvider: PreviewProvider {
    static var previews: some View {
        TableRow()
    }
}
