//
//  TaskListVC.swift
//  RX-Tutorial
//
//  Created by David Adel on 07/04/2021.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListVC: UIViewController {

    @IBOutlet weak var prioritySegmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    private var tasks = BehaviorRelay<[TaskModel]>(value: [])
    private var filteredTasks = [TaskModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }


    func setupViews() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
    }
    
    @IBAction func addTapped(_ sender: Any) {
        let vc = AddTaskVC()
        vc.taskSubjectObservable.subscribe(onNext: { [unowned self] task in
            
            let priority = Priority(rawValue: self.prioritySegmentControl.selectedSegmentIndex - 1)
            
            let newValue = self.tasks.value + [task]
            self.tasks.accept(newValue)
            
            self.filterTasks(by: priority)
            
            
        }).disposed(by: disposeBag)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func priorityValueChanged(_ sender: UISegmentedControl) {
        let priority = Priority(rawValue: sender.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }
    
    private func filterTasks(by priority: Priority?) {
        if priority == nil {
            self.filteredTasks = self.tasks.value
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority }
            }.subscribe(onNext : { [weak self] tasks in
                self?.filteredTasks = tasks
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            }).disposed(by: disposeBag)
        }
    }
    

}

extension TaskListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if( !(cell != nil))
        {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        }
        
        cell!.textLabel?.text = filteredTasks[indexPath.row].title
        return cell!
    }
    
    
}
