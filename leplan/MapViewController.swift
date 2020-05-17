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
    
    var spotsfin = [[String:Any]]()
    var routeCoordinates:[CLLocationCoordinate2D]=[]
    var record=[[String:Any]]()
    var startingpoint:String=""
    var startCoordinate:CLLocationCoordinate2D=CLLocationCoordinate2D()
    var spots=[[String:Any]]()
    var start=[String:Any]()
    
    private let myMapView: MKMapView = MKMapView()
    private var myButton:UIButton!
    private var myLocationManager:CLLocationManager!
    private var mySearchBar:UISearchBar!
    
    
    //二点間の距離を求める
    func Distance(dep:Int,des:Int)->Double{
       
        let Dep=CLLocation(latitude:spots[dep]["latitude"] as! CLLocationDegrees,longitude:spots[dep]["longitude"] as! CLLocationDegrees)
        let Des=CLLocation(latitude:spots[des]["latitude"] as! CLLocationDegrees,longitude:spots[des]["longitude"] as! CLLocationDegrees)
        return Dep.distance(from: Des)
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //spotsに目的地を追加
        print("start\(start)")
        spots.append(start)
        for i in 0..<spotsfin.count{
            spots.append(spotsfin[i])
        }
        print("spots\(spots)")

        
        
        //合計の距離が最も小さいように配列を並び替える
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
        let y:CGFloat=self.view.bounds.height-height*2
        
        myButton.frame=CGRect(x: x, y: y, width: width, height: height)
        myButton.setTitle("現在地を表示", for:.normal)
        //myButton.backgroundColor=UIColor.white
        myButton.addTarget(self, action: #selector(ClickButton), for: .touchUpInside)
        self.view.addSubview(myButton)
        self.view.bringSubviewToFront(myButton)
        
        //searchbarSetting
        mySearchBar=UISearchBar()
        mySearchBar.delegate=self
        mySearchBar.frame=CGRect(x:0,y:0,width:300,height:80)
        mySearchBar.layer.position=CGPoint(x:self.view.bounds.width/2,y:100)
        //cancenButton is valid
        mySearchBar.showsCancelButton=true
        //bookmarkButton is invalid
        mySearchBar.showsBookmarkButton=false
        //style is default
        mySearchBar.searchBarStyle=UISearchBar.Style.default
        //title
        mySearchBar.prompt="Add Destination"
        //explain
        mySearchBar.placeholder="Enter here"
        //cursor,cancelbutton color
        mySearchBar.tintColor=UIColor.blue
        mySearchBar.showsSearchResultsButton=false
        self.view.addSubview(mySearchBar)
        
        
        
    
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
        }
        
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        let route: MKPolyline = overlay as! MKPolyline
        let routeRenderer: MKPolylineRenderer = MKPolylineRenderer(polyline: route)

        // ルートの線の太さ.
        routeRenderer.lineWidth = 3.0

        // ルートの線の色.
        routeRenderer.strokeColor = UIColor.red
        return routeRenderer
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
    
   
    @IBAction func goDetailAction(_ sender: Any) {
        performSegue(withIdentifier: "goDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "goDetail"{
            
            let nextVC = segue.destination as! DetailViewController
            
            nextVC.spots = spots
            nextVC.records=record
            
    }
    }
    
    

        /*override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }*/

    

}

        


