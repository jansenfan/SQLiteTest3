//
//  peNetworkView.swift
//  SQLiteTest3
//
//  Created by jansen_fan on 2018/2/1.
//  Copyright © 2018年 jansen_fan. All rights reserved.
//

import UIKit
import AFNetworking
import Alamofire
import SwiftyJSON
class peNetworkView:UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var titles=[String]()
    var authors=[String]()
    var urls=[String]()
    var refreshControl=UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testAlamoTopNews()
        //testAlamoSinaNews()
        tableView.refreshControl=self.refreshControl
        self.refreshControl.addTarget(self, action:#selector(refreshTopNews), for:.valueChanged)
        refreshControl.attributedTitle=NSAttributedString(string: "松开后刷新")
        tableView.addSubview(refreshControl)
        
        print(titles)
        tableView.delegate=self
        tableView.dataSource=self
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func refreshTopNews(){
        testAlamoTopNews()
        refreshControl.endRefreshing()
    }
    func testAlamoTopNews()->Void{
        titles=[]
        urls=[]
        authors=[]
        Alamofire.request("https://v.juhe.cn/toutiao/index?type=caijing&key=f624b40b0aacd80d2ed748a136d2cec4").responseJSON{response in
            let j=response.result.value
            let jsonDict=JSON(j)
            let temp=jsonDict["result"]["data"]
            print(temp)
            //print(temp.count)
            for i in 0..<temp.count{
                let titleTemp=temp[i]["title"]
                //print(titleTemp.stringValue)
                self.titles.append(titleTemp.stringValue)
                let authorTemp=temp[i]["author_name"]
                //print(authorTemp.stringValue)
                self.authors.append(authorTemp.stringValue)
                let urlTemp=temp[i]["url"]
                //print(urlTemp.stringValue)
                self.urls.append(urlTemp.stringValue)
            }
            //print(self.authors)
            self.tableView.reloadData()
        }
    }
    
    /*
    func testAlamoSinaNews()->Void{
        titles=[]
        urls=[]
        authors=[]
        Alamofire.request("http://roll.news.sina.com.cn/interface/rollnews_ch_out_interface.php").responseString{response in
            let strTemp=response.result.value
            //print(response.result.value)
            let dataTemp=strTemp?.data(using: String.Encoding.utf8)
            print(dataTemp?)
            guard let json2=try? JSONSerialization.jsonObject(with: dataTemp!, options: .allowFragments)else{print("2");return}
            print(json2)
            
            let jsonDict=JSON(json2)
            print(jsonDict)
            let temp=jsonDict["list"]
            print(temp)
            //print(temp.count)
            for i in 0..<temp.count{
                let titleTemp=temp[i]["title"]
                //print(titleTemp.stringValue)
                self.titles.append(titleTemp.stringValue)
                let authorTemp=temp[i]["time"]
                //print(authorTemp.stringValue)
                self.authors.append(authorTemp.stringValue)
                let urlTemp=temp[i]["url"]
                //print(urlTemp.stringValue)
                self.urls.append(urlTemp.stringValue)
            }
            //print(self.authors)
            self.tableView.reloadData()
        }
    }
    
    */
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        print(titles.count)
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let item=self.tableView.dequeueReusableCell(withIdentifier: "webCell")
        (item!.contentView.viewWithTag(201) as! UILabel).text=titles[indexPath.row]
        (item!.contentView.viewWithTag(202) as! UILabel).text=authors[indexPath.row]
        return item!
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="toBrowser"{
            var bV=segue.destination as! peBrowserView
            var indexPath=tableView.indexPathForSelectedRow
            if let index=indexPath{
                bV.url=urls[index.row]
            }
        }
    }
    
    
    
    
}

