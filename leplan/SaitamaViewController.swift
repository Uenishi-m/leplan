//
//  SaitamaViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/05/30.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//

import UIKit

class SaitamaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate {

 private var myTableView:UITableView!
    
    var regionlist = ["さいたま市・川口市・鴻巣市","川越市・所沢市・飯能市・日高市","秩父市・長瀞町","行田市・幸手市・久喜市・白岡市"]
    var listfir = [["name":"鉄道博物館","latitude":35.9208443 ,"longitude":139.6157429],
    ["name":"盆栽美術館","latitude":35.9288245,"longitude":139.6306528],
    ["name":"さいたまスタジアム2002公園","latitude":38.2504786,"longitude":140.8579106]]
    var listsec = [["name":"小江戸川越","latitude":35.9205666,"longitude":139.4739919],["name":"川越氷川神社","latitude":35.927325,"longitude":139.4862973],["name":"高麗神社","latitude":35.8978898,"longitude":139.3211439],["name":"サイボクハム","latitude":35.8211571,"longitude":139.2696332],["name":"巾着田","latitude":35.8825239,"longitude":139.3083386],["name":"あけぼの子どもの森公園","latitude":35.8305813,"longitude":139.3421071],["name":"ーミンバレーパーク","latitude":35.8712837,"longitude":139.3305931],["name":"生活の木メディカルハーブ薬香草園","latitude":35.8442034,"longitude":139.3073193],["name":"トトロの森1号地","latitude":35.7658849,"longitude":139.3677883],["name":"西武ゆうえんち","latitude":35.7673439,"longitude":139.4405444],["name":"所沢航空記念公園","latitude":35.7981909,"longitude":139.4685404]]
    var listthird = [["name":"長瀞ライン下り","latitude":36.0949792,"longitude":139.1085385],["name":"宝登山","latitude":36.0932244,"longitude":139.0567537],["name":"羊山公園","latitude":35.986768,"longitude":139.0872756],["name":"秩父ミューズパーク","latitude":35.9935654,"longitude":139.0497663],["name":"三十槌の氷柱","latitude":35.9450111,"longitude":138.92404]]
    var listforth = [["name":"権現堂堤","latitude":36.0907768,"longitude":139.7216179],["name":"東武動物公園","latitude":36.0231628,"longitude":139.6943048],]
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
        
        listlist = [0:listfir,1:listsec,2:listthird,3:listforth]
        
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
           controller.saitamaChoosenindexpath = choosenindexpath
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
        }
       
        cell.backgroundColor=UIColor(red:248/255, green: 248/255, blue: 248/255, alpha: 1)
        cell.textLabel!.font = UIFont(name: "Avenir", size: 20.0)
        cell.textLabel!.textColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
        
        return cell
    }
    @IBAction func toMap(_ sender: Any) {
            performSegue(withIdentifier: "SaitamatoMap", sender: nil)
                choosenindexpath = [IndexPath]()
                spots = [[String:Any]]()
            }
            
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "SaitamatoMap"{
                    let nextVC = segue.destination as! MapViewController
                    nextVC.spotsfin = spots
                    //nextVC.startingpoint=startingpoint
                    nextVC.start=start
                    
                }
            
        }
    
}
