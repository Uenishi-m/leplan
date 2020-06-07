//
//  AkitaViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/05/30.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//

import UIKit

class AkitaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate {

 private var myTableView:UITableView!
    
    var regionlist = ["男鹿・能代・大館・鹿角","秋田・由利本荘・にかほ","仙北、田沢湖、角館、湯沢"]
    var listfir = [["name":"男鹿真山伝承館","latitude":39.9291884 ,"longitude":139.76441],
    ["name":"八幡平の後生掛自然研究路","latitude":39.9770555,"longitude":140.7943555],
    ["name":"大館・小坂鉄道レールバイク","latitude":40.2904897,"longitude":140.6298009],
    ["name":"男鹿水族館GAO","latitude":39.9421821,"longitude":139.7024067],
    ["name":"大館・小坂鉄道レールバイク","latitude":40.2904897,"longitude":140.6298009],
    ["name":"寒風山回転展望台","latitude":39.9339923,"longitude":139.8732382]]
    var listsec = [["name":"秋田市大森山動物園 ～あきぎんオモリンの森～","latitude":39.6711631,"longitude":140.071847],["name":"法体の滝","latitude":39.1079405,"longitude":140.1570803],["name":"天然記念物「象潟」九十九島","latitude":39.2198223,"longitude":139.9047303],["name":"ポートタワーセリオン","latitude":39.7525681,"longitude":140.0589573],["name":"秋田国際ダリア園","latitude":39.5953638,"longitude":140.1849907],["name":"秋田県立美術館","latitude":39.7173697,"longitude":140.1193726]]
    var listthird = [["name":"小安峡","latitude":39.0064699,"longitude":140.6625228],["name":"田沢湖","latitude":39.7247721,"longitude":140.6289089],["name":"角館武家屋敷","latitude":39.5979524,"longitude":140.559985],["name":"玉川温泉","latitude":39.9630556,"longitude":140.6812025],["name":"山のはちみつ屋","latitude":39.7198818,"longitude":140.6837569]]
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
        
        listlist = [0:listfir,1:listsec,3:listthird]
        
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
           controller.akitaChoosenindexpath = choosenindexpath
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
        }else if section == 2 && validsections.contains(section){
            return listthird.count
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
        }
       
        cell.backgroundColor=UIColor(red:248/255, green: 248/255, blue: 248/255, alpha: 1)
        cell.textLabel!.font = UIFont(name: "Avenir", size: 20.0)
        cell.textLabel!.textColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
        
        return cell
    }
    
    @IBAction func toMap(_ sender: Any) {
        performSegue(withIdentifier: "AkitatoMap", sender: nil)
               choosenindexpath = [IndexPath]()
               spots = [[String:Any]]()
           }
           
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if segue.identifier == "AkitatoMap"{
                   let nextVC = segue.destination as! MapViewController
                   nextVC.spotsfin = spots
                   //nextVC.startingpoint=startingpoint
                   nextVC.start=start
                   
               }
           }
    }
    
        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



