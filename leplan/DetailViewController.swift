//
//  DetailViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/05/07.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var spots=[[String:Any]]()
    var records=[[String:Any]]()
    var records_fin=[[String:Any]]()
    var list=[String:Any]()
    var keys=[String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("list\(spots)")
        print(records)
        
        for i in 0..<records.count{
            for j in 0..<records.count{
                if(i==records[j]["start"] as! Int){
                    records_fin.append(records[j])
                }
            }
        }
        print("うまくいってて！\(records_fin)")
        var y:Int=100
        var Y:Int=150
        // Do any additional setup after loading the view.
        for i in 0..<spots.count{
            
            //観光地の名前
            let spotLabel=UILabel(frame: CGRect(x: 30, y: y, width: Int(self.view.bounds.width), height: 50))
            spotLabel.text=spots[i]["name"] as? String
            spotLabel.backgroundColor=UIColor.white
            spotLabel.textColor=UIColor.black
            //self.view.backgroundColor = UIColor.cyan
            spotLabel.textAlignment=NSTextAlignment.left
            self.view.addSubview(spotLabel)
            y=y+100
            //経路の方が１つ少ないのでここでブレイク
            if i==spots.count-1{
                break
            }
            
            //経路、それに伴う詳細の表示
            let timeLabel=UILabel(frame: CGRect(x:50,y:Y,width: Int(self.view.bounds.width), height: 50))
            timeLabel.text="↓  \(records_fin[i]["way"]!)km  徒歩で\(records_fin[i]["time"]!)分"
            timeLabel.backgroundColor=UIColor.white
            timeLabel.textColor=UIColor.black
            timeLabel.textAlignment=NSTextAlignment.left
            self.view.addSubview(timeLabel)
            Y=Y+100
            
        }
    }
    
    @IBAction func AddRouteAction(_ sender: Any) {
        
        //let useDefaults = UserDefaults.standard
        let myalert = UIAlertController(title: "ルートを保存", message: "タイトルを入力してください", preferredStyle: .alert)
        var alertTextField = UITextField()
        var title = ""
        
        let OKAction = UIAlertAction(title: "OK", style: .default){action in
            print("OK!")
            title = alertTextField.text!
            print(title)
            //print("保存したい配列\(self.spots)")
            //self.list.updateValue(title, forKey: "title")
            //self.list.updateValue(self.spots, forKey: "spots")
            //print(self.list)
            
            //データの保存
            print(type(of: self.spots))
            let defaults = UserDefaults.standard
            defaults.set(self.spots,forKey: title)
            //defaults.set(self.list,forKey: title)
            //defaults.synchronize()
            //キーの保存
            let defaults_key = UserDefaults.standard
            //self.keys=["2日目","1日目"]
            //self.keys.append(title)
            if let keys : [String] = defaults_key.stringArray(forKey: "keys"){
                self.keys=keys
                print(self.keys)
                self.keys.append(title)
                print(self.keys)
            }
            defaults_key.set(self.keys,forKey: "keys")
            
        }
        let CalcelAction = UIAlertAction(title: "キャンセル", style: .cancel){action in
            print("cancel")
        }
       
        myalert.addAction(OKAction)
        myalert.addAction(CalcelAction)
        myalert.addTextField(configurationHandler:{(textField:UITextField!) in
            textField.placeholder = "タイトル"
            alertTextField=textField
        })
        
       present(myalert,animated: true,completion: nil)
        
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
