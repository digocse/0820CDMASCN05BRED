//
//  SecondVC.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 23/10/20.
//

import UIKit


class AccountBalanceVC: UIViewController {
    
    @IBOutlet weak var timeLineTableView: UITableView!

    private var controller: AccountBalanceController = AccountBalanceController()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AccountBalanceVC----viewDidLoad")
        // Do any additional setup after loading the view.
    
        self.timeLineTableView.register(UINib(nibName: "ExtratoCell", bundle: nil), forCellReuseIdentifier: "ExtratoCell")
        
        self.controller.loadLancamentos { (result, error) in
        
            if result {
                self.timeLineTableView.delegate = self
                self.timeLineTableView.dataSource = self
                self.timeLineTableView.separatorStyle = .none
            }else{
                print("======deu erro \(error)")
            }
        }
    }
}

extension AccountBalanceVC: UITableViewDelegate,  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.controller.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ExtratoCell? = tableView.dequeueReusableCell(withIdentifier: "ExtratoCell", for: indexPath) as? ExtratoCell
        
        self.controller.loadCurrentLancamentoElement(index: indexPath.row)
        
        cell?.setup(value:self.controller.lancamentoElement)
        return cell ?? UITableViewCell()
    }
}
