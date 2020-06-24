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

struct GridCell: View{
    
    let gradient: CustomGradient
    let leading: Bool
    var body: some View{
        VStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(gradient: Gradient(
                                    colors: gradient.colors.map({
                                        Color.init(hex: $0)
                                    })),
                                    startPoint: .top,
                                    endPoint: .bottom))
                .frame(height: 200)
                .padding(self.leading ? .leading : .trailing, 10)
        }
    }
}

struct GradientColorsView: View {
    
    let gradients: [CustomGradient] = loadJson(filename: "gradients") ?? []
    
    var body: some View {
        
        NavigationView{
            
            ScrollView{
                if self.gradients.count > 0{
                    ForEach(Array(stride(from: 0, to: self.gradients.count, by: 2)), id: \.self){ index in
                        HStack{
                            NavigationLink(destination:
                                GradientColorView(gradient: self.gradients[index])
                            ){
                                GridCell(gradient: self.gradients[index], leading: true)
                            }
                            NavigationLink(destination:
                                GradientColorView(gradient: self.gradients[index+1])
                            ){
                                GridCell(gradient: self.gradients[index+1], leading: false)
                            }
                        }
                    }
                }else{
                    Text("Oops! Something went wrong!")
                }
            }
            
            .navigationBarTitle("Gradient Colors")
        }
    }
}

struct GradientColorsView_Previews: PreviewProvider {
    static var previews: some View {
        GradientColorsView()
    }
}