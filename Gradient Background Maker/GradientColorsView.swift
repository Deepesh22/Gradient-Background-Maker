//
//  ContentView.swift
//  Gradient Background Maker
//
//  Created by Deepesh Deshumkh on 24/06/20.
//  Copyright © 2020 Deepesh Deshumkh. All rights reserved.
//

import SwiftUI

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
                .frame(height: 300)
                .padding(self.leading ? .leading : .trailing, 10)
        }
        .transition(AnyTransition.scale(scale: 2))
    }
}

struct GradientColorsView: View {
    
    let gradients: [CustomGradient] = loadJson(filename: "gradients") ?? []
    
    @ObservedObject var userCustomGradients = UserCustomGradientsItems()
    
    var body: some View {
            TabView {
                NavigationView{
                    ScrollView{
                        if self.gradients.count > 1{
                            ForEach(Array(stride(from: 0, to: self.gradients.count, by: 2)), id: \.self){ index in
                                HStack{
                                    NavigationLink(destination:
                                    
                                        GradientColorView(gradient: self.gradients[index], gradientNotFromPresets: false, userCustomGradientItems: self.userCustomGradients)
                                    ){
                                        GridCell(gradient: self.gradients[index], leading: true)
                                    }
                                    NavigationLink(destination:
                                        GradientColorView(gradient: self.gradients[index+1], gradientNotFromPresets: false, userCustomGradientItems: self.userCustomGradients)
                                    ){
                                        GridCell(gradient: self.gradients[index+1], leading: false)
                                    }
                                }
                            }
                        }else{
                            Text("Oops! Something went wrong!")
                        }
                    }
                    .navigationBarTitle("Gradient Colors 1")
                }
            .tabItem {
                Image(systemName: "1.square.fill")
                Text("Presets")
            }
                
                NavigationView{
                    ScrollView{
                        if self.userCustomGradients.UserCustomGradients.count > 1{
                            ForEach(self.userCustomGradients.UserCustomGradients, id: \.self){ gradient in
                                NavigationLink(destination:
                                
                                    GradientColorView(gradient: gradient, gradientNotFromPresets: false, userCustomGradientItems: self.userCustomGradients)
                                ){
                                    GridCell(gradient: gradient, leading: true)
                                }
                            }
                        }else{
                            Text("Create your own by tapping on top right corner...")
                                .font(.title)
                        }
                    }
                    .navigationBarTitle("Gradient Colors 2")
                    .navigationBarItems(trailing:
                        NavigationLink(destination: CustomGradientMaker(userCustomGradients: self.userCustomGradients)){
                           Image(systemName: "slider.horizontal.3")
                            .resizable()
                            .padding()
                            .scaleEffect(1.5)
                    })
                }
            .tabItem {
                Image(systemName: "2.square.fill")
                Text("Customs")
            }
        }
    }
}


struct GradientColorsView_Previews: PreviewProvider {
    static var previews: some View {
        GradientColorsView()
    }
}
