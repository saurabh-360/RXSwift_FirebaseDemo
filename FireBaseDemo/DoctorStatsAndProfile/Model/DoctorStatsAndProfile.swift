//
//  DoctorStatsAndProfile.swift
//  FireBaseDemo
//
//  Created by Saurabh Yadav on 15/07/17.
//  Copyright © 2017 Saurabh Yadav. All rights reserved.
//

import UIKit


struct DoctorProfilesStructName {
    var name: String?
    init(profile: [String: Any]) {
        name = String(describing: profile["name"]!)
    }
}

struct DoctorProfilesStructSpeciality{
    var speciality: String?
    init(profile: [String: Any]) {
        speciality = String(describing: profile["speciality"]!)
    }
}

struct DoctorStatsStruct {
    var dayAmountEarned: String?
    var monthAmountEarned: String?
    var yearAmountEarned: String?
    
    init(stats: [String: Any]) {
        dayAmountEarned = String(describing: stats["dayAmountEarned"]!)
        monthAmountEarned = String(describing: stats["monthAmountEarned"]!)
        yearAmountEarned = String(describing: stats["yearAmountEarned"]!)
    }
}
