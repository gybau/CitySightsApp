//
//  BusinessList.swift
//  CitySightsApp
//
//  Created by Michał Ganiebny on 24/10/2022.
//

import SwiftUI

struct BusinessList: View {
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                BusinessSection(title: "Restaurants", businesses: model.restaurants)
                BusinessSection(title: "Sights", businesses: model.sights)
            }
            
            
        }
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
    }
}
