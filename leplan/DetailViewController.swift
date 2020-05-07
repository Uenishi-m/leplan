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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(spots)
        print(records)
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
            timeLabel.text="↓  \(records[i]["way"]!)km  徒歩で\(records[i]["time"]!)分"
            timeLabel.backgroundColor=UIColor.white
            timeLabel.textColor=UIColor.black
            timeLabel.textAlignment=NSTextAlignment.left
            self.view.addSubview(timeLabel)
            Y=Y+100
            
        }
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
