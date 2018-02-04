//
//  ViewController.swift
//  SQLiteTest3
//
//  Created by jansen_fan on 2018/1/29.
//  Copyright © 2018年 jansen_fan. All rights reserved.
//

import UIKit
import Charts
import SQLite
class ViewController: UIViewController {
    @IBOutlet weak var dateNew: UITextField!
    @IBOutlet weak var priceNew: UITextField!
    
    let path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    let priceTable=Table("SSE_PE")
    let id = Expression<Int64>("id")
    let date = Expression<String>("date")
    let price = Expression<String>("price")
    
    struct pe:Codable {
        var Date:String
        var SSE:String
    }
    @IBAction func insertItem(_ sender: Any) {
        let db=try?Connection("\(path)/db.sqlite3")
        let insert=priceTable.insert(date <- "\(dateNew.text!)", price <- "\(priceNew.text!)")
        let rowid=(try!db?.run(insert))
        print(rowid)
    }
    @IBAction func showAll(_ sender: Any) {
        let db=try?Connection("\(path)/db.sqlite3")
        
        for item in (try! db?.prepare(priceTable))!
            {print("Query:id:\(item[id]),date:\(item[date]),price:\(item[price])")}

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let db=try?Connection("\(path)/db.sqlite3")
        try!db?.run(priceTable.create(temporary: false, ifNotExists: true, block: {(table) in
            table.column(id, primaryKey: true)
            table.column(date)
            table.column(price)
        }))
        
        
        let path1:String=Bundle.main.path(forResource: "PE_SSE", ofType: "json")!
        let url1=URL.init(fileURLWithPath: path1)
        guard  let jsonData:Data=try?Data(contentsOf:url1) else {
            print("1")
            return
        }
        guard let json=try?JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)else{
            print("2")
            return
        }
        let a=json as! [AnyObject]
        
        
        for i in a{
            let date1=i.value(forKey: "Date") as! String
            let pe1=i.value(forKey: "SSE") as! String
            
            let insert=priceTable.insert(date <- "\(date1)", price <- "\(pe1)")
            let rowid=(try!db?.run(insert))
        }
        
        for item in (try! db?.prepare(priceTable))!
        {print("Query:id:\(item[id]),date:\(item[date]),price:\(item[price])")}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

