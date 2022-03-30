//
//  AddAlertViewController.swift
//  DrinkWaterNotificationApp
//
//  Created by 양준식 on 2022/03/30.
//

import UIKit

class AddAlertViewController: UIViewController{
    
    var pickedDate: ((_ date: Date) -> Void)?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //단순 취소 작업
    @IBAction func dismissButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated:true, completion: nil)
    }
    
    //부모뷰에 detePicker로 선택한 값을 전달하고 dismiss
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        pickedDate?(datePicker.date)
        self.dismiss(animated:true, completion: nil)
    }
}
