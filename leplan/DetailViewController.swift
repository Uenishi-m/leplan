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
    private var homeButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated:false)
        self.navigationController!.navigationBar.tintColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
        
        self.view.backgroundColor = UIColor(red:248/255, green: 248/255, blue: 248/255, alpha: 1)
        
        //homebuttonの設定
        homeButton=UIButton()
        homeButton.frame=CGRect(x: Int(self.view.bounds.width)-30-70, y: Int(self.view.bounds.height)-30-70, width:70, height: 70)
        homeButton.setTitle("home", for: .normal)
        homeButton.addTarget(self, action: #selector(clickHomeButton), for: .touchDown)
        homeButton.backgroundColor=UIColor.gray
        self.view.addSubview(homeButton)
        
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
        if spots.count == records.count + 1{
            
        
        for i in 0..<spots.count{
            
            //観光地の名前
            let spotLabel=UILabel(frame: CGRect(x: 30, y: y, width: Int(self.view.bounds.width), height: 50))
            spotLabel.text=spots[i]["name"] as? String
            spotLabel.backgroundColor=UIColor(red:248/255, green: 248/255, blue: 248/255, alpha: 1)
            spotLabel.textColor=UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
            //self.view.backgroundColor = UIColor.cyan
            spotLabel.font = UIFont(name: "Avenir", size: 20.0)
            spotLabel.textAlignment=NSTextAlignment.left
            self.view.addSubview(spotLabel)
            y=y+100
            //経路の方が１つ少ないのでここでブレイク
            if i==spots.count-1{
                break
            }
            
            //経路、それに伴う詳細の表示
            let timeLabel=UILabel(frame: CGRect(x:50,y:Y,width: Int(self.view.bounds.width), height: 50))
        
            if (records_fin[i]["time"]! as! Int) < 60{
                timeLabel.text="↓  \(records_fin[i]["way"]!)km  所要時間\(records_fin[i]["time"]!)分"
            }else{
                timeLabel.text="↓  \(records_fin[i]["way"]!)km  所要時間\((records_fin[i]["time"]! as! Int)/60)時間\((records_fin[i]["time"]! as! Int)%60)分"
            }
            
            
            timeLabel.font = UIFont(name: "Avenir", size: 20.0)
            timeLabel.backgroundColor=UIColor(red:248/255, green: 248/255, blue: 248/255, alpha: 1)
            timeLabel.textColor=UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
            timeLabel.textAlignment=NSTextAlignment.left
            self.view.addSubview(timeLabel)
            Y=Y+100
            
            }
        }else{
            let alertlabel = UILabel(frame: CGRect(x: 30, y: y, width: Int(self.view.bounds.width), height: 50))
            alertlabel.text = "経路を取得できませんでした"
            alertlabel.backgroundColor=UIColor(red:248/255, green: 248/255, blue: 248/255, alpha: 1)
            alertlabel.textColor=UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
            //self.view.backgroundColor = UIColor.cyan
            alertlabel.font = UIFont(name: "Avenir", size: 20.0)
            alertlabel.textAlignment=NSTextAlignment.left
            self.view.addSubview(alertlabel)

        }
    }
    
    @objc func clickHomeButton(sender:UIButton){
        let count = (self.navigationController?.viewControllers.count)! - 3
               
               if let previousViewController = self.navigationController?.viewControllers[count] as? HokkaidoViewController {
                   print("fromhokkaido")
                   previousViewController.spots = [[String:Any]]()
                   previousViewController.choosenindexpath = []
                   // viewControlllerAの処理
               }
               if let previousViewController = self.navigationController?.viewControllers[count] as? MiyagiViewController {
                   previousViewController.spots = [[String:Any]]()
                   previousViewController.choosenindexpath = []
                   // viewControlllerAの処理
               }
                if let previousViewController = self.navigationController?.viewControllers[count] as? MiyagiViewController {
                    previousViewController.spots = [[String:Any]]()
                    previousViewController.choosenindexpath = []
                    // viewControlllerAの処理
                }
        if let previousViewController = self.navigationController?.viewControllers[count] as? AomoriViewController {
                    previousViewController.spots = [[String:Any]]()
                    previousViewController.choosenindexpath = []
                    // viewControlllerAの処理
                }
        if let previousViewController = self.navigationController?.viewControllers[count] as? AkitaViewController {
                    previousViewController.spots = [[String:Any]]()
                    previousViewController.choosenindexpath = []
                    // viewControlllerAの処理
                }
        if let previousViewController = self.navigationController?.viewControllers[count] as? YamagataViewController {
                    previousViewController.spots = [[String:Any]]()
                    previousViewController.choosenindexpath = []
                    // viewControlllerAの処理
                }
        if let previousViewController = self.navigationController?.viewControllers[count] as? FukushimaViewController {
                    previousViewController.spots = [[String:Any]]()
                    previousViewController.choosenindexpath = []
                    // viewControlllerAの処理
                }
        if let previousViewController = self.navigationController?.viewControllers[count] as? IwateViewController {
                    previousViewController.spots = [[String:Any]]()
                    previousViewController.choosenindexpath = []
                    // viewControlllerAの処理
                }
        if let previousViewController = self.navigationController?.viewControllers[count] as? IbaragiViewController {
                    previousViewController.spots = [[String:Any]]()
                    previousViewController.choosenindexpath = []
                    // viewControlllerAの処理
                }
        if let previousViewController = self.navigationController?.viewControllers[count] as? GunmaViewController {
                    previousViewController.spots = [[String:Any]]()
                    previousViewController.choosenindexpath = []
                    // viewControlllerAの処理
                }
        if let previousViewController = self.navigationController?.viewControllers[count] as? SaitamaViewController {
                    previousViewController.spots = [[String:Any]]()
                    previousViewController.choosenindexpath = []
                    // viewControlllerAの処理
                }
        if let previousViewController = self.navigationController?.viewControllers[count] as? ChibaViewController {
                    previousViewController.spots = [[String:Any]]()
                    previousViewController.choosenindexpath = []
                    // viewControlllerAの処理
                }
        if let previousViewController = self.navigationController?.viewControllers[count] as? TokyoViewController {
                    previousViewController.spots = [[String:Any]]()
                    previousViewController.choosenindexpath = []
                    // viewControlllerAの処理
                }
        if let previousViewController = self.navigationController?.viewControllers[count] as? KanagawaViewController {
                    previousViewController.spots = [[String:Any]]()
                    previousViewController.choosenindexpath = []
                    // viewControlllerAの処理
                }
        if let previousViewController = self.navigationController?.viewControllers[count] as? NiigataViewController {
                    previousViewController.spots = [[String:Any]]()
                    previousViewController.choosenindexpath = []
                    // viewControlllerAの処理
                }
        if let previousViewController = self.navigationController?.viewControllers[count] as? ToyamaViewController {
                    previousViewController.spots = [[String:Any]]()
                    previousViewController.choosenindexpath = []
                    // viewControlllerAの処理
                }
        if let previousViewController = self.navigationController?.viewControllers[count] as? IshikawaViewController {
                    previousViewController.spots = [[String:Any]]()
                    previousViewController.choosenindexpath = []
                    // viewControlllerAの処理
                }
        if let previousViewController = self.navigationController?.viewControllers[count] as? FukuiViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? YamanashiViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? NaganoViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? GifuViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? ShizuokaViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? AichiViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? OsakaViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? KyotoViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? HyogoViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? NaraViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? MieViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? ShigaViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? WakayamaViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? ShimaneViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? TtotoriViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? OkayamaViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? HiroshimaViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? YamaguchiViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? KagawaViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? TokushimaViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? EhimeViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? FukuokaViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? SagaViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? NagasakiViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? KumamotoViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? OitaViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? MiyazakiViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? KagoshimaViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        if let previousViewController = self.navigationController?.viewControllers[count] as? OkinawaViewController {
            previousViewController.spots = [[String:Any]]()
            previousViewController.choosenindexpath = []
            // viewControlllerAの処理
        }
        
        
        
        
        performSegue(withIdentifier: "detailToHome", sender: nil)
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
            print("保存したい配列\(self.spots)")
            //self.list.updateValue(title, forKey: "title")
            //self.list.updateValue(self.spots, forKey: "spots")
            print(self.list)
            
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
