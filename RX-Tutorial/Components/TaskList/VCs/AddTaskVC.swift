//
//  AddTaskVC.swift
//  RX-Tutorial
//
//  Created by David Adel on 07/04/2021.
//

import UIKit
import RxSwift

class AddTaskVC: UIViewController {
    
    private let taskSubject = PublishSubject<TaskModel>()
    
    var taskSubjectObservable: Observable<TaskModel> {
        return taskSubject.asObservable()
    }
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func saveTapped(_ sender: Any) {
        guard let priority = Priority(rawValue: self.segmentControl.selectedSegmentIndex),
              let title = self.textField.text else {
            return
        }
        
        let task = TaskModel(title: title, priority: priority)
        taskSubject.onNext(task)
        
        self.dismiss(animated: true, completion: nil)
    }
}
