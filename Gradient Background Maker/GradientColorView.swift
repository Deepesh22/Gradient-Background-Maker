//
//  GradientView.swift
//  Gradient Background Maker
//
//  Created by Deepesh Deshumkh on 25/06/20.
//  Copyright © 2020 Deepesh Deshumkh. All rights reserved.
//

import SwiftUI
import CoreImage

struct CustomTextField: View{
    @Environment(\.colorScheme) var colorScheme
    
    let text: String
    var body: some View{
        Text(text)
            .padding()
            .foregroundColor(.primary)
            .background(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.2))
            .cornerRadius(40)
    }
}

struct Options: View{
    
    @Binding var showOptions: Bool
    @Binding var showCopiedlabel: Bool
    let gradientNotFromPresets: Bool
    
    let userCustomGradientItems: UserCustomGradientsItems
    
    let gradient: CustomGradient
    
    var body: some View{
        VStack(spacing: 10){
            CustomTextField(text: "Copy HEX codes")
                .onTapGesture {
                    self.showOptions.toggle()
                    let pasteboard = UIPasteboard.general
                    pasteboard.strings = self.gradient.colors
                    self.showCopiedlabel = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75){
                        self.showCopiedlabel = false
                    }
            }

            CustomTextField(text: "Share Gradient")
                .onTapGesture {
                    self.showOptions.toggle()
//                    DispatchQueue.main.async {
                        share(gradientC: self.gradient)
//                    }
            }
            
            if self.gradientNotFromPresets{
                CustomTextField(text: "Save Gradient in App")
                .onTapGesture {
                    self.showOptions.toggle()
                    DispatchQueue.main.async {
                        self.userCustomGradientItems.UserCustomGradients.append(self.gradient)
                    }
                }
            }
        }
        .font(.headline)
    }
}



struct GradientColorView: View {
    
    let gradient: CustomGradient
    let gradientNotFromPresets: Bool
    
    let userCustomGradientItems: UserCustomGradientsItems
    
    @State var showOptions = false
    @State var showCopiedlabel = false
    
    var body: some View{
        ZStack{
            LinearGradient(gradient: Gradient(
                                colors: gradient.colors.map({
                                Color.init(hex: $0)
                            })),
                            startPoint: .top,
                            endPoint: .bottom)
                .opacity(showOptions ? 0.7 : 1)
                .animation(.default)
            
            if showOptions{
                Options(showOptions: $showOptions, showCopiedlabel: $showCopiedlabel, gradientNotFromPresets: gradientNotFromPresets, userCustomGradientItems: self.userCustomGradientItems, gradient: gradient)
            }
            
            CustomTextField(text: "Copied!!")
                .offset(y: self.showCopiedlabel ? -UIScreen.main.bounds.height / 2 + 250 : -UIScreen.main.bounds.height / 2)
                .animation(.spring())
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle(Text(gradient.name), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showOptions.toggle()
        }){
            Image(systemName: "option")
                .resizable()
                .padding()
                .scaleEffect(1.5)
            }
        )
    }
}

func share(gradientC: CustomGradient){
    
    let colors = gradientC.colors.map({ UIColor.init(hex: $0).cgColor })
    
    let image = UIImage.gradientImageWithBounds(bounds: UIScreen.main.bounds, colors: colors)
        
    let av = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true)
}


struct GradientColorView_Previews: PreviewProvider {
    static var previews: some View {
        GradientColorView(gradient: CustomGradient(name: "CustomGradient", colors: [ "000000", "FFFFFF"]), gradientNotFromPresets: true, userCustomGradientItems: UserCustomGradientsItems())
    }
}

