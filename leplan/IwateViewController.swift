//
//  IwateViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/05/30.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//

import UIKit

class IwateViewController:UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate {

 private var myTableView:UITableView!
    
    var regionlist = ["宮古・岩泉・三陸","奥羽・遠野・花巻・平泉・一関","盛岡・雫石"]
    var listfir = [["name":"龍泉洞","latitude":39.8525056 ,"longitude":141.7806956],
    ["name":"浄土ヶ浜","latitude":39.6506445,"longitude":141.9419351],
    ["name":"小袖海女センター","latitude":40.168458,"longitude":141.8502197],["name":"碁石海岸","latitude":38.9960756 ,"longitude":141.6910663]]
    var listsec = [["name":"中尊寺金色堂","latitude":39.0015517,"longitude":141.0990601],["name":"毛越寺","latitude":38.9872123,"longitude":141.1053826],["name":"カッパ淵","latitude":39.3541007,"longitude":141.5683568],["name":"めがね橋","latitude":36.3580628,"longitude":138.6960949],["name":"厳美渓","latitude":38.9443232,"longitude":141.0458483],["name":"猊鼻渓","latitude":38.9670313,"longitude":141.0119618],["name":"宮沢賢治記念館","latitude":39.3992237,"longitude":141.1605169],["name":"歴史公園えさし藤原の郷","latitude":39.1963982,"longitude":141.1870371]]
    var listthird = [["name":"小岩井農場","latitude":39.7534198,"longitude":140.9942699],["name":"岩手山","latitude":39.852681,"longitude":140.9660835],["name":"石割桜","latitude":39.7037901,"longitude":141.149048],["name":"マリオス展望台","latitude":39.7037901,"longitude":141.149048],["name":" 岩手銀行赤レンガ館","latitude":39.7037901,"longitude":141.149048]]
    
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
        
        listlist = [0:listfir,1:listsec,2:listthird]
        
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
           //spots = [[String:Any]]()
           controller.iwateChoosenindexpath = choosenindexpath
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
        performSegue(withIdentifier: "IwatetoMap", sender: nil)
            choosenindexpath = [IndexPath]()
            spots = [[String:Any]]()
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "IwatetoMap"{
                let nextVC = segue.destination as! MapViewController
                nextVC.spotsfin = spots
                //nextVC.startingpoint=startingpoint
                nextVC.start=start
                
            }
        
    }
}
