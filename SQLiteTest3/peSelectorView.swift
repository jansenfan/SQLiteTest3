//
//  peSelectorView.swift
//  SQLiteTest3
//
//  Created by jansen_fan on 2018/2/4.
//  Copyright © 2018年 jansen_fan. All rights reserved.
//

import UIKit
var selectedNum1:Int?
var selectedNum2:Int?
class peSelectorView:UIViewController,UITableViewDataSource,UITableViewDelegate{
    var str=["第1列","第2列","第3列","第4列"]
    
    @IBOutlet weak var buttonLabel: UIButton!
    
    @IBOutlet weak var testTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        testTable.isHidden=true
        testTable.dataSource=self
        testTable.delegate=self
        
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor=UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        let defaultTitle="指数选择"
        let defaultTitle2="指标选择"
        
        let choices=["红利机会","500低波动","300价值","基本面60","基本面120","证券行业"]
        let normCho=["盈利收益率","市盈率","市净率","股息率","ROE"]
        let rectLabel1=CGRect(x: 25, y: 100, width: 50, height: 50)
        let rectLabel2=CGRect(x: 25, y: 200, width: 50, height: 50)
        
        let rect=CGRect(x: 75, y: 100, width: self.view.bounds.width-100, height: 50)
        let rect2=CGRect(x: 75, y: 200, width: self.view.bounds.width-100, height: 50)
        
        let labelView1=UILabel(frame: rectLabel1)
        let labelView2=UILabel(frame: rectLabel2)
        labelView1.text="指数"
        labelView2.text="指标"
        
        let dropBoxView=TGDropBoxView(parentVC: self, title: defaultTitle, items: choices, frame: rect)
        let dropBoxView2=TGDropBoxView(parentVC: self, title: defaultTitle2, items: normCho, frame: rect2)
        dropBoxView.isHightWhenShowList = true
        dropBoxView2.isHightWhenShowList = true
        
        dropBoxView.willShowOrHideBoxListHandler = { (isShow) in
            if isShow { NSLog("will show choices") }
            else { NSLog("will hide choices") }
        }
        dropBoxView.didShowOrHideBoxListHandler = { (isShow) in
            if isShow { NSLog("did show choices") }
            else { NSLog("did hide choices") }
        }
        dropBoxView.didSelectBoxItemHandler = { (row) in
            NSLog("selected No.\(row): \(dropBoxView.currentTitle())")
            selectedNum1=row
        }
        dropBoxView2.didSelectBoxItemHandler = { (row) in
            NSLog("selected No.\(row): \(dropBoxView.currentTitle())")
            selectedNum2=row
        }
        self.view.addSubview(dropBoxView)
        self.view.addSubview(labelView1)
        self.view.addSubview(dropBoxView2)
        self.view.addSubview(labelView2)
    }
    
    @IBAction func checkSelection(_ sender: Any) {
        
        print(selectedNum1)
        print(selectedNum2)
        if selectedNum1==nil||selectedNum2==nil {
            let alertCon=UIAlertController(title: "系统提醒", message: "未选择指数或指标", preferredStyle: .alert)
            let alertAction=UIAlertAction(title: "确定", style: .cancel, handler: nil)
            alertCon.addAction(alertAction)
            self.present(alertCon, animated: true, completion: nil)
        }
    }
    
    @IBAction func tableButton(_ sender: Any) {
        let recTable=CGRect(x: 10, y: 400, width: 200, height: 500)
        let tableView=UITableView(frame: recTable)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        buttonLabel.setTitle("候选列表", for: .normal)
        testTable.isHidden=false
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return str.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let item=self.testTable.dequeueReusableCell(withIdentifier: "cell")
        (item!.contentView.viewWithTag(401) as! UILabel).text=str[indexPath.row]
        return item!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        testTable.isHidden=true
        buttonLabel.setTitle("\(str[indexPath.row])", for: .normal)
    }
}
