//
//  GradientView.swift
//  Gradient Background Maker
//
//  Created by Deepesh Deshumkh on 25/06/20.
//  Copyright © 2020 Deepesh Deshumkh. All rights reserved.
//

import SwiftUI

struct GradientColorView: View {
    
    let gradient: CustomGradient
    
    @State var showCopylabel = false
    
    var body: some View{
        ZStack{
            LinearGradient(gradient: Gradient(
                                colors: gradient.colors.map({
                                Color.init(hex: $0)
                            })),
                            startPoint: .top,
                            endPoint: .bottom)
            Text("Hex codes Copied!!!")
                .offset(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 100)
                .scaleEffect(self.showCopylabel ? 1 : 0)
                .foregroundColor(.white)
                .background(Color.black.opacity(0.5))
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle(Text(gradient.name), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            let pasteboard = UIPasteboard.general
            pasteboard.strings = self.gradient.colors
            self.showCopylabel = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.showCopylabel = false
            }
        }){
            Text(gradient.name)
                .foregroundColor(Color.white)
        })
    }
}

struct GradientColorView_Previews: PreviewProvider {
    static var previews: some View {
        GradientColorsView()
    }
}

