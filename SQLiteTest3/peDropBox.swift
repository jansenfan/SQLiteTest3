//
//  peSelectorView.swift
//  SQLiteTest3
//
//  Created by jansen_fan on 2018/2/4.
//  Copyright © 2018年 jansen_fan. All rights reserved.
//

import UIKit
class peDropBox:UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    //@IBOutlet weak var indexLabel: UILabel!
    //@IBOutlet weak var normLabel: UILabel!
    @IBOutlet weak var indexTable: UITableView!
    @IBOutlet weak var normTable: UITableView!
    var indexButtonCount:Int=0
    var normButtonCount:Int=0
    let choices=["红利机会","500低波动","300价值","基本面60","基本面120","证券行业"]
    let normCho=["盈利收益率","市盈率","市净率","股息率","ROE"]
    //@IBOutlet weak var testLabel1: UILabel!
    //@IBOutlet weak var testLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indexTable.dataSource=self
        indexTable.delegate=self
        normTable.dataSource=self
        normTable.delegate=self
        
        indexTable.isHidden=true
        normTable.isHidden=true
        
        indexTable.rowHeight=UITableViewAutomaticDimension
        normTable.rowHeight=UITableViewAutomaticDimension
        
        indexTable.estimatedRowHeight=50
        normTable.estimatedRowHeight=50
        
        indexTable.sizeToFit()
        normTable.sizeToFit()
        //indexButton.layer.borderColor=UIColor.black as! CGColor
        indexButton.layer.borderWidth=1.0
        indexButton.layer.masksToBounds=true
        indexButton.layer.backgroundColor=UIColor.white.cgColor
        indexTable.separatorStyle=UITableViewCellSeparatorStyle.singleLine
        
        
        normButton.layer.borderWidth=1.0
        normButton.layer.masksToBounds=true
        normButton.layer.backgroundColor=UIColor.white.cgColor
        normTable.separatorStyle=UITableViewCellSeparatorStyle.singleLine
        
        
        
        self.view.backgroundColor=UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    }
    @IBOutlet weak var indexButton: UIButton!
    @IBAction func indexButton(_ sender: Any) {
        indexTable.isHidden=false
        
        
    }
    @IBOutlet weak var normButton: UIButton!
    @IBAction func normButton(_ sender: Any) {
        normTable.isHidden=false
    }
    @IBAction func checkButton(_ sender: Any) {
        if indexButtonCount==0||normButtonCount==0 {
            let alertCon=UIAlertController(title: "系统提醒", message: "未选择指数或指标", preferredStyle: .alert)
            let alertAction=UIAlertAction(title: "确定", style: .cancel, handler: nil)
            alertCon.addAction(alertAction)
            self.present(alertCon, animated: true, completion: nil)
        }
        print(indexButton.currentTitle)
        print(normButton.currentTitle)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView==indexTable{
            return choices.count
        }
        if tableView==normTable{
            return normCho.count
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if tableView==indexTable{
            let item=self.indexTable.dequeueReusableCell(withIdentifier: "indexCell")
            (item!.contentView.viewWithTag(501) as! UILabel).text=choices[indexPath.row]
            return item!
        }
        if tableView==normTable{
            let item=self.normTable.dequeueReusableCell(withIdentifier: "normCell")
            (item!.contentView.viewWithTag(502) as! UILabel).text=normCho[indexPath.row]
            return item!
        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if tableView==indexTable{
            indexTable.isHidden=true
            indexButton.setTitle("\(choices[indexPath.row])", for: .normal)
            indexButtonCount+=1
        }
        if tableView==normTable{
            normTable.isHidden=true
            normButton.setTitle("\(normCho[indexPath.row])", for: .normal)
            normButtonCount+=1
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
