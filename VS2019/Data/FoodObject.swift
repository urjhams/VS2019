//
//  FoodObject.swift
//  VS2019
//
//  Created by Quân Đinh on 30.08.19.
//  Copyright © 2019 Quân Đinh. All rights reserved.
//

import Foundation

public class FoodObject {
    var name: String
    var calories: Double
    var caloriesFromFat: Double
    var totalFat: Double
    var Sodium: Double
    var potasium: Double
    var totalCarboHydrate: Double
    var sugars: Double
    var protein: Double
    var saturatedFat: Double
    var cholesterol: Double
    var type: String
    
    init(name: String?
        , calories: String?
        , caloriesFromFat: String?
        , totalFat: String?
        , Sodium: String?
        , potasium: String?
        , totalCarboHydrate: String?
        , sugars: String?
        , protein: String?
        , saturatedFat: String?
        , cholesterol: String?
        , type: String?) {
            self.name = name ?? ""
            self.calories = calories!.convertToDouble()
            self.caloriesFromFat = caloriesFromFat!.convertToDouble()
            self.totalFat = totalFat!.convertToDouble()
            self.Sodium = Sodium!.convertToDouble()
            self.potasium = potasium!.convertToDouble()
            self.totalCarboHydrate = totalCarboHydrate!.convertToDouble()
            self.sugars = sugars!.convertToDouble()
            self.protein = protein!.convertToDouble()
            self.saturatedFat = saturatedFat!.convertToDouble()
            self.cholesterol = cholesterol!.convertToDouble()
            self.type = type ?? ""
        }
}
