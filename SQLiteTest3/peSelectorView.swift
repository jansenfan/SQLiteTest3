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
class peSelectorView:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor=UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        let defaultTitle="这是一个下拉框，请选择"
        let choices=["第1选项","第2选项","第3选项","第4选项"]
        let rectLabel1=CGRect(x: 10, y: 100, width: 80, height: 50)
        let rectLabel2=CGRect(x: 10, y: 200, width: 80, height: 50)
        
        let rect=CGRect(x: 100, y: 100, width: self.view.bounds.width-200, height: 50)
        let rect2=CGRect(x: 100, y: 200, width: self.view.bounds.width-200, height: 50)
        
        let labelView1=UILabel(frame: rectLabel1)
        let labelView2=UILabel(frame: rectLabel2)
        labelView1.text="选项1"
        labelView2.text="选项2"
        
        let dropBoxView=TGDropBoxView(parentVC: self, title: defaultTitle, items: choices, frame: rect)
        let dropBoxView2=TGDropBoxView(parentVC: self, title: defaultTitle, items: choices, frame: rect2)
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
