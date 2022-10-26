//
//  BusinessDetail.swift
//  CitySightsApp
//
//  Created by Michał Ganiebny on 25/10/2022.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business: Business
    @State private var showDirections = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 0) {
                GeometryReader { geometry in
                    // Image
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        
                }.ignoresSafeArea(.all, edges: .top)
                
                // Open/closed rectangle
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    Text(business.isClosed! ? "Closed" : "Open")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading)
                }
            }
            Group {
                VStack(alignment: .leading) {
                    
                    BusinessTitle(business: business)
                        .padding()
                    
                    Divider()
                    
                    // Phone
                    HStack {
                        Text("Phone:")
                            .bold()
                        Text(business.displayPhone ?? "")
                        Spacer()
                        Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                    }.padding()
                    
                    Divider()
                    
                    // Reviews
                    HStack {
                        Text("Reviews:")
                            .bold()
                        Text(String(business.reviewCount ?? 0))
                        Spacer()
                        Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                    }.padding()
                    
                    Divider()
                    
                    // Website
                    HStack {
                        Text("Website:")
                            .bold()
                        Text(String(business.url ?? ""))
                            .lineLimit(1)
                        Spacer()
                        Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                    }.padding()
            }
                Divider()
                
                Button {
                    showDirections = true
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.blue)
                            .frame(height: 48)
                            .cornerRadius(10)
                        Text("Get directions")
                            .foregroundColor(.white)
                            .bold()
                    }
                }.padding()
                    .sheet(isPresented: $showDirections) {
                        DirectionsView(business: business)
                            .ignoresSafeArea()
                    }

                
                
                
            }
        }
    }
}


