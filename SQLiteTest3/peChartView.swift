//
//  lineChartView.swift
//  SQLiteTest3
//
//  Created by jansen_fan on 2018/1/31.
//  Copyright © 2018年 jansen_fan. All rights reserved.
//


import UIKit
import Charts
class peChartView: UIViewController,ChartViewDelegate{
    let path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    
    //确定使用的表名称
    let priceTable=Table("SSE_PE")
    
    let id = Expression<Int64>("id")
    let date = Expression<String>("date")
    let price = Expression<String>("price")
    
    
    var dateSet=[String]()
    var numSet=[Double]()
    
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var maxNum: UILabel!
    @IBOutlet weak var minNum: UILabel!
    @IBOutlet weak var medNum: UILabel!
    @IBOutlet weak var topNum: UILabel!
    @IBOutlet weak var botNum: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let db=try?Connection("\(path)/db.sqlite3")
        try!db?.run(priceTable.create(temporary: false, ifNotExists: true, block: {(table) in
            table.column(id, primaryKey: true)
            table.column(date)
            table.column(price)
        }))
        
        for item in (try! db?.prepare(priceTable))!{
            dateSet.append(item[date])
            //数据库数字列尾部有空格，删除后转换为Double
            let a=Double(item[price].trimmingCharacters(in: .whitespaces))
            numSet.append(a!)
            
            let tempList=numSet.sorted()
            let topIndex:Int=Int(0.8*Double(tempList.count))
            let botIndex:Int=Int(0.2*Double(tempList.count))
            let medIndex:Int=Int(0.5*Double(tempList.count))
            
            maxNum.text=String(format: "%.2f", numSet.max()!)
            minNum.text=String(format: "%.2f", numSet.min()!)
            topNum.text=String(format: "%.2f", tempList[topIndex])
            botNum.text=String(format: "%.2f", tempList[botIndex])
            medNum.text=String(format: "%.2f", tempList[medIndex])
            
            
        }
        //print(numSet)
        lineChartView.delegate=self
        setChart(days:dateSet,values:numSet)
        
    }
    func setChart(days:[String],values:[Double]){
        var dataEntries:[ChartDataEntry]=[]
        for i in 0..<days.count {
            let dataEntry=ChartDataEntry(x: Double(i), y: values[i])
            //let dataEntry2=
            dataEntries.append(dataEntry)
        }
        let chartDataSet2:LineChartDataSet=LineChartDataSet(values: dataEntries, label: "时间轴")
        chartDataSet2.setCircleColor(UIColor.red)
        chartDataSet2.circleRadius=1
        chartDataSet2.circleHoleColor=UIColor.red
        
        
        let chartData2:LineChartData=LineChartData(dataSets: [chartDataSet2])
        
        lineChartView.data=chartData2
        
        lineChartView.chartDescription?.text="PE视图"
        //设置X轴坐标值
        lineChartView.xAxis.valueFormatter=IndexAxisValueFormatter(values: days)
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.axisLineWidth=1.0
        lineChartView.xAxis.drawLabelsEnabled=true
        lineChartView.xAxis.drawGridLinesEnabled=false
        //设置Y轴坐标
        lineChartView.rightAxis.enabled=false
        lineChartView.leftAxis.axisLineWidth=1.0
        lineChartView.leftAxis.axisLineColor=UIColor.black
        lineChartView.scaleYEnabled=false
        
        lineChartView.backgroundColor=UIColor.gray
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

