//
//  ContentView.swift
//  Gradient Background Maker
//
//  Created by Deepesh Deshumkh on 24/06/20.
//  Copyright © 2020 Deepesh Deshumkh. All rights reserved.
//

import SwiftUI

struct CustomGradient: Decodable{
    let name: String
    let colors: [String]
}

struct ContentView: View {
    
    let gradients: [CustomGradient] = loadJson(filename: "gradients") ?? []
    
    var somerandomindex: Int{
        Int.random(in: 0..<gradients.count)
    }
    
    var body: some View {
        
        ZStack{
            
            LinearGradient(gradient: Gradient(
                colors: gradients[somerandomindex].colors.map({
                    Color.init(hex: $0)
                })),
                startPoint: .top,
                endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            Text(gradients[somerandomindex].name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
