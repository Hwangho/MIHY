//
//  PolicySupportViewController.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/11.
//

import UIKit

import SnapKit
import RealmSwift


class PolicySupportViewController: BaseViewController {
    
    
    let tableView = UITableView()
    /// variable
    let viewModel = PolicySupportViewModel()
    
    
    /// Life Cycle
    override func setupAttributes() {
        super.setupAttributes()
        
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            showAlertMessage(title: "Document 파일 통로를 못찾았습니다.")
            return
        }
        print("❤️document path ==== \(path)❤️")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.register(PolicyTableViewViewCell.self, forCellReuseIdentifier: PolicyTableViewViewCell.reuseIdentifier)
        
    }
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setData() {
        viewModel.realmService.featchData()
    }
    

    /// Custom Func
    func server() {
    }

}




// MARK: - DiffableTableView
extension PolicySupportViewController: UITableViewDataSource, UITableViewDelegate, CellDelegate {
    func swipeCell(indexPath: IndexPath) {
        print("-----> index \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = viewModel.realmService.userData.first?.data.makeArray() else {return 0}
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: PolicyTableViewViewCell.reuseIdentifier, for: indexPath) as? PolicyTableViewViewCell else {
            return UITableViewCell()
        }
        
        guard let data = viewModel.realmService.userData.first?.data.makeArray()[indexPath.item] else {return UITableViewCell() }
        cell.configure(policyData: data)
        cell.tag = indexPath.item
        
        
        
        return cell
    }
    
    
  

    
}






class PolicySupportCollectionViewwHeader: UICollectionReusableView {
    
}



