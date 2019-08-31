//
//  ViewController1.swift
//  VS2019
//
//  Created by Quân Đinh on 30.08.19.
//  Copyright © 2019 Quân Đinh. All rights reserved.
//

import UIKit
import Charts

class ViewController1: UIViewController {
    
    @IBOutlet weak var chartView: BarChartView!
    
    var chartData: Array<FoodObject> = [FoodObject]()
    let nutritions = ["calories",
                      "calories from fat",
                      "total fat",
                      "sodium",
                      "potasium",
                      "total carbon-hydrate",
                      "sugar",
                      "protein",
                      "saturated fat",
                      "cholesterol"]
    var names = [String]()
    var calories = [Double]()
    var caloriesFromFats = [Double]()
    var totalFats = [Double]()
    var Sodiums = [Double]()
    var potasiums = [Double]()
    var totalCarboHydrates = [Double]()
    var sugars = [Double]()
    var proteins = [Double]()
    var saturatedFats = [Double]()
    var cholesterols = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFullChartData()
        prepareData()
        var dataEntries = [BarChartDataEntry]()
        for i in 0..<names.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [self.calories[i],
                                                                      self.caloriesFromFats[i],
                                                                      self.totalFats[i],
                                                                      self.Sodiums[i],
                                                                      self.potasiums[i],
                                                                      self.totalCarboHydrates[i],
                                                                      self.sugars[i],
                                                                      self.proteins[i],
                                                                      self.saturatedFats[i],
                                                                      self.cholesterols[i]]
            )
            dataEntries.append(dataEntry)
        }
        let dataSet = BarChartDataSet(entries: dataEntries, label: "")
        dataSet.stackLabels = [String]()
        for name in names {
            dataSet.stackLabels.append(name)
        }
        dataSet.colors = [ UIColor(red: 72/255, green: 201/255, blue: 176/255, alpha: 1),
                           UIColor(red: 220/255, green: 118/255, blue: 51/255, alpha: 1),
                           UIColor(red: 244/255, green: 208/255, blue: 63/255, alpha: 1),
                           UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1),
                           UIColor(red: 61/255, green: 165/255, blue: 255/255, alpha: 1),
                           UIColor(red: 250/255, green: 215/255, blue: 160/255, alpha: 1),
                           UIColor(red: 154/255, green: 125/255, blue: 10/255, alpha: 1),
                           UIColor(red: 84/255, green: 153/255, blue: 199/255, alpha: 1),
                           UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 1),
                           UIColor(red: 146/255, green: 43/255, blue: 33/255, alpha: 1)
        ]
        let data = BarChartData(dataSet: dataSet)
        self.chartView.data = data
    }
    
    private func loadFullChartData() {
        for obj in Static.calories {
            chartData.append(obj)
        }
    }
    
    private func prepareData() {
        for obj in chartData {
            names.append(obj.name.components(separatedBy: ",")[0])
            calories.append(obj.calories)
            caloriesFromFats.append(obj.caloriesFromFat)
            totalFats.append(obj.totalFat)
            Sodiums.append(obj.Sodium)
            potasiums.append(obj.potasium)
            totalCarboHydrates.append(obj.totalCarboHydrate)
            sugars.append(obj.sugars)
            proteins.append(obj.protein)
            saturatedFats.append(obj.saturatedFat)
            cholesterols.append(obj.cholesterol)
        }
    }

}
