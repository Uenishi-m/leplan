//
//  GunmaViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/05/30.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//

import UIKit

class GunmaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate {

 private var myTableView:UITableView!
    
    var regionlist = ["前橋・桐生","高崎・藤岡","伊勢崎・太田","利根・沼田","吾妻"]
    var listfir = [["name":"赤城山","latitude":36.5390206 ,"longitude":139.1314954],
    ["name":"ぐんまフラワーパーク","latitude":36.4559017,"longitude":139.1737067],
    ["name":"桐生織物参考館「紫」","latitude":36.455906,"longitude":139.1737121],["name":"ぐんま昆虫の森","latitude":36.436143,"longitude":139.2488478],["name":"伊香保温泉  石段街","latitude":36.4973258,"longitude":138.9141222],["name":"水澤寺","latitude":36.4796092,"longitude":138.9435295]]
    var listsec = [["name":"榛名山","latitude":36.4769563,"longitude":138.8434211],["name":"榛名神社","latitude":36.456413,"longitude":138.8469203],["name":"少林山達磨寺","latitude":36.3292435,"longitude":138.9555284],["name":"富岡製糸場","latitude":36.255121,"longitude":138.8852388],["name":"碓氷第三橋梁","latitude":36.3580585,"longitude":138.6960949],["name":"妙義山","latitude":36.2985957,"longitude":138.7139427]]
    var listthird = [["name":"つつじが岡公園","latitude":36.2421725,"longitude":139.5520638],["name":"茂林寺","latitude":36.2421674,"longitude":139.5193131],["name":"ジャパンスネークセンター","latitude":36.3623752,"longitude":139.3200464],["name":"新田荘遺跡","latitude":36.2964833,"longitude":139.2798193],["name":"富弘美術館","latitude":36.553565,"longitude":139.3708763]]
    var listforth = [["name":"尾瀬ヶ原","latitude":36.9486241,"longitude":139.141694],["name":"吹割の滝","latitude":36.7021954,"longitude":139.205184],["name":"たんばらラベンダーパーク","latitude":36.7785383,"longitude":139.0706334],["name":" 水上温泉","latitude":36.7726921,"longitude":138.8600831],["name":"谷川岳","latitude":36.8345878,"longitude":138.8952204]]
    var listfifth = [["name":"大理石村・ロックハート城","latitude":36.6310702,"longitude":138.986175],["name":"四万温泉","latitude":36.6806375,"longitude":138.7706407],["name":"鬼押出し園","latitude":36.4448257,"longitude":138.5348812],["name":"愛妻の丘","latitude":36.5055108,"longitude":138.456774],["name":"草津温泉","latitude":36.6228353,"longitude":138.5945222],["name":"草津白根山","latitude":36.6199944,"longitude":138.500066]]
    var label:[Bool] = []
    var listlist:[Int:[[String:Any]]] = [:]
    var choosenlable:[Bool] = []
    var spots = [[String:Any]]()
    var start = [String:Any]()
    var choosenindexpath = [IndexPath]()
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("miyagistart\(start)")
        print("miyagispots\(spots)")
        
        listlist = [0:listfir,1:listsec,2:listthird,3:listforth,4:listfifth]
        
        for i in 0..<regionlist.count{
            label.append(false)
        }
       
         self.view.backgroundColor=UIColor(red:248/255, green: 248/255, blue: 248/255, alpha: 1)
       
       self.navigationController!.navigationBar.tintColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
        // Do any additional setup after loading the view.
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        

              // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView()

              // TableViewの生成( status barの高さ分ずらして表示 ).
        myTableView.frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight)
        
        myTableView.isScrollEnabled = true

              // Cell名の登録をおこなう.
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")

              // DataSourceの設定をする.
        myTableView.dataSource = self

              // Delegateを設定する.
        myTableView.delegate = self
        
        myTableView.allowsMultipleSelection = true

              // Viewに追加する.
        self.view.addSubview(myTableView)
       
       navigationController?.delegate = self
    }
   
   func navigationController(_ navigationController:UINavigationController,willShow viewController : UIViewController,animated:Bool){
       if let controller = viewController as? PrefectureViewController{
           controller.spots = spots
           spots = [[String:Any]]()
           controller.gunmaChoosenindexpath = choosenindexpath
         choosenindexpath = []
       }
   }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return regionlist.count
    }
       
    func tableView(_ tableView:UITableView,titleForHeaderInSection section:Int) -> String?{
        return regionlist[section]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section:Int) ->UIView?{
           let view = UITableViewHeaderFooterView()
           let gesture = UITapGestureRecognizer(target: self, action: #selector(sectionHeaderDidTap(_:)))
           view.addGestureRecognizer(gesture)
           view.tag = section
           return view
    }
    
    var validsections:[Int] = []
    
    @objc func sectionHeaderDidTap(_ sender: UIGestureRecognizer) {
           validsections = []
           if let section = sender.view?.tag {
               //print(section)
               if label[section] == false{
                   label[section] = true
               }else if label[section] == true{
                   label[section] = false
               }
               //print(label)
           }
          
           for i in 0..<label.count{
               if label[i] == true{
                   validsections.append(i)
               }
           }
           //print("validsections\(validsections)")
           myTableView.reloadData()
       }
    
    func tableView(_ tableView :UITableView, didSelectRowAt indexPath:IndexPath){
        print(indexPath.section)
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        choosenindexpath.append(indexPath)
        print(choosenindexpath)
        print(listlist[indexPath.section]![indexPath.row])
        spots.append(listlist[indexPath.section]![indexPath.row])
        print("spots\(spots)")
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
        var index:Int = 0
        for i in 0..<spots.count{
            if spots[i]["name"] as! String == listlist[indexPath.section]![indexPath.row]["name"] as! String{
                 index = i
            }
        }
        //print("index\(index)")
        spots.remove(at: index)
        print("miyagispots\(spots)")
       var deleteindexpath = choosenindexpath.firstIndex(of: indexPath)
       choosenindexpath.remove(at:deleteindexpath!)
       print(choosenindexpath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 && validsections.contains(section){
            return listfir.count
        }else if section == 1  && validsections.contains(section){
            return listsec.count
        }else if section == 2  && validsections.contains(section){
            return listthird.count
        }else if section == 3  && validsections.contains(section){
            return listforth.count
        }else if section == 4  && validsections.contains(section){
            return listfifth.count
        }else{
            return 0
        }
        
    }
       
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell",for:indexPath)
       if choosenindexpath.contains(indexPath){
           cell.accessoryType = .checkmark
           myTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
       }else{
           cell.accessoryType = .none
       }
        
        if indexPath.section == 0  && validsections.contains(indexPath.section){
            cell.textLabel?.text = listfir[indexPath.row]["name"] as? String
        }else if indexPath.section == 1 && validsections.contains(indexPath.section){
            cell.textLabel?.text = listsec[indexPath.row]["name"] as? String
        }else if indexPath.section == 2 && validsections.contains(indexPath.section){
            cell.textLabel?.text = listthird[indexPath.row]["name"] as? String
        }else if indexPath.section == 3 && validsections.contains(indexPath.section){
            cell.textLabel?.text = listforth[indexPath.row]["name"] as? String
        }else if indexPath.section == 4 && validsections.contains(indexPath.section){
            cell.textLabel?.text = listfifth[indexPath.row]["name"] as? String
        }
       
        cell.backgroundColor=UIColor(red:248/255, green: 248/255, blue: 248/255, alpha: 1)
        cell.textLabel!.font = UIFont(name: "Avenir", size: 20.0)
        cell.textLabel!.textColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
        
        return cell
    }
    @IBAction func toMap(_ sender: Any) {
            performSegue(withIdentifier: "GunmatoMap", sender: nil)
                choosenindexpath = [IndexPath]()
                spots = [[String:Any]]()
            }
            
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "GunmatoMap"{
                    let nextVC = segue.destination as! MapViewController
                    nextVC.spotsfin = spots
                    //nextVC.startingpoint=startingpoint
                    nextVC.start=start
                    
                }
            
        }
    }

