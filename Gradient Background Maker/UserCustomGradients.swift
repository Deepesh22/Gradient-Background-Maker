//
//  UserCustomGradients.swift
//  Gradient Background Maker
//
//  Created by Deepesh Deshumkh on 29/06/20.
//  Copyright © 2020 Deepesh Deshumkh. All rights reserved.
//

import Foundation

struct CustomGradient:Codable, Hashable{
    let name: String
    let colors: [String]
    
    init(name: String, colors: [String]) {
        self.name = name
        self.colors = colors
    }
}


class UserCustomGradientsItems: ObservableObject{

    @Published var UserCustomGradients = [CustomGradient](){
        didSet{
            
            let enc = JSONEncoder()
            if let encoded = try? enc.encode(UserCustomGradients){
                
                UserDefaults.standard.set(encoded, forKey: "UserCustomGradients")
            }
            else{
                print("ERROR in encoding")
            }
        }
    }

    init(){
        if let UserCustomGradients = UserDefaults.standard.data(forKey: "UserCustomGradients"){
            let decode = JSONDecoder()
            
            if let decoded = try? decode.decode([CustomGradient].self, from: UserCustomGradients){
                self.UserCustomGradients = decoded
            }else{
                print("Eror decoding")
            }
        }else{
            print("Error finding key")
        }
    }
}
