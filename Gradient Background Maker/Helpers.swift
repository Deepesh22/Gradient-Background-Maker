//
//  Helpers.swift
//  Gradient Background Maker
//
//  Created by Deepesh Deshumkh on 25/06/20.
//  Copyright © 2020 Deepesh Deshumkh. All rights reserved.
//

import Foundation
import SwiftUI

func loadJson(filename fileName: String) -> [CustomGradient]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([CustomGradient].self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}


extension Color{
    
    init(hex:String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            self.init("gray")
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: Double((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgbValue & 0x0000FF) / 255.0,
            opacity: 1
        )
    }
    
}

extension UIImage {
    static func gradientImageWithBounds(bounds: CGRect, colors: [CGColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        print(image!)
        return image!
    }
}

extension UIColor {

  convenience init(hex: String, alpha: CGFloat = 1.0) {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) { cString.removeFirst() }

    if ((cString.count) != 6) {
      self.init(hex: "ff0000") // return red color for wrong hex input
      return
    }

    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: alpha)
  }

}

func textToImage(drawText text: String, withTextColor textColor: UIColor, inImage image: UIImage, atPoint point: CGPoint) -> UIImage{

    // Setup the font specific variables
    let textFont = UIFont(name: "Helvetica Bold", size: 24)!

    // Setup the image context using the passed image
    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

    // Setup the font attributes that will be later used to dictate how the text should be drawn
    let textFontAttributes = [
                            NSAttributedString.Key.font: textFont,
                            NSAttributedString.Key.foregroundColor: textColor,
                            ] as [NSAttributedString.Key : Any]

    // Put the image into a rectangle as large as the original image
    image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

    // Create a point within the space that is as bit as the image
    let rect = CGRect(origin: point, size: image.size)

    // Draw the text into an image
    text.draw(in: rect, withAttributes: textFontAttributes)

    // Create a new image out of the images we have created
    let newImage = UIGraphicsGetImageFromCurrentImageContext()

    // End the context now that we have the image we need
    UIGraphicsEndImageContext()

    //Pass the image back up to the caller
    return newImage!

}

