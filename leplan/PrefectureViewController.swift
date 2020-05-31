//
//  PrefectureViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/05/28.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//

import UIKit
import MapKit

class PrefectureViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var regionlist = ["北海道","東北地方","関東地方","中部地方","近畿地方","中国地方","四国地方","九州地方"]
    
    var hokkaidolist = ["北海道"]
    var tohokulist = ["青森県","宮城県","秋田県","山形県","福島県","岩手県"]
    var kantolist = ["茨城県","群馬県","埼玉県","千葉県","東京都","神奈川県"]
    var chubulist = ["新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県","静岡県","愛知県"]
    var kinkilist = ["大阪府","京都府","兵庫県","奈良県","三重県","滋賀県","和歌山県"]
    var chugokulist = ["島根県","鳥取県","岡山県","広島県","山口県"]
    var sikokulist = ["香川県","徳島県","愛媛県","高知県"]
    var kyushulist = ["福岡県","佐賀県","長崎県","熊本県","大分県","宮崎県","鹿児島県","沖縄県"]
    var label:[Bool] = []
    var listlist:[Int:[String]] = [:]
    var startingpoint = ""
    //前画面から受け取る
    var spots = [[String:Any]]()
    var spotsfin = [[String:Any]] ()
    var hokkaidochoosenindexpath = [IndexPath]()
    var miyagichoosenindexpath = [IndexPath]()
    var preVC:UIViewController = UIViewController()
    
    var startCoordinate:CLLocationCoordinate2D=CLLocationCoordinate2D()
    
    var start=[String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Status Barの高さを取得を.する.
       
        print("スタート\(startingpoint)")
        
    
        print("目的地集\(spots)")
        print(hokkaidochoosenindexpath)
        listlist = [0:hokkaidolist,1:tohokulist,2:kantolist,3:chubulist,4:kinkilist,5:chugokulist,6:sikokulist,7:kyushulist]
        
        for i in 0..<regionlist.count{
            label.append(false)
        }
        
        self.navigationController!.navigationBar.tintColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
              let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height

              // Viewの高さと幅を取得する.
              let displayWidth: CGFloat = self.view.frame.width
              let displayHeight: CGFloat = self.view.frame.height

              // TableViewの生成( status barの高さ分ずらして表示 ).
              myTableView.frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight)
        
              myTableView.isScrollEnabled = true

              // Cell名の登録をおこなう.
              myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")

              // DataSourceの設定をする.
              myTableView.dataSource = self

              // Delegateを設定する.
              myTableView.delegate = self
        
              myTableView.sectionHeaderHeight = 35.0

              // Viewに追加する.
              self.view.addSubview(myTableView)
        
        let myGeocoder: CLGeocoder = CLGeocoder()
               
               myGeocoder.geocodeAddressString(startingpoint,completionHandler:{(placemarks,error) in
                              
                              if let unwrapPlacemarks = placemarks{
                                  if let firstPlacemark = unwrapPlacemarks.first{
                                      if let location = firstPlacemark.location{
                                          let targetCoordinate = location.coordinate
                                       self.startCoordinate=targetCoordinate
                                       print("＊＊ジオコーディングtargetcoordinate\(self.startCoordinate)＊＊")
                                       self.start=["name":self.startingpoint,"latitude":self.startCoordinate.latitude,"longitude":self.startCoordinate.longitude]
                                       
                                       
                                   }
                               }
                   }
                let alert = UIAlertController(title: "位置情報を取得できませんでした", message: nil, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) {action in
                self.performSegue(withIdentifier: "backtohome", sender: nil)
                }
                 alert.addAction(OKAction)
                 if self.start.isEmpty{
                        self.present(alert,animated: true)
                }
               })
              
               print("view.start\(start)")
        
        /*let alert = UIAlertController(title: "位置情報を取得できませんでした", message: nil, preferredStyle: .alert)
               let OKAction = UIAlertAction(title: "OK", style: .default) {action in
                self.performSegue(withIdentifier: "backtohome", sender: nil)
               }
        alert.addAction(OKAction)
        if start.isEmpty{
            present(alert,animated: true)
        }*/
        print("wa!!\(spots)")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return regionlist.count
    }
    
    func tableView(_ tableView:UITableView,titleForHeaderInSection section:Int) -> String?{
        
        return regionlist[section]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section:Int) ->UIView?{
        
        let view = UITableViewHeaderFooterView()
        //view.tintColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
        view.textLabel?.tintColor = UIColor.black
        view.textLabel?.font = UIFont(name: "Avenir", size: 15.0)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(sectionHeaderDidTap(_:)))
        view.addGestureRecognizer(gesture)
        view.tag = section
        
        return view
    }
    
    var validsections:[Int] = []
    @objc func sectionHeaderDidTap(_ sender: UIGestureRecognizer) {
        validsections = []
        if let section = sender.view?.tag {
            print(section)
            if label[section] == false{
                label[section] = true
            }else if label[section] == true{
                label[section] = false
            }
            print(label)
        }
       
        for i in 0..<label.count{
            if label[i] == true{
                validsections.append(i)
            }
        }
        print("validsections\(validsections)")
        myTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView :UITableView, didSelectRowAt indexPath:IndexPath){
        if indexPath == [0,0]{
            performSegue(withIdentifier: "toHokkaido", sender: nil)
            print("koko!\(spots)")
            
        }else if indexPath == [1,1]{
            performSegue(withIdentifier: "toMiyagi", sender: nil)
        }else if indexPath == [1,0]{
            performSegue(withIdentifier: "toAomori", sender: nil)
        }else if indexPath == [1,2]{
            performSegue(withIdentifier: "toAkita", sender: nil)
        }else if indexPath == [1,3]{
            performSegue(withIdentifier: "toYamagata", sender: nil)
        }else if indexPath == [1,4]{
            performSegue(withIdentifier: "toFukushima", sender: nil)
        }else if indexPath == [1,5]{
            performSegue(withIdentifier: "toIwate", sender: nil)
        }else if indexPath == [2,0]{
            performSegue(withIdentifier: "toIbaragi", sender: nil)
        }else if indexPath == [2,1]{
            performSegue(withIdentifier: "toGunma", sender: nil)
        }else if indexPath == [2,2]{
            performSegue(withIdentifier: "toSaitama", sender: nil)
        }else if indexPath == [2,3]{
            performSegue(withIdentifier: "toChiba", sender: nil)
        }else if indexPath == [2,4]{
            performSegue(withIdentifier: "toTokyo", sender: nil)
        }else if indexPath == [2,5]{
            performSegue(withIdentifier: "toKanagawa", sender: nil)
        }else if indexPath == [3,0]{
            performSegue(withIdentifier: "toNiigata", sender: nil)
        }else if indexPath == [3,1]{
            performSegue(withIdentifier: "toToyama", sender: nil)
        }else if indexPath == [3,2]{
            performSegue(withIdentifier: "toIshikawa", sender: nil)
        }else if indexPath == [3,3]{
            performSegue(withIdentifier: "toFukui", sender: nil)
        }else if indexPath == [3,4]{
            performSegue(withIdentifier: "toYamanashi", sender: nil)
        }else if indexPath == [3,5]{
            performSegue(withIdentifier: "toNagano", sender: nil)
        }else if indexPath == [3,6]{
            performSegue(withIdentifier: "toGifu", sender: nil)
        }else if indexPath == [3,7]{
            performSegue(withIdentifier: "toShizuoka", sender: nil)
        }else if indexPath == [3,8]{
            performSegue(withIdentifier: "toAichi", sender: nil)
        }else if indexPath == [4,0]{
            performSegue(withIdentifier: "toOsaka", sender: nil)
        }else if indexPath == [4,1]{
            performSegue(withIdentifier: "toKyoto", sender: nil)
        }else if indexPath == [4,2]{
            performSegue(withIdentifier: "toHyogo", sender: nil)
        }else if indexPath == [4,3]{
            performSegue(withIdentifier: "toNara", sender: nil)
        }else if indexPath == [4,4]{
            performSegue(withIdentifier: "toMie", sender: nil)
        }else if indexPath == [4,5]{
            performSegue(withIdentifier: "toShiga", sender: nil)
        }else if indexPath == [4,6]{
            performSegue(withIdentifier: "toWakayama", sender: nil)
        }else if indexPath == [5,0]{
            performSegue(withIdentifier: "toShimane", sender: nil)
        }else if indexPath == [5,1]{
            performSegue(withIdentifier: "toTtotori", sender: nil)
        }else if indexPath == [5,2]{
            performSegue(withIdentifier: "toOkayama", sender: nil)
        }else if indexPath == [5,3]{
            performSegue(withIdentifier: "toHiroshima", sender: nil)
        }else if indexPath == [5,4]{
            performSegue(withIdentifier: "toYamaguchi", sender: nil)
        }else if indexPath == [6,0]{
            performSegue(withIdentifier: "toKagawa", sender: nil)
        }else if indexPath == [6,1]{
            performSegue(withIdentifier: "toTokushima", sender: nil)
        }else if indexPath == [6,2]{
            performSegue(withIdentifier: "toEhime", sender: nil)
        }else if indexPath == [6,3]{
            performSegue(withIdentifier: "toKochi", sender: nil)
        }else if indexPath == [7,0]{
            performSegue(withIdentifier: "toFukuoka", sender: nil)
        }else if indexPath == [7,1]{
            performSegue(withIdentifier: "toSaga", sender: nil)
        }else if indexPath == [7,2]{
            performSegue(withIdentifier: "toNagasaki", sender: nil)
        }else if indexPath == [7,3]{
            performSegue(withIdentifier: "toKumamoto", sender: nil)
        }else if indexPath == [7,4]{
            performSegue(withIdentifier: "toOita", sender: nil)
        }else if indexPath == [7,5]{
            performSegue(withIdentifier: "toMiyazaki", sender: nil)
        }else if indexPath == [7,6]{
            performSegue(withIdentifier: "toKagoshima", sender: nil)
        }else if indexPath == [7,7]{
            performSegue(withIdentifier: "toOkinawa", sender: nil)
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        if section == 0 && validsections.contains(section){
            return hokkaidolist.count
        }else if section == 1  && validsections.contains(section){
            return tohokulist.count
        }else if section == 2  && validsections.contains(section){
            return kantolist.count
        }else if section == 3  && validsections.contains(section){
            return chubulist.count
        }else if section == 4  && validsections.contains(section){
            return kinkilist.count
        }else if section == 5  && validsections.contains(section){
            return chugokulist.count
        }else if section == 6  && validsections.contains(section){
            return sikokulist.count
        }else if section == 7  && validsections.contains(section){
            return kyushulist.count
        }else{
            return 0
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell",for:indexPath)
        cell.accessoryType = .disclosureIndicator
        if indexPath.section == 0  && validsections.contains(indexPath.section){
            cell.textLabel?.text = hokkaidolist[indexPath.row]
        }else if indexPath.section == 1 && validsections.contains(indexPath.section){
            cell.textLabel?.text = tohokulist[indexPath.row]
        }else if indexPath.section == 2 && validsections.contains(indexPath.section){
            cell.textLabel?.text = kantolist[indexPath.row]
        }else if indexPath.section == 3 && validsections.contains(indexPath.section){
            cell.textLabel?.text = chubulist[indexPath.row]
        }else if indexPath.section == 4 && validsections.contains(indexPath.section){
            cell.textLabel?.text = kinkilist[indexPath.row]
        }else if indexPath.section == 5 && validsections.contains(indexPath.section){
            cell.textLabel?.text = chugokulist[indexPath.row]
        }else if indexPath.section == 6 && validsections.contains(indexPath.section){
            cell.textLabel?.text = sikokulist[indexPath.row]
        }else if indexPath.section == 7 && validsections.contains(indexPath.section){
            cell.textLabel?.text = kyushulist[indexPath.row]
        }
        
        cell.backgroundColor=UIColor(red:248/255, green: 248/255, blue: 248/255, alpha: 1)
        cell.textLabel!.font = UIFont(name: "Avenir", size: 20.0)
        cell.textLabel!.textColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHokkaido"{
            let nextVC = segue.destination as! HokkaidoViewController
            print("previous\(spots)")
            nextVC.start = start
            nextVC.spots = spots
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = hokkaidochoosenindexpath
        }else if segue.identifier == "toMiyagi"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toAomori"{
            let nextVC = segue.destination as! AomoriViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toAkita"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toYamagata"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toFukushima"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toIwate"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toIbaragi"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toGunma"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toSaitama"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toChiba"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toTokyo"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toKanagawa"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toNiigata"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toToyama"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toIshikawa"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toFukui"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toYamanashi"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toNagano"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toGifu"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toShizuoka"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toAichi"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toOsaka"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toKyoto"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toHyogo"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toNara"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toMie"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toShiga"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toWakayama"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toShimane"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toTtotori"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toOkayama"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toHiroshima"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toYamaguchi"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toKagawa"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toTokushima"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toEhime"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toKochi"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toFukuoka"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toSaga"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toNagasaki"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toKumamoto"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toOita"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toMiyazaki"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toKagoshima"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
        }else if segue.identifier == "toOkinawa"{
            let nextVC = segue.destination as! MiyagiViewController
            nextVC.start = start
            nextVC.spots = spots
           
            //spots = [[String:Any]]()
            nextVC.choosenindexpath = miyagichoosenindexpath
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
