//
//  ViewController1.swift
//  VS2019
//
//  Created by Quân Đinh on 30.08.19.
//  Copyright © 2019 Quân Đinh. All rights reserved.
//

import UIKit
import SwiftCharts

class ViewController1: UIViewController {
    
    @IBOutlet weak var legendCollectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    fileprivate var chart: Chart? // arc
    var legendDescription = [(String, UIColor)]()
    var calories = 25
    let dictArray = [
        ["Calories from Fat","caloriesFromFat"],
        ["Total Fat","totalFat"],
        ["Sodium","Sodium"],
        ["Potasium","potasium"],
        ["total Carbon-hydrate","totalCarboHydrate"],
        ["Sugar","sugars"],
        ["Protein","protein"],
        ["saturated Fat","saturatedFat"],
        ["Cholesterol","cholesterol"]
    ]
    
    fileprivate func chart(horizontal: Bool) -> Chart {
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        let alpha: CGFloat = 0.8

        let barModels = getModel()
        
        let (axisValues1, axisValues2) = (
            stride(from: 0, through: 1200, by: 50).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)},
            [ChartAxisValueString("", order: 0, labelSettings: labelSettings)] + barModels.map{$0.constant} + [ChartAxisValueString("", order: 10, labelSettings: labelSettings)]
        )
        let (xValues, yValues) = horizontal ? (axisValues1, axisValues2) : (axisValues2, axisValues1)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Amount of Nutritions", settings: labelSettings.defaultVertical()))
        
        let frame = ExamplesDefaults.chartFrame(containerView.bounds)
        let chartFrame = chart?.frame ?? CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
        
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let barViewSettings = ChartBarViewSettings(animDuration: 0.5)
        let chartStackedBarsLayer = ChartStackedBarsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, innerFrame: innerFrame, barModels: barModels, horizontal: horizontal, barWidth: 40, settings: barViewSettings, stackFrameSelectionViewUpdater: ChartViewSelectorAlpha(selectedAlpha: 1, deselectedAlpha: alpha)) {tappedBar in
            
            guard let stackFrameData = tappedBar.stackFrameData else {return}
            
            let chartViewPoint = tappedBar.layer.contentToGlobalCoordinates(CGPoint(x: tappedBar.barView.frame.midX, y: stackFrameData.stackedItemViewFrameRelativeToBarParent.minY))!
            let viewPoint = CGPoint(x: chartViewPoint.x, y: chartViewPoint.y + 70)
            let infoBubble = InfoBubble(point: viewPoint, preferredSize: CGSize(width: 50, height: 40), superview: self.view, text: "\(stackFrameData.stackedItemModel.quantity) g", font: ExamplesDefaults.labelFont, textColor: UIColor.white, bgColor: UIColor.black)
            infoBubble.tapHandler = {
                infoBubble.removeFromSuperview()
            }
            self.containerView.addSubview(infoBubble)
        }
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: settings)
        
        return Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartStackedBarsLayer
            ]
        )
    }
    
    fileprivate func showChart(horizontal: Bool) {
        self.chart?.clearView()
        
        let chart = self.chart(horizontal: horizontal)
        containerView.addSubview(chart.view)
        self.chart = chart
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showChart(horizontal: false)
        legendCollectionView.delegate = self
        legendCollectionView.dataSource = self
    }
    
    private func getModel() -> [ChartStackedBarModel] {
        var models = [ChartStackedBarModel]()
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        for i in 0..<dictArray.count {
            let stack = ChartStackedBarModel(constant: ChartAxisValueString(dictArray[i][0],
                                                                            order: i + 1,
                                                                            labelSettings: labelSettings),
                                             start: ChartAxisValueDouble(0),
                                             items: getStackedBar(name: dictArray[i][1],
                                                                  currentCalories: Double(self.calories)))
            models.append(stack)
        }
        return models
    }
    
    private func getStackedBar(name: String, currentCalories: Double) -> [ChartStackedBarItemModel] {
        var result = [ChartStackedBarItemModel]()
        var currentColorIndex = 0
        legendDescription = [(String, UIColor)]()
        for obj in Static.calories {
            var component = 0.0
            
            switch name {
            case "caloriesFromFat":
                component = obj.caloriesFromFat
            case "totalFat":
                component = obj.totalFat
            case "Sodium":
                component = obj.Sodium
            case "potasium":
                component = obj.potasium
            case "totalCarboHydrate":
                component = obj.totalCarboHydrate
            case "sugars":
                component = obj.sugars
            case "protein":
                component = obj.protein
            case "saturatedFat":
                component = obj.saturatedFat
            case "cholesterol":
                component = obj.cholesterol
            default:
                break
            }
            
            result.append(ChartStackedBarItemModel(quantity: (obj.calories == currentCalories) ? component : 0,
                                                   bgColor: Helper.colorArray[currentColorIndex]))
            currentColorIndex += 1
            if currentColorIndex == Helper.colorArray.count {
                currentColorIndex = 0
            }
            legendDescription.append((obj.name, Helper.colorArray[currentColorIndex]))
            legendCollectionView.reloadData()
        }
        return result
    }
}

extension ViewController1: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return legendDescription.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "legnedCell", for: indexPath) as! LegendCollectionViewCell
        cell.colorImg.backgroundColor = legendDescription[indexPath.item].1
        cell.nameText.text = legendDescription[indexPath.item].0
        return cell
    }
    
    
}
