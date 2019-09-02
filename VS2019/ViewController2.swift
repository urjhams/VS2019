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
    @IBAction func clickBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
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
        print(objects)
        super.viewDidLoad()
        let chart = AnyChart.heatMap()
        chart.tooltip().format(format: "function() {if (this.x == 'strawberries' && this.y == 'Conflicting') { return 'cancer';} else if (this.x == 'grapes' && this.y == 'Strong') {return 'cardiovascular disease';} else if (this.x == 'kiwi' && this.y == 'Conflicting'){return 'cardiovascular disease';} else if (this.x == 'sweet potato' && this.y == 'Slight') {return 'type 2 diabetes';} else if (this.x == 'apple' && this.y == 'Conflicting') {return 'many conditions';} else if (this.x == 'pineapple' && this.y == 'Promising') {return 'osteoarthritis';} else if (this.x == 'grapefruit' && this.y == 'Conflicting') {return 'wieght loss, cardiovascular health';} else {return '';} }")
//        chart.labels()
//            .minFontSize(size: 6)
//            .format(
//                token: "function() { var namesList = ['','','',\"Type 2 diabetes\", \"cancer\",\"weight loss, cardiovascular health\",'','',\"osteoarthritis\",'','','',''›,\"cardiovascular health\"]; return namesList[this.heat]; }"
//        )
        chart.labels()
            .minFontSize(size: 7)
            .format(
                token: "function() { if (this.x == 'strawberries' && this.y == 'Conflicting') { return 'cancer';} else if (this.x == 'grapes' && this.y == 'Strong') {return 'cardiovascular disease';} else if (this.x == 'kiwi' && this.y == 'Conflicting'){return 'cardiovascular disease';} else if (this.x == 'sweet potato' && this.y == 'Slight') {return 'type 2 diabetes';} else if (this.x == 'apple' && this.y == 'Conflicting') {return 'many conditions';} else if (this.x == 'pineapple' && this.y == 'Promising') {return 'osteoarthritis';} else if (this.x == 'grapefruit' && this.y == 'Conflicting') {return 'wieght loss, cardiovascular health';} else {return '';} }"
        )
        var data = [DataEntry]()
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "Strong", heat: 10))
        }
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "Good", heat: 8))
        }
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "Promising", heat: 6))
        }
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "Conflicting", heat: 4))
        }
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "Slight", heat: 2))
        }
        for obj in objects {
            data.append(HeatMapDataEntry(x: obj.name, y: "No evidence", heat: 0))
        }
        
        let _ = chart.data(data: data)
        
        ////        chart.title(settings: "Fruits imported in 2015 (in kg)")
        //
        chartView.setChart(chart: chart)
    }
    private func smallCaculate(repeating: Int) -> Int {
        switch repeating {
        case 0:
            return 5
        case 1:
            return 6
        case 2:
            return 7
        case 3:
            return 8
        default:
            return 4
        }
    }
    class CustomDataEntry: HeatMapDataEntry {
        init(x: String, y: String, heat: Int, fill: String) {
            super.init(x: x, y: y, heat: heat)
            setValue(key: "fill", value: fill)
        }
    }
}
