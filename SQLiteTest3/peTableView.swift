//
//  peTableView.swift
//  SQLiteTest3
//
//  Created by jansen_fan on 2018/1/30.
//  Copyright © 2018年 jansen_fan. All rights reserved.
//

import UIKit
class peTableView:UIViewController,UITableViewDelegate,UITableViewDataSource{
    let path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    
    //确定使用的表名称
    let priceTable=Table("SSE_PE")
    
    let id = Expression<Int64>("id")
    let date = Expression<String>("date")
    let price = Expression<String>("price")
    
    
    var dateSet=[String]()
    var peSet=[String]()
    
    @IBOutlet weak var tableV: UITableView!
    
    
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
            peSet.append(item[price])
            
        }
        print(dateSet)
        print(peSet)
        
        tableV.dataSource=self
        tableV.delegate=self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dateSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let item=self.tableV.dequeueReusableCell(withIdentifier: "peCell")
        //var a:Optional="a"
        //var b:Optional="b"
        //a=dateSet[indexPath.row];b=peSet[indexPath.row]
       (item!.contentView.viewWithTag(101) as! UILabel).text=dateSet[indexPath.row]
       (item!.contentView.viewWithTag(102) as! UILabel).text=peSet[indexPath.row]
        return item!
    }
}

