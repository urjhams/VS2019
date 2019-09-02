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
        chart.labels()
            .minFontSize(size: 6)
            .format(
                token: "function() { var namesList = ['','','',\"Type 2 diabetes\", \"cancer\",\"weight loss, cardiovascular health\",'','',\"osteoarthritis\",'','','',\"cardiovascular health\"]; return namesList[this.heat]; }"
        )
        var data = [DataEntry]()
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "Strong", heat: obj.envidence == 5 ? 12 : 11))
        }
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "Good", heat: obj.envidence == 4 ? 10 : 9))
        }
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "Promising", heat: obj.envidence == 3 ? 8 : 7))
        }
        var repeating = true
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "Conflicting", heat: obj.envidence == 2 ? (!repeating ? 5 : 4) : (!repeating ? 6 : 4)))
            repeating = false
        }
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "Slight", heat: obj.envidence == 1 ? 3 : 2))
        }
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "No evidence", heat: obj.envidence == 0 ? 1 : 0))
        }
        
        let _ = chart.data(data: data)
        
        ////        chart.title(settings: "Fruits imported in 2015 (in kg)")
        //
        chartView.setChart(chart: chart)
    }
    
    
}
