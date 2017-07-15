//
//  DSPViewModel.swift
//  FireBaseDemo
//
//  Created by Saurabh Yadav on 15/07/17.
//  Copyright © 2017 Saurabh Yadav. All rights reserved.
//

import UIKit

import FirebaseDatabase
import RxSwift
import RxCocoa

class DSPViewModel: NSObject {

    var specialityDriver = Driver<String>.just("")
    var nameDriver = Driver<String>.just("")
    var amountObservableDriver = Driver<String>.just("")
    
    var timePeriodSubject = PublishSubject<AmountValues>()
    
    var amountObservables: Observable<DoctorStatsStruct>!
    
    init(doctorID: String) {
        let doctorProfileRef = Database.database().reference(withPath: "doctorProfiles")
        let idDoctorProfileRef = doctorProfileRef.child(doctorID)
        let observableSnapshotProfile: Observable<DataSnapshot> = idDoctorProfileRef.queryOrderedByKey().rx.observe(.value)
        self.specialityDriver =  observableSnapshotProfile
            .map{data in
                return (data.value as? NSDictionary)?.value(forKey: "speciality") as! String
            }
            .asDriver(onErrorJustReturn: "")
        self.nameDriver =  observableSnapshotProfile
            .map{data in
                return (data.value as? NSDictionary)?.value(forKey: "name") as! String
            }
            .asDriver(onErrorJustReturn: "")
        
        let doctorStatsRef = Database.database().reference(withPath: "doctorStats")
        let idDoctorStatsRef = doctorStatsRef.child(doctorID)
        let observableSnapshotStats: Observable<DataSnapshot> = idDoctorStatsRef.queryOrderedByKey().rx.observe(.value)
        
        amountObservableDriver = timePeriodSubject
            .withLatestFrom(observableSnapshotStats) { timePeriod, statsSnapshot in
                for snapshotKeys in statsSnapshot.children {
                    if (snapshotKeys as! DataSnapshot).key == timePeriod.rawValue {
                        return String(describing: (snapshotKeys as! DataSnapshot).value as! Int) 
                    }
                }
                return ""
        }
        .asDriver(onErrorJustReturn: "")
    }
}

enum AmountValues: String {
    
    case dayAmountEarned
    case monthAmountEarned
    case yearAmountEarned
}
