//
//  MapViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/04/10.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController ,MKMapViewDelegate,CLLocationManagerDelegate,UISearchBarDelegate{
    
    var spotsfin = [[String:Any]]()//前画面から受け取った目的地
    var listfromstarting=[[String:Any]]()
    var routeCoordinates:[CLLocationCoordinate2D]=[]
    var record=[[String:Any]]()
    var startingpoint:String=""
    var startCoordinate:CLLocationCoordinate2D=CLLocationCoordinate2D()
    var list=[[String:Any]]()
    var start=[String:Any]()
    var newdestination=""
    var newCoordinate:CLLocationCoordinate2D=CLLocationCoordinate2D()
    var routelist_fin=[MKRoute]()
    var annotationlist=[MKAnnotation]()
    
    
    private let myMapView: MKMapView = MKMapView()
    private var myButton:UIButton!
    private var myLocationManager:CLLocationManager!
    private var mySearchBar:UISearchBar!
    private var homeButton:UIButton!
    
    
    //二点間の距離を求める
    func Distance(spots:[[String:Any]],dep:Int,des:Int)->Double{
       
        let Dep=CLLocation(latitude:spots[dep]["latitude"] as! CLLocationDegrees,longitude:spots[dep]["longitude"] as! CLLocationDegrees)
        let Des=CLLocation(latitude:spots[des]["latitude"] as! CLLocationDegrees,longitude:spots[des]["longitude"] as! CLLocationDegrees)
        return Dep.distance(from: Des)
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated:false)
        self.navigationController!.navigationBar.tintColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
        
        self.navigationItem.hidesBackButton = true
        
        print("listfromstarting\(listfromstarting)")
        print("list\(list)")
        //spotsに目的地を追加
        print("start\(start)")
        list.append(start)
        for i in 0..<spotsfin.count{
            list.append(spotsfin[i])
        }
        print("spots\(list)")

        
        // mapViewを生成.
        //let myMapView: MKMapView = MKMapView(frame: self.view.frame)
        myMapView.frame=self.view.frame

        // Delegateを設定.
        myMapView.delegate = self
        
        //myMapviewをviewに追加
        self.view.addSubview(myMapView)
        
        //Buttonの設定
        myButton=UIButton(type: .detailDisclosure)
        let width:CGFloat=150
        let height:CGFloat=20
        let x:CGFloat=self.view.bounds.width-width
        let y:CGFloat=self.view.bounds.height-height*6
        
        myButton.frame=CGRect(x: x, y: y, width: width, height: height)
        myButton.setTitle("現在地を表示", for:.normal)
        //myButton.backgroundColor=UIColor.white
        myButton.setTitleColor(UIColor.gray, for: .normal)
        myButton.addTarget(self, action: #selector(ClickButton), for: .touchUpInside)
        self.view.addSubview(myButton)
        self.view.bringSubviewToFront(myButton)
        
        //searchbarSetting
        mySearchBar=UISearchBar()
        mySearchBar.delegate=self
        mySearchBar.frame=CGRect(x:0,y:0,width:300,height:70)
        mySearchBar.layer.position=CGPoint(x:self.view.bounds.width/2,y:130)
        //cancenButton is valid
        mySearchBar.showsCancelButton=true
        //bookmarkButton is invalid
        mySearchBar.showsBookmarkButton=false
        //style is default
        mySearchBar.searchBarStyle=UISearchBar.Style.default
        //title
        mySearchBar.prompt="目的地の追加"
        //explain
        mySearchBar.placeholder="Enter here"
        //cursor,cancelbutton color
        mySearchBar.tintColor=UIColor.blue
        mySearchBar.showsSearchResultsButton=false
        self.view.addSubview(mySearchBar)
        
        //homebuttonの設定
        homeButton=UIButton()
        homeButton.frame=CGRect(x: Int(self.view.bounds.width)-30-70, y: Int(self.view.bounds.height)-30-70, width:70, height: 70)
        homeButton.setTitle("home", for: .normal)
        homeButton.addTarget(self, action: #selector(clickHomeButton), for: .touchDown)
        homeButton.backgroundColor=UIColor.gray
        self.view.addSubview(homeButton)
        /* //合計の距離が最も小さいように配列を並び替える
        for i in 0..<spots.count-1{
            
            var min=Distance(dep:i, des:i+1)
            var min_index=i+1
            
            for j in i+2..<spots.count{
                if min>Distance(dep:i, des:j){
                    min=Distance(dep:i, des:j)
                    min_index=j
                }
            }
            let x=spots[i+1]
            spots[i+1]=spots[min_index]
            spots[min_index]=x
        }
        
        print("並び替えると\(spots)")
        
        //全ての地点の座標を生成
        for i in 0..<spots.count{
            
            let coordinate:CLLocationCoordinate2D=CLLocationCoordinate2D(latitude: spots[i]["latitude"] as! CLLocationDegrees,longitude: spots[i]["longitude"] as! CLLocationDegrees)
            spots[i].updateValue(coordinate,forKey:"coordinate")
            
        
        }
        print(spots)
        
        //mapの表示設定
        var max_latitude:Double=spots[0]["latitude"] as! Double
        for i in 1..<spots.count{
            if max_latitude<spots[i]["latitude"] as! Double{
                max_latitude=spots[i]["latitude"] as! Double
            }
        }
        var min_latitude:Double=spots[0]["latitude"] as! Double
        for i in 1..<spots.count{
            if min_latitude>spots[i]["latitude"] as! Double{
                min_latitude=spots[i]["latitude"] as! Double
            }
        }
        var max_longitude:Double=spots[0]["longitude"] as! Double
        for i in 1..<spots.count{
            if max_longitude<spots[i]["longitude"] as! Double{
                max_longitude=spots[i]["longitude"] as! Double
            }
        }
        var min_longitude:Double=spots[0]["longitude"] as! Double
        for i in 1..<spots.count{
            if min_longitude>spots[i]["longitude"] as! Double{
                min_longitude=spots[i]["longitude"] as! Double
            }
        }
        print(max_latitude)
        print(min_latitude)
        print(max_longitude)
        print(min_longitude)
        
        let center:CLLocationCoordinate2D=CLLocationCoordinate2D(latitude:(max_latitude+min_latitude)/2 ,longitude:(max_longitude+min_longitude)/2 )
        myMapView.setCenter(center, animated: true)
        let mySpan:MKCoordinateSpan=MKCoordinateSpan(latitudeDelta: 0.3,longitudeDelta: 0.3)
        let myRegion:MKCoordinateRegion=MKCoordinateRegion(center: center, span: mySpan)
        myMapView.region=myRegion
        print(center)
        print((max_latitude+min_latitude)/2)
        print(max_latitude-min_latitude+20)
        
        //全ての地点のピンを生成
        for i in 0..<spots.count{
            
            let Pin:MKPointAnnotation=MKPointAnnotation()
            Pin.coordinate=spots[i]["coordinate"] as! CLLocationCoordinate2D
            Pin.title=spots[i]["name"] as? String
            myMapView.addAnnotation(Pin)
        
        }
        //隣あう二点間の経路を表示、for文で回す
        for i in 0..<spots.count-1{
            //出発地てんと目的地のPlaceMarkをそれぞれ作成
            let fromPlace:MKPlacemark=MKPlacemark(coordinate: spots[i]["coordinate"] as! CLLocationCoordinate2D, addressDictionary: nil)
            let toPlace:MKPlacemark=MKPlacemark(coordinate:spots[i+1]["coordinate"] as! CLLocationCoordinate2D, addressDictionary: nil)
            
            //PlaceMarkからItemを生成
            let fromItem:MKMapItem=MKMapItem(placemark: fromPlace)
            let toItem:MKMapItem=MKMapItem(placemark: toPlace)
            
            //MKDirectionRequestを生成
            let myRequest:MKDirections.Request=MKDirections.Request()
            
            //myRequestに出発地、目的地のItem、移動手段、複数経路の検索を設定
            myRequest.source=fromItem
            myRequest.destination=toItem
            myRequest.requestsAlternateRoutes=true
            myRequest.transportType=MKDirectionsTransportType.walking
            
            //MKDirectionを生成してRequestをセット
            let myDirections:MKDirections=MKDirections(request:myRequest)
            
            //経路探索
            myDirections.calculate{(response,error)in
                if error != nil || response!.routes.isEmpty{
                    return
                }
                let route:MKRoute=response!.routes[0] as MKRoute
                print("目的地まで\(route.distance/1000)km")
                print("所要時間：\(Int(route.expectedTravelTime/60))分")
                
                //recordに経路の詳細を記録
                self.record.append(["way":route.distance/1000,"time":Int(route.expectedTravelTime/60)])
                print(self.record)
                
                //mapViewにルートを描画
                self.myMapView.addOverlay(route.polyline)

            }
        }*/
        if list.isEmpty{
            print("listisempty")
        }else{
            print("listinnotempty\(list)")
        }
        //Route(spotslist: list)
        if listfromstarting.isEmpty{
            print("list\(list)")
            Route(spotslist: list)
        }else{
            Route(spotslist: listfromstarting)
        }
        //alertsetting()
        
    }
    
    
    //ルート描画関数
    func Route(spotslist spot:[[String:Any]]){
        var spots=spot
        var rec=[[String:Any]]()
        //var route:MKRoute=MKRoute()
        //route=MKRoute()
        var routelist=[MKRoute]()
        //合計の距離が最も小さいように配列を並び替える
        for i in 0..<spots.count-1{
            
            var min=Distance(spots:spots,dep:i, des:i+1)
            var min_index=i+1
            
            for j in i+2..<spots.count{
                if min>Distance(spots:spots,dep:i, des:j){
                    min=Distance(spots:spots,dep:i, des:j)
                    min_index=j
                }
            }
            let x=spots[i+1]
            spots[i+1]=spots[min_index]
            spots[min_index]=x
        }
        
        print("並び替えると\(spots)")
        self.list=spots
        
        //全ての地点の座標を生成
        for i in 0..<spots.count{
            
            let coordinate:CLLocationCoordinate2D=CLLocationCoordinate2D(latitude: spots[i]["latitude"] as! CLLocationDegrees,longitude: spots[i]["longitude"] as! CLLocationDegrees)
            spots[i].updateValue(coordinate,forKey:"coordinate")
            
        
        }
        print("座標込み\(spots)")
        
        //mapの表示設定
        var max_latitude:Double=spots[0]["latitude"] as! Double
        for i in 1..<spots.count{
            if max_latitude<spots[i]["latitude"] as! Double{
                max_latitude=spots[i]["latitude"] as! Double
            }
        }
        var min_latitude:Double=spots[0]["latitude"] as! Double
        for i in 1..<spots.count{
            if min_latitude>spots[i]["latitude"] as! Double{
                min_latitude=spots[i]["latitude"] as! Double
            }
        }
        var max_longitude:Double=spots[0]["longitude"] as! Double
        for i in 1..<spots.count{
            if max_longitude<spots[i]["longitude"] as! Double{
                max_longitude=spots[i]["longitude"] as! Double
            }
        }
        var min_longitude:Double=spots[0]["longitude"] as! Double
        for i in 1..<spots.count{
            if min_longitude>spots[i]["longitude"] as! Double{
                min_longitude=spots[i]["longitude"] as! Double
            }
        }
        print(max_latitude)
        print(min_latitude)
        print(max_longitude)
        print(min_longitude)
        
        let center:CLLocationCoordinate2D=CLLocationCoordinate2D(latitude:(max_latitude+min_latitude)/2 ,longitude:(max_longitude+min_longitude)/2 )
        myMapView.setCenter(center, animated: true)
        //let mySpan:MKCoordinateSpan=MKCoordinateSpan(latitudeDelta: 0.3,longitudeDelta: 0.3)
        //let myRegion:MKCoordinateRegion=MKCoordinateRegion(center: center, span: mySpan)
        let latidelta:CLLocationDegrees = max_latitude-min_latitude+0.01
        let longdelta:CLLocationDegrees = max_longitude-min_longitude+0.01
        let mySpan:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latidelta, longitudeDelta: longdelta)
        let myRegion:MKCoordinateRegion=MKCoordinateRegion(center:center, span: mySpan)
        myMapView.region=myRegion
        print(center)
        print((max_latitude+min_latitude)/2)
        print(max_latitude-min_latitude+20)
        
        //全ての地点のピンを生成
        for i in 0..<spots.count{
            
            let Pin:MKPointAnnotation=MKPointAnnotation()
            Pin.coordinate=spots[i]["coordinate"] as! CLLocationCoordinate2D
            Pin.title=spots[i]["name"] as? String
            
            annotationlist.append(Pin)
            myMapView.addAnnotation(Pin)
        
        }
        //隣あう二点間の経路を表示、for文で回す
        for i in 0..<spots.count-1{
            //出発地てんと目的地のPlaceMarkをそれぞれ作成
            let fromPlace:MKPlacemark=MKPlacemark(coordinate: spots[i]["coordinate"] as! CLLocationCoordinate2D, addressDictionary: nil)
            let toPlace:MKPlacemark=MKPlacemark(coordinate:spots[i+1]["coordinate"] as! CLLocationCoordinate2D, addressDictionary: nil)
            
            //PlaceMarkからItemを生成
            let fromItem:MKMapItem=MKMapItem(placemark: fromPlace)
            let toItem:MKMapItem=MKMapItem(placemark: toPlace)
            
            //MKDirectionRequestを生成
            let myRequest:MKDirections.Request=MKDirections.Request()
            
            //myRequestに出発地、目的地のItem、移動手段、複数経路の検索を設定
            myRequest.source=fromItem
            myRequest.destination=toItem
            myRequest.requestsAlternateRoutes=true
            myRequest.transportType=MKDirectionsTransportType.any
            
            //MKDirectionを生成してRequestをセット
            let myDirections:MKDirections=MKDirections(request:myRequest)
            
            //経路探索
            myDirections.calculate{(response,error)in
                if error != nil || response!.routes.isEmpty{
                    return
                }
                let route=response!.routes[0] as MKRoute
                print("\(spots[i]["name"])から\(spots[i+1]["name"])目的地まで\(route.distance/1000)km")
                print("所要時間：\(Int(route.expectedTravelTime/60))分")
                print(route.transportType)
                routelist.append(route)
                self.routelist_fin=routelist
                //recordに経路の詳細を記録
                
                rec.append(["start":i,"way":route.distance/1000,"time":Int(route.expectedTravelTime/60)])
                print("途中のrec\(rec)")
                self.record=rec
                
                //mapViewにルートを描画
                self.myMapView.addOverlay(route.polyline)

            }
            //alertsetting()
            
        }

        
        
    }
    
    //既存のルートをviewから削除
    func remove(removeroutelist routelist:[MKRoute]){
        for i in 0..<routelist.count{
            self.myMapView.removeOverlay(routelist[i].polyline)
        }
    }
    
    //ルートのデザイン設定
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        let route: MKPolyline = overlay as! MKPolyline
        let routeRenderer: MKPolylineRenderer = MKPolylineRenderer(polyline: route)

        // ルートの線の太さ.
        routeRenderer.lineWidth = 3.0

        // ルートの線の色.
        routeRenderer.strokeColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
        return routeRenderer
    }
    
    var deletetitle:String=""
    var annotationindex:Int = 0
    //pinが選択されたときにindexを得る
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation
        deletetitle = annotation?.title!! as! String
        print(deletetitle)
        if listfromstarting.isEmpty{
            for i in 0..<list.count{
                if list[i]["name"] as! String==deletetitle{
                    annotationindex=i
                    print("listindex\(annotationindex)")
                }
            }
        }else{
            for i in 0..<listfromstarting.count{
                if listfromstarting[i]["name"] as! String==deletetitle{
                    annotationindex=i
                    print("listfromstarting\(annotationindex)")
                }
            }

        }
    }
    //pinの吹き出しに削除ボタンを設定
    func mapView(_ mapView:MKMapView,viewFor annotation: MKAnnotation) ->MKAnnotationView?{
        let pinView = MKPinAnnotationView(annotation:annotation , reuseIdentifier:nil )
        pinView.canShowCallout=true
        pinView.pinTintColor = UIColor.black
        deletetitle=annotation.title!!
        
        let button2 = UIButton()
        button2.frame = CGRect(x: 0,y: 0,width: 35,height: 35)
        button2.setTitle("削除", for: .normal)
        button2.backgroundColor = UIColor.gray
        button2.addTarget(self, action: #selector(clickDeleteButton), for: .touchDown)
        pinView.rightCalloutAccessoryView = button2
        return pinView
    }
    
    
    //テキストが変更するたびに呼ばれる
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        newdestination = searchText
    }
    
    //cancelbuttonが押されたときに呼ばれる
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        newdestination = ""
        mySearchBar.text = ""
    }
    
    //searchbuttonが押されたときに呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        newdestination=searchBar.text!
        
        //新目的地のピン設定
        let _:MKPointAnnotation=MKPointAnnotation()

        //新目的地のジオコーディング
        let myGeocoder: CLGeocoder = CLGeocoder()
        
        myGeocoder.geocodeAddressString(newdestination,completionHandler:{(placemarks,error) in
                       
                       if let unwrapPlacemarks = placemarks{
                           if let firstPlacemark = unwrapPlacemarks.first{
                               if let location = firstPlacemark.location{
                                   let targetCoordinate = location.coordinate
                                self.newCoordinate=targetCoordinate
                                print("＊＊ジオコーディングnewCoordinate\(self.newCoordinate)＊＊")
                                //self.start=["name":self.startingpoint,"latitude":self.startCoordinate.latitude,"longitude":self.startCoordinate.longitude]
                                //newpin.coordinate=self.newCoordinate
                                //self.myMapView.addAnnotation(newpin)
                                var new=[String:Any]()
                                new=["name":self.newdestination,"latitude":self.newCoordinate.latitude,"longitude":self.newCoordinate.longitude]
                                //listに新たな目的地を追加
                                self.list.append(new)
                                //既存のルートを削除
                                self.remove(removeroutelist: self.routelist_fin)
                                //新たにルートを描画
                                self.Route(spotslist: self.list)
                            }
                        }
            }
        })
        mySearchBar.text=""
        self.view.endEditing(true)
    }
    
    @objc func clickDeleteButton(sender:UIButton){
        
        print(deletetitle)
        if listfromstarting.isEmpty{
            myMapView.removeAnnotation(annotationlist[annotationindex])
            list.remove(at: annotationindex)
            self.remove(removeroutelist: self.routelist_fin)
            Route(spotslist: list)
        }else{
            myMapView.removeAnnotation(annotationlist[annotationindex])
            listfromstarting.remove(at: annotationindex)
            self.remove(removeroutelist: self.routelist_fin)
            Route(spotslist: listfromstarting)
        }
    }

    
    @objc func ClickButton(sender:UIButton){
        print("button clicked")
        
       /* CLLocationManager.locationServicesEnabled()
        
        let status = CLLocationManager.authorizationStatus()
        
        if(status == CLAuthorizationStatus.notDetermined){
            
            myLocationManager.requestWhenInUseAuthorization()
            
        }else if(status == CLAuthorizationStatus.authorizedWhenInUse){
            print("authorizedWhen InUse")
        }else if(status == CLAuthorizationStatus.restricted){
            print("restricted")
        }else if(status == CLAuthorizationStatus.authorizedAlways){
            print("authorizedAlways")
        }else{
            print("not allowed")
        }
        
        myLocationManager.startUpdatingHeading()
        
        var nowcoordinate:CLLocationCoordinate2D=myMapView.userLocation.coordinate
        
        var nowpin:MKPointAnnotation=MKPointAnnotation()
        
        nowpin.coordinate=nowcoordinate
        nowpin.title="現在地"
        
        myMapView.userTrackingMode=MKUserTrackingMode.follow
        myMapView.userTrackingMode=MKUserTrackingMode.followWithHeading*/
        
        
    }
    
    //ホームボタンが押されたとき
    @objc func clickHomeButton(sender:UIButton){
        /*if listfromstarting.isEmpty{
            list = [[String:Any]]()
        }else{
            listfromstarting = [[String:Any]]()
        }*/
        let count = (self.navigationController?.viewControllers.count)! - 2
        
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
        performSegue(withIdentifier: "mapToHome", sender: nil)
    }
    
    func alertsetting(){
        let alert = UIAlertController(title: "経路を取得できませんでした", message: nil, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OKAction)
        if list.count != record.count + 1{
            present(alert,animated: true)
        }
    }
    
    
   
    @IBAction func goDetailAction(_ sender: Any) {
        performSegue(withIdentifier: "goDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "goDetail"{
            
            let nextVC = segue.destination as! DetailViewController
            
            nextVC.spots = list
            nextVC.records=record
        }
    }
    
    

        /*override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }*/

    

}

        


