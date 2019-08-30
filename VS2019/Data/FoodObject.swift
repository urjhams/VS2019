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
    var sodiumDV: Int8
    var potasium: Double
    var potasiumDV: Int8
    var totalCarboHydrate: Double
    var dietaryFiber: Int8
    var sugars: Double
    var protein: Double
    var vitaminA: Int8
    var vitaminC: Int8
    var calciumDV: Int8
    var ironDV: Int8
    var saturatedFatDV: Int8
    var saturatedFat: Double
    var cholesterol: Double
    var cholesterolDV: Int8
    var type: String
    
    init(name: String?
        , calories: String?
        , caloriesFromFat: String?
        , totalFat: String?
        , Sodium: String?
        , sodiumDV: String?
        , potasium: String?
        , potasiumDV: String?
        , totalCarboHydrate: String?
        , dietaryFiber: String?
        , sugars: String?
        , protein: String?
        , vitaminA: String?
        , vitaminC: String?
        , calciumDV: String?
        , ironDV: String?
        , saturatedFatDV: String?
        , saturatedFat: String?
        , cholesterol: String?
        , cholesterolDV: String?
        , type: String?) {
            self.name = name ?? ""
            self.calories = calories!.convertToDouble()
            self.caloriesFromFat = caloriesFromFat!.convertToDouble()
            self.totalFat = totalFat!.convertToDouble()
            self.Sodium = Sodium!.convertToDouble()
            self.sodiumDV = sodiumDV!.convertToInt8()
            self.potasium = potasium!.convertToDouble()
            self.potasiumDV = potasiumDV!.convertToInt8()
            self.totalCarboHydrate = totalCarboHydrate!.convertToDouble()
            self.dietaryFiber = dietaryFiber!.convertToInt8()
            self.sugars = sugars!.convertToDouble()
            self.protein = protein!.convertToDouble()
            self.vitaminA = vitaminA!.convertToInt8()
            self.vitaminC =  vitaminC!.convertToInt8()
            self.calciumDV = calciumDV!.convertToInt8()
            self.ironDV = ironDV!.convertToInt8()
            self.saturatedFatDV = saturatedFatDV!.convertToInt8()
            self.saturatedFat = saturatedFat!.convertToDouble()
            self.cholesterol = cholesterol!.convertToDouble()
            self.cholesterolDV = cholesterolDV!.convertToInt8()
            self.type = type ?? ""
        }
}
