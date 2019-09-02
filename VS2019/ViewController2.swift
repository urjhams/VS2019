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
    override func viewDidLoad() {
        super.viewDidLoad()
        let chart = AnyChart.heatMap()
        chart.labels()
            .minFontSize(size: 14)
            .format(token: "function() { var namesList = [\"Low\", \"Medium\", \"High\", \"Extreme\"]; var h = this. heat; if (h == 5) {return '';} return namesList[this.heat]; }")
        let data: Array<DataEntry> = [
            HeatMapDataEntry(x: "Food 1", y: "Strong", heat: 5),
            HeatMapDataEntry(x: "Food 2", y: "Strong", heat: 5),
            HeatMapDataEntry(x: "Food 3", y: "Strong", heat: 5),
            HeatMapDataEntry(x: "Food 1", y: "Good", heat: 4),
            HeatMapDataEntry(x: "Food 2", y: "Good", heat: 4),
            HeatMapDataEntry(x: "Food 3", y: "Good", heat: 4),
            HeatMapDataEntry(x: "Food 1", y: "Promising", heat: 3),
            HeatMapDataEntry(x: "Food 2", y: "Promising", heat: 3),
            HeatMapDataEntry(x: "Food 3", y: "Promising", heat: 3),
            HeatMapDataEntry(x: "Food 1", y: "Conflicting", heat: 2),
            HeatMapDataEntry(x: "Food 2", y: "Conflicting", heat: 2),
            HeatMapDataEntry(x: "Food 3", y: "Conflicting", heat: 2),
            HeatMapDataEntry(x: "Food 1", y: "Slight", heat: 1),
            HeatMapDataEntry(x: "Food 2", y: "Slight", heat: 1),
            HeatMapDataEntry(x: "Food 3", y: "Slight", heat: 1),
            HeatMapDataEntry(x: "Food 1", y: "No evidence", heat: 0),
            HeatMapDataEntry(x: "Food 2", y: "No evidence", heat: 0),
            HeatMapDataEntry(x: "Food 3", y: "No evidence", heat: 0),
        ]
        let _ = chart.data(data: data)
        
        //        let _ = chart.legend().enabled(enabled: false)
        //
        ////        chart.title(settings: "Fruits imported in 2015 (in kg)")
        //
        chartView.setChart(chart: chart)
        
    }
    
    
}
