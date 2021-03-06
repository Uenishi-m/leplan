//
//  MapViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/04/10.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController ,MKMapViewDelegate{
    
    var spots = [[String:Any]]()
    var routeCoordinates:[CLLocationCoordinate2D]=[]
    var record=[[String:Any]]()
    
    //二点間の距離を求める
    func Distance(dep:Int,des:Int)->Double{
       
        let Dep=CLLocation(latitude:spots[dep]["latitude"] as! CLLocationDegrees,longitude:spots[dep]["longitude"] as! CLLocationDegrees)
        let Des=CLLocation(latitude:spots[des]["latitude"] as! CLLocationDegrees,longitude:spots[des]["longitude"] as! CLLocationDegrees)
        return Dep.distance(from: Des)
        
    }
    /*func perm(head:[String],rest:[String])->[String]{
        if rest.count == 0{
            return head
        }else {
            var res = [String]()
            for i in 0...rest.count{
                var restx = rest
                var headx = head+restx[i..<i+1]
                res = res+perm(head:headx, rest:restx)
            }
            return res
        }
    }*/
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
        let myMapView: MKMapView = MKMapView(frame: self.view.frame)

        // Delegateを設定.
        myMapView.delegate = self
        
        //myMapviewをviewに追加
        self.view.addSubview(myMapView)
        
    
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
                myMapView.addOverlay(route.polyline)

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

        


