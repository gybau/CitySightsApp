//
//  BusinessSection.swift
//  CitySightsApp
//
//  Created by Michał Ganiebny on 24/10/2022.
//

import SwiftUI

struct BusinessSection: View {
    
    
    
    var title:String
    var businesses:[Business]
    
    var body: some View {
        
        Section(header: BusinessSectionHeader(title: title)) {
            ForEach(businesses) { business in
                NavigationLink {
                    BusinessDetail(business: business)
                } label: {
                    BusinessRow(business: business)

                }

            }
        }
    }
}


