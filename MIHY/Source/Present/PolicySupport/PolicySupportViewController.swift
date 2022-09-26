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
    
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    
    /// variable
    let viewModel = PolicySupportViewModel()
    
    
    /// Life Cycle
    override func setupAttributes() {
        super.setupAttributes()
        settingTableView()
        
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            showAlertMessage(title: "Document 파일 통로를 못찾았습니다.")
            return
        }
        print("❤️document path ==== \(path)❤️")
        
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
    
}


// MARK: - DiffableTableView
extension PolicySupportViewController: UITableViewDataSource, UITableViewDelegate {
    
    func settingTableView() {
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.register(PolicyTableViewViewCell.self, forCellReuseIdentifier: PolicyTableViewViewCell.reuseIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = viewModel.realmService.userData.first?.data.makeArray() else {return 0}
        
        if section == 0 {
            return 0
        } else {
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: PolicyTableViewViewCell.reuseIdentifier, for: indexPath) as? PolicyTableViewViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.section == 1 {
            guard let data = viewModel.realmService.userData.first?.data.makeArray()[indexPath.item] else {return UITableViewCell() }
            cell.configure(policyData: data)
            cell.indexPath = indexPath
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let headerView = PolicySupportHeaderView()
            headerView.backgroundColor = .orange
            return headerView
        }
        else {
            let headerView = PolicySupportScetionHeaderView()
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 250
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
}


// MARK: - CellDelegate
extension PolicySupportViewController: CellDelegate {
    func swipeCell(indexPath: IndexPath) {
//        guard let data = viewModel.realmService.userData.first?.data.makeArray()[indexPath.item] else {return}

        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
            guard let cell = self.tableView.cellForRow(at: indexPath) as? PolicyTableViewViewCell else{
                return
            }
            cell.contentView.alpha = 0
        }, completion: {_ in self.tableView.performBatchUpdates({
            self.viewModel.realmService.updateHiddenData(item: indexPath.item)
            self.tableView.reloadData()
        })})
    }
}



