//
//  ViewController.swift
//  VS2019
//
//  Created by Quân Đinh on 28.08.19.
//  Copyright © 2019 Quân Đinh. All rights reserved.
//

import UIKit
import SwiftCharts
import Charts

class ViewController: UIViewController {
    
    @IBOutlet weak var chartView: UIView!
    var chartPoints: Array<ChartPoint> = [ChartPoint]()
    var chartXLabels = [ChartAxisValue]()
    
    fileprivate var chart: Chart?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelDefaultSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont,
                                               fontColor: UIColor.black,
                                               rotation: 0,
                                               rotationKeep: ChartLabelDrawerRotationKeep.bottom,
                                               shiftXOnRotation: true,
                                               textAlignment: .default)
        
        var currentHorizontalPosition = 1
        var currentOrder = 0
        
        // add an empty point at 1st position
        chartPoints.append(ChartPoint(x: ChartAxisValueDouble(0),
                                      y: ChartAxisValueDouble(Double.greatestFiniteMagnitude)))
        chartXLabels.append(ChartAxisValueString("",
                                                 order: 0,
                                                 labelSettings: labelSettings.defaultVertical()))
        currentOrder += 1
        //----------------------------------
        
        for obj in Static.calories {
            chartPoints.append(ChartPoint(x: ChartAxisValueDouble(currentHorizontalPosition),
                                          y: ChartAxisValueDouble(obj.calories)))
            currentHorizontalPosition += 1
            print(obj.name)
            chartXLabels.append(ChartAxisValueString(obj.name.components(separatedBy: ",")[0],
                                                     order: currentOrder,
                                                     labelSettings: labelSettings.defaultVertical()))
            currentOrder += 1
        }
        
        // add an empty point at last position
        chartPoints.append(ChartPoint(x: ChartAxisValueDouble(currentHorizontalPosition),
                                      y: ChartAxisValueDouble(Double.greatestFiniteMagnitude)))
        chartXLabels.append(ChartAxisValueString("",
                                                 order: currentOrder,
                                                 labelSettings: labelSettings.defaultVertical()))
        //-----------------------------------
        
        let generator = ChartAxisGeneratorMultiplier(20)
        let labelsGenerator = ChartAxisLabelsGeneratorFunc {scalar in
            return ChartAxisLabel(text: "\(scalar)", settings: labelSettings)
        }
        
        let yModel = ChartAxisModel(firstModelValue: 0,
                                    lastModelValue: 220,
                                    axisTitleLabels: [ChartAxisLabel(text: "Calories",
                                                                     settings: labelDefaultSettings.defaultVertical())],
                                    axisValuesGenerator: generator,
                                    labelsGenerator: labelsGenerator)
        
        let xxModel = ChartAxisModel(axisValues: chartXLabels)
        
        let chartFrame = ExamplesDefaults.chartFrame(chartView.frame)
        
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom
        
        // generate axes layers and calculate chart inner frame, based on the axis models
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings,
                                                               chartFrame: chartFrame,
                                                               xModel: xxModel,
                                                               yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        // create layer with guidelines
        let guidelinesLayerSettings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer,
                                                         yAxisLayer: yAxisLayer,
                                                         settings: guidelinesLayerSettings)
        
        // view generator - this is a function that creates a view for each chartpoint
        let viewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsViewsLayer, chart: Chart) -> UIView? in
            let viewSize: CGFloat = Env.iPad ? 100 : 100
            let center = chartPointModel.screenLoc
            let pointView = PieChartView(frame: CGRect(x: center.x - viewSize / 2,
                                                       y: center.y - viewSize / 2,
                                                       width: viewSize,
                                                       height: viewSize))
            pointView.legend.enabled = false
            let position = Int(chartPointModel.chartPoint.description.components(separatedBy: ",")[0])!
            if (position != 0 && position != self.chartXLabels.count - 1){
                let objs = Static.calories
                let foodObj = objs[position - 1]
                let caloriesFromFat = PieChartDataEntry(value: foodObj.caloriesFromFat)
                let totalFat = PieChartDataEntry(value: foodObj.totalFat)
                let sodium = PieChartDataEntry(value: foodObj.Sodium)
                if (foodObj.caloriesFromFat == 0 && foodObj.totalFat == 0 && foodObj.Sodium == 0) {
                    pointView.holeColor = NSUIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
                    pointView.noDataTextColor = NSUIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
                    return pointView
                }
                let data = [caloriesFromFat, totalFat, sodium]
                let dataSet = PieChartDataSet(entries: data, label: nil)
                let chartData = PieChartData(dataSet: dataSet)
                chartData.setValueTextColor(NSUIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0))
                let colors = [UIColor.red, UIColor.green, UIColor.blue]
                dataSet.colors = colors
                
                pointView.data = chartData
            }
            return pointView
            
        }
        
        // create layer that uses viewGenerator to display chartpoints
        let chartPointsLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis,
                                                     yAxis: yAxisLayer.axis,
                                                     chartPoints: chartPoints,
                                                     viewGenerator: viewGenerator,
                                                     mode: .translate)
        
        // create chart instance with frame and layers
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartPointsLayer
            ]
        )
        
        chartView.addSubview(chart.view)
        self.chart = chart
    }
    
}

