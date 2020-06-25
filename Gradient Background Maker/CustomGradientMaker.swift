//
//  CustomGradientMaker.swift
//  Gradient Background Maker
//
//  Created by Deepesh Deshumkh on 25/06/20.
//  Copyright © 2020 Deepesh Deshumkh. All rights reserved.
//

import SwiftUI

struct Sliders: View{
    
    @Binding var red: Double
    @Binding var blue: Double
    @Binding var green: Double
    
    var body: some View{
        HStack{
            VStack{
                Slider(value: $red, in: 0...255, step: 1.0)
                Text("RED \(Int(red))")
            }
            VStack{
                Slider(value: $blue, in: 0...255, step: 1.0)
                Text("BLUE \(Int(blue))")
            }
            VStack{
                Slider(value: $green, in: 0...255, step: 1.0)
                Text("GREEN \(Int(green))")
            }
        }
        .padding()
        
    }
}


struct CustomGradientMaker: View {
    
    @State private var red = 255.0
    @State private var blue = 255.0
    @State private var green = 255.0
    
    @State private var red2 = 0.0
    @State private var blue2 = 0.0
    @State private var green2 = 0.0
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [
                        Color.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0),
                        Color.init(red: red2 / 255.0, green: green2 / 255.0, blue: blue2 / 255.0)
                        ]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack{
                
                Sliders(red: $red, blue: $blue, green: $green)
                
                Button(action: {
                    swap(&self.red, &self.red2)
                    swap(&self.blue, &self.blue2)
                    swap(&self.green, &self.green2)
                }){
                    CustomTextField(text: "Flip Values")
                }
                
                Sliders(red: $red2, blue: $blue2, green: $green2)
            }
                
            .navigationBarItems(trailing:
                NavigationLink(destination:
                    GradientColorView(gradient: CustomGradient(name: "myCustomGradient",
                                                               colors: [ toHexString(r: Int(red), g: Int(green), b: Int(blue)),
                                                                         toHexString(r: Int(red2), g: Int(green2), b: Int(blue2))]
                    ))
                ){
                    Image(systemName: "viewfinder")
                        .resizable()
                        .padding()
                        .scaleEffect(1.5)
                }
            )
        }
    }
}

struct CustomGradientMaker_Previews: PreviewProvider {
    static var previews: some View {
        CustomGradientMaker()
    }
}
