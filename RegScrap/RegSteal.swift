//
//  RegSteal.swift
//  RegScrap
//
//  Created by Sebastian Bularca on 2020-02-27.
//  Copyright © 2020 Sebastian Bularca. All rights reserved.
//

import Foundation


class RegSteal {
    
    static var extractedCarData: CarDataToShow = CarDataToShow()
    
    var carFound = false
    
    func submitRegistration(s: String){
        print("Registration Number Submitted is \(s)")
        self.StealDataAsync(regNr: s)
    }
    
    func StealDataAsync(regNr: String){
        
        let myURLString = "https://biluppgifter.se/fordon/\(regNr)"
        var myHTMLString = ""
        
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }

        do {
            myHTMLString = try String(contentsOf: myURL, encoding: .utf8)
            //print("HTML : \(myHTMLString)")
            SortData(regNr: regNr, data: myHTMLString)
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    func SortData(regNr: String, data: String){
        
        var dataArray = data.components(separatedBy: "\n")
        dataArray.insert("", at: 0)
        //print(data, "\n")
        var carDataToShow = CarDataToShow()
        
        carDataToShow.regNumber = regNr
        
        let nullTest = dataArray[dataArray.firstIndex(where: { $0.contains("<li>Fabrikat <span>")}) ?? 0]
        if (nullTest) == "" {
            print ("Car registration number \(nullTest) not present in the database\n")
            carFound = false;
        } else {
            carFound = true
        }
        
        //CafInfo
        
        carDataToShow.brand = dataArray[dataArray.firstIndex(where: { $0.contains("<li>Fabrikat <span>")}) ?? 0].replacingOccurrences(of: "Fabrikat ", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "" ,options: .regularExpression, range: nil)
        
        carDataToShow.model = dataArray[dataArray.firstIndex(where: { $0.contains("<li>Modell <span>")}) ?? 0].replacingOccurrences(of: "Modell", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "" ,options: .regularExpression, range: nil)
        
        carDataToShow.color = dataArray[dataArray.firstIndex(where: { $0.contains( "<li>Färg <span>")}) ?? 0].replacingOccurrences(of: "Färg ", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil)
        
        carDataToShow.chasisNr = dataArray[dataArray.firstIndex(where: { $0.contains( "Chassinr / VIN ")}) ?? 0].replacingOccurrences(of: "Chassinr / VIN ", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil)
        
        carDataToShow.productionYear = dataArray[((dataArray.firstIndex(where: { $0.contains( "<strong>Tillverkad")}) ?? 1) - 1)].replacingOccurrences(of: "class=\"pull-right date\"", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>.]", with: "", options: .regularExpression, range: nil)
        
        carDataToShow.modelYear = dataArray[dataArray.firstIndex(where: { $0.contains("Fordonsår / Modellår ")}) ?? 0].replacingOccurrences(of: "Fordonsår / Modellår ", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "" ,options: .regularExpression, range: nil).replacingOccurrences(of: "  ", with: "/")
        
        carDataToShow.firstRegistration = dataArray[dataArray.firstIndex(where: { $0.contains( "Först registrerad ")}) ?? 0].replacingOccurrences(of: "Först registrerad ", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil)
        
        carDataToShow.origin = dataArray[dataArray.firstIndex(where: { $0.contains( "Fordonet tillverkat i")}) ?? 0].replacingOccurrences(of: "Fordonet tillverkat i ", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "small", with: "").replacingOccurrences(of: "[/<>.]", with: "", options: .regularExpression, range: nil)
        
        carDataToShow.tax = dataArray[dataArray.firstIndex(where: { $0.contains( "Årlig skatt ")}) ?? 0].replacingOccurrences(of: "Årlig skatt ", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil)
        
        //Status
        
        carDataToShow.carStatus = dataArray[dataArray.firstIndex(where: { $0.contains( "<li>Status <span>")}) ?? 0].replacingOccurrences(of: "<li>Status <span>", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil)
        
        let credit = dataArray[dataArray.firstIndex(where: { $0.contains( "<li>Kreditköp ")}) ?? 0].replacingOccurrences(of: "<li>Kreditköp ", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil)
            
        let leasing = dataArray[dataArray.firstIndex(where: { $0.contains( "<li>Leasad ")}) ?? 0].replacingOccurrences(of: "<li>Leasad ", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil)
            
        carDataToShow.upplysningar = "Credit - \(credit)" + " / " + "Leasing - \(leasing)"
        
        carDataToShow.lastCheck = dataArray[dataArray.firstIndex(where: { $0.contains( "Senast besiktigad ")}) ?? 0].replacingOccurrences(of: "Senast besiktigad ", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil)
        
        carDataToShow.mileage = dataArray[dataArray.firstIndex(where: { $0.contains( "mil</span>")}) ?? 0].replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil)
        
        carDataToShow.nextCheck = dataArray[dataArray.firstIndex(where: { $0.contains( "Nästa besiktning senast")}) ?? 0].replacingOccurrences(of: "Nästa besiktning senast", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil)
        
        //Technical Information
        
        carDataToShow.gearbox = dataArray[dataArray.firstIndex(where: { $0.contains( "<li>Växellåda ")}) ?? 0].replacingOccurrences(of: "Växellåda ", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil)
        
        carDataToShow.fuel = dataArray[dataArray.firstIndex(where: { $0.contains( "Drivmedel <span id=\"technical-data-fuel-type\"")}) ?? 0].replacingOccurrences(of: "Drivmedel <span id=\"technical-data-fuel-type\"", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil)
        
        let fourWheelDrive = dataArray[dataArray.firstIndex(where: { $0.contains( "<li>Fyrhjulsdrift ")}) ?? 0].replacingOccurrences(of: "<li>Fyrhjulsdrift ", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil)
        print (fourWheelDrive)
        carDataToShow.traction = (fourWheelDrive == "Nej") ? "Two-Wheel Drive" : "Four-Wheel Drive"
        
        carDataToShow.carType = ""
        
        carDataToShow.chasis = dataArray[dataArray.firstIndex(where: { $0.contains( "Kaross <span id=\"technical-data-chassi\"")}) ?? 0].replacingOccurrences(of: "Kaross <span id=\"technical-data-chassi\"", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil)
        
        carDataToShow.engineCapacity = dataArray[dataArray.firstIndex(where: { $0.contains( "<li>Motorvolym ")}) ?? 0].replacingOccurrences(of: "Motorvolym ", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "sup", with: "")
        
        carDataToShow.enginePower = dataArray[dataArray.firstIndex(where: { $0.contains( "<li>Motoreffekt <span>")}) ?? 0].replacingOccurrences(of: "Motoreffekt ", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "  ", with: "/")
        
        carDataToShow.topSpeed = dataArray[dataArray.firstIndex(where: { $0.contains( "<li>Toppfart ")}) ?? 0].replacingOccurrences(of: "Toppfart ", with: "").replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil)
        
        carDataToShow.consumptionCity = ""
        
        carDataToShow.consumptionOutsideCity = ""
        
        carDataToShow.mediumConsumption = dataArray[dataArray.firstIndex(where: { $0.contains( "liter/100km</span></li>")}) ?? 0].replacingOccurrences(of: "li", with: "").replacingOccurrences(of: "span", with: "").replacingOccurrences(of: "[/<>]", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "ter100km", with: "litter/100km")
        
        
        
        
        carDataToShow.data = [carDataToShow.regNumber, carDataToShow.brand, carDataToShow.model, carDataToShow.color, carDataToShow.chasisNr, carDataToShow.productionYear, carDataToShow.modelYear, carDataToShow.firstRegistration, carDataToShow.origin, carDataToShow.tax, carDataToShow.carStatus, carDataToShow.upplysningar, carDataToShow.mileage, carDataToShow.lastCheck, carDataToShow.nextCheck, carDataToShow.gearbox, carDataToShow.fuel, carDataToShow.traction, carDataToShow.carType, carDataToShow.chasis, carDataToShow.engineCapacity, carDataToShow.enginePower, carDataToShow.topSpeed, carDataToShow.consumptionCity, carDataToShow.consumptionOutsideCity, carDataToShow.mediumConsumption]
        
            RegSteal.extractedCarData = carDataToShow
            //print (carDataToShow)
    }
}
