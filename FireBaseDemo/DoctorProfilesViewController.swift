//
//  DoctorProfilesViewController.swift
//  FireBaseDemo
//
//  Created by Saurabh Yadav on 15/07/17.
//  Copyright © 2017 Saurabh Yadav. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

class DoctorProfilesViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var specialityLabel: UILabel!
    @IBOutlet weak var amountEarnedLabel: UILabel!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var dayButton: UIButton!
    let disposeBag = DisposeBag()
    var model: DSPViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = DSPViewModel.init(doctorID: "id")
        model.nameDriver.drive(nameLabel.rx.text).disposed(by: disposeBag)
        model.specialityDriver.drive(self.specialityLabel.rx.text).disposed(by: disposeBag)
        model.amountObservableDriver.drive(self.amountEarnedLabel.rx.text).disposed(by: disposeBag)
        self.setupButtons()
    }

    func setupButtons() {
        
        monthButton.rx.tap.subscribe(onNext: {
            self.model.timePeriodSubject.onNext(AmountValues.monthAmountEarned)
        })
        
        yearButton.rx.tap.subscribe(onNext: {
            self.model.timePeriodSubject.onNext(AmountValues.yearAmountEarned)
        })
        dayButton.rx.tap.subscribe(onNext: {
            self.model.timePeriodSubject.onNext(AmountValues.dayAmountEarned)
        })
    }
}
