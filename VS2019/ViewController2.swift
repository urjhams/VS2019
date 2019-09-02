//
//  ViewController2.swift
//  VS2019
//
//  Created by Quân Đinh on 31.08.19.
//  Copyright © 2019 Quân Đinh. All rights reserved.
//

import UIKit
import AnyChartiOS

class ViewController2: UIViewController {

    @IBOutlet weak var chartView: AnyChartView!
    
    var objects = [SuperFoodObject]()
    
    override func viewDidLoad() {
        for superObj in Static.superFood {
            for obj in Static.calories {
                if(obj.name.lowercased().components(separatedBy: ",")[0] == superObj.name.lowercased()) {
                    var add = true
                    for currentObj in objects {
                        if currentObj.name.lowercased() == superObj.name.lowercased() {
                            add = false
                        }
                    }
                    if add {
                        objects.append(superObj)
                    }
                }
            }
        }
        super.viewDidLoad()
        let chart = AnyChart.heatMap()
//        chart.labels()
//            .minFontSize(size: 14)
//            .format(token: "function() { var namesList = [\"Low\", \"Medium\", \"High\", \"Extreme\"]; var h = this. heat; if (h == 5) {return '';} return namesList[this.heat]; }")
        var data = [DataEntry]()
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "Strong", heat: 5))
        }
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "Good", heat: 4))
        }
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "Promising", heat: 3))
        }
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "Conflicting", heat: 2))
        }
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "Slight", heat: 1))
        }
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "No evidence", heat: 0))
        }
        
        let _ = chart.data(data: data)
        
        ////        chart.title(settings: "Fruits imported in 2015 (in kg)")
        //
        chartView.setChart(chart: chart)
        
    }
    
    
}
