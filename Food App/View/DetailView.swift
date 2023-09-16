//
//  DetailView.swift
//  Food App
//
//  Created by marlon arteaga on 16/09/23.
//

import SwiftUI

struct DetailView: View {
    let food: DataModel
    
    var body: some View {
        VStack {
            Text(food.name ?? "")
                .font(.title)
                .fontWeight(.medium)
            Form {
                Section{
                    HStack {
                        Text("Eslogan")
                        Spacer()
                        Text(food.tagline ?? "")
                            .foregroundColor(.gray)
                            .frame(alignment: .leading)
                    }
                    HStack {
                        Text("Primera vez probada")
                        Spacer()
                        Text(food.first_brewed ?? "")
                            .foregroundColor(.gray)
                            .frame(alignment: .leading)
                    }
                    HStack {
                        Text("Descripción")
                        Spacer()
                        Text(food.description ?? "")
                            .foregroundColor(.gray)
                            .frame(alignment: .leading)
                    }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(food: DataModel.init(id:1,name:"Pilsen",tagline:"deberīas probarlo !",first_brewed:"04/2020",description:"Bebida descripción Bebida descripción Bebida descripción Bebida descripción"))
    }
}
