//
//  CarData.swift
//  RegScrap
//
//  Created by Sebastian Bularca on 2020-02-07.
//  Copyright © 2020 Sebastian Bularca. All rights reserved.
//

import Foundation

struct CarDataToShow{
    
    var regNumber: String
    var brand: String
    var model: String
    var color: String
    var chasisNr: String
    var productionYear: String
    var modelYear: String
    var firstRegistration: String
    var origin: String
    var tax: String
    
    var carStatus: String
    var upplysningar: String
    var mileage: String
    var lastCheck: String
    var nextCheck: String

    var gearbox: String
    var fuel: String
    var traction: String
    var carType: String
    var chasis: String
    var engineCapacity: String
    var enginePower: String
    var topSpeed: String
    var consumptionCity: String
    var consumptionOutsideCity: String
    var mediumConsumption: String
    var sections: [String]
    var data: [String]
    
    init() {
        regNumber = ""
        brand = ""
        model = ""
        color = ""
        chasisNr = ""
        productionYear = ""
        modelYear = ""
        firstRegistration = ""
        origin = ""
        tax = ""
        
        carStatus = ""
        upplysningar = ""
        mileage = ""
        lastCheck = ""
        nextCheck = ""
        
        gearbox = ""
        fuel = ""
        traction = ""
        carType = ""
        chasis = ""
        engineCapacity = ""
        enginePower = ""
        topSpeed = ""
        consumptionCity = ""
        consumptionOutsideCity = ""
        mediumConsumption = ""
        
        sections = ["REGISTRATION NR", "PRODUCTION BRAND", "MODEL", "COLOR", "CHASIS NR.", "PRODUCTION DATE", "MODEL YEAR", "FIRST REGISTRATION", "ORIGIN", "TAX", "CAR STATUS", "UPPLYSNINGAR", "MILEAGE", "LAST CHECK", "NEXT CHECK", "GEARBOX", "FUEL", "TRACTION", "CAR TYPE", "CHASIS", "ENGINE CAPACITY", "ENGINE POWER", "TOP SPEED", "CITY", "OUTSIDE CITY", "OVERALL CONSUMPTION"]
        
        data = [String] (repeating: "", count: sections.count)
    }
}
