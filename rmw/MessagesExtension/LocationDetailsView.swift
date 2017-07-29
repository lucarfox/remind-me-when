//
//  LocationDetailsView.swift
//  rmw
//
//  Created by Tahia on 7/26/17.
//  Copyright © 2017 Tahia. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import EventKit


class LocationDetailsView: UIView{
    
    var map: MKMapView!
    var locationManager : CLLocationManager!
    var locationSearchTable: UITableView!
    var possibleLocations :[MKMapItem] = [MKMapItem]() // currently data source
    
    var searchBar: UISearchBar!
    var selectedLocation : MKMapItem!
    
    var doneButton: UIButton!
    var searchedText : String!
    
    var alarm : EKAlarm!
    
    let backgroundBlue = UIColor(colorLiteralRed: 88.0/255.0, green: 159.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    let textBlue = UIColor(colorLiteralRed: 44.0/255.0, green: 123.0/255.0, blue: 214.0/255.0, alpha: 1.0)
    let green = UIColor(colorLiteralRed: 79.0/255.0, green: 210.0/255.0, blue: 98.0/255.0, alpha: 1.0)
    
    convenience init(map: MKMapView!){
        self.init(frame: CGRect.zero)
        self.map = map
        self.map.mapType = .standard
        self.isUserInteractionEnabled = true
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
        
        let location = CLLocationCoordinate2DMake(37.7767690, -122.4166160)
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        
        let dummyPlace = MKPlacemark(coordinate: location)
        let dummyItem = MKMapItem(placemark: dummyPlace)
        self.possibleLocations.append(dummyItem)
        
        
        self.map.setRegion(region, animated: false)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Work"
        annotation.subtitle = "1355 Market St"
        map.addAnnotation(annotation)
        
        self.addSubview(self.map)
        self.map.pinAll(v: self)
        
        let taprecognizer = UITapGestureRecognizer()
        taprecognizer.addTarget(self, action: #selector(createSearchView))
        self.map.addGestureRecognizer(taprecognizer)

    }
    
    
    
    func configureDoneButton(){
        doneButton.setImage(#imageLiteral(resourceName: "verification-mark"), for: .normal)
        doneButton.imageView?.height(h: 25)
        doneButton.imageView?.width(w: 25)
        doneButton.height(h: 50)
        doneButton.width(w: 50)
        doneButton.layer.cornerRadius = 25
        doneButton.layer.masksToBounds = true
        doneButton.backgroundColor = green
        doneButton.layer.borderWidth = 1
        doneButton.layer.borderColor = green.cgColor
        self.addSubview(doneButton)
        doneButton.pinCenter(v: self)
        doneButton.pinTop2Bottom(v: self, o: -25)
    }
    
    
    
    
    
    
    
    
    
    func createSearchView(){
        self.locationSearchTable = UITableView()
        self.locationSearchTable.register(UITableViewCell.self, forCellReuseIdentifier: "locationCell")
        self.locationSearchTable.delegate = self
        self.locationSearchTable.dataSource = self
        
        self.searchBar = UISearchBar()
        self.searchBar.barStyle = .default
        self.searchBar.placeholder = "Search for Location"
        self.searchBar.isTranslucent = false
        self.searchBar.backgroundColor = UIColor.gray
        self.searchBar.delegate = self
        
        self.addSubview(self.searchBar)
        self.searchBar.pinTop(v: self.map)
        self.searchBar.pinLeftRight(v: self)
    }
    
}

extension LocationDetailsView : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.map.showsUserLocation = true
            
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            map.setRegion(region, animated: true)
            
        }
    }
    
    
}


extension LocationDetailsView: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.possibleLocations.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        self.locationSearchTable.register(UITableViewCell.self, forCellReuseIdentifier: "locationCell")
        
        let selectedItem : MKMapItem = self.possibleLocations[indexPath.row]
        cell.textLabel?.text = selectedItem.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem : MKMapItem = self.possibleLocations[indexPath.row]
        
        self.locationSearchTable.removeFromSuperview()
        
        // now associate
        self.selectedLocation = self.possibleLocations[indexPath.row]
        self.alarm = EKAlarm()
        self.alarm.structuredLocation = EKStructuredLocation(mapItem: self.possibleLocations[indexPath.row])
        self.alarm.proximity = .enter
        
    }
    
}


extension LocationDetailsView : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        self.searchedText  = textSearched
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchBar.resignFirstResponder()
        
        guard let mapView = map else{return}
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = self.searchedText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        self.addSubview(self.locationSearchTable)
        self.locationSearchTable.pinTop2Bottom(v: self.searchBar)
        self.locationSearchTable.pinLeftRight(v: self)
        self.locationSearchTable.height(h: 150)
        
        
        search.start(completionHandler: { response, _ in
            guard let response = response else {return}
            
            let matchingItems = response.mapItems
            self.possibleLocations = matchingItems
            self.locationSearchTable.reloadData()
            
            
            
        })
        
    }
    
    
}
