//
//  PolicySupportViewController.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/11.
//

import UIKit

import SnapKit
import RealmSwift
import SkeletonView


class PolicySupportViewController: BaseViewController {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    
    /// variable
    let viewModel = PolicySupportViewModel()
    
    var fetchPage = 1
    
    /// Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let indexSet = NSMutableIndexSet()
        indexSet.add(0)
        tableView.reloadSections(indexSet as IndexSet, with: .automatic)
    }
    
    override func setupAttributes() {
        super.setupAttributes()
        settingTableView()
        NavigationAttribute()
        skeletonAttribute()     // Skeleton 화면 보여주면서 fetch 처리
        
        viewModel.realmService.fountRealmPath()
    }
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    /// Custom Func
    func fetchPolicyData(pageNation: Bool = false, page: Int = 1) {
        viewModel.featch(pageNation: pageNation, page: page) {
            self.tableView.reloadData()
        }
    }
    
    func NavigationAttribute() {
        navigationItem.title = "청년 정책"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(tapSettingButton))
    }

    @objc
    func tapSettingButton() {
        let vc = SettingViewController()
        transition(vc, transitionStyle: .push)
    }
}


// MARK: - DiffableTableView
extension PolicySupportViewController: UITableViewDataSource, UITableViewDelegate {
    
    func settingTableView() {
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.separatorStyle = .none
        tableView.register(PolicyTableViewViewCell.self, forCellReuseIdentifier: PolicyTableViewViewCell.reuseIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.policySectionDataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = viewModel.policySectionDataArray[section]
        switch data.cellType {
        case .onlyHeader:
            return 0
        case .newPolicy, .oldPolicy:
            return data.data!.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: PolicyTableViewViewCell.reuseIdentifier, for: indexPath) as? PolicyTableViewViewCell else {
            return UITableViewCell()
        }
        
        let type = viewModel.policySectionDataArray[indexPath.section].cellType
        
        switch type {
        case .onlyHeader:
            return cell
        case .newPolicy, .oldPolicy:
            let data = viewModel.policySectionDataArray[indexPath.section].data![indexPath.item]
            cell.configure(policyData: data)
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let type = viewModel.policySectionDataArray[section].cellType
        
        switch type {
        case .onlyHeader:
            let headerView = PolicySupportHeaderView()
            return headerView
            
        case .newPolicy, .oldPolicy:
            let headerView = PolicySupportScetionHeaderFooterView(type: .header(type))
            headerView.titleLabel.text = type.title
            return headerView
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let type = viewModel.policySectionDataArray[section].cellType
        
        switch type {
        case .onlyHeader:
            let footerView = PolicySupportScetionHeaderFooterView(type: .footer)
            footerView.delegate = self
            return footerView
        default:
            return nil
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset_y = scrollView.contentOffset.y
        let tableViewContentSize = tableView.contentSize.height
        let pagination_y = tableViewContentSize * 0.1
        
        if contentOffset_y > tableViewContentSize - pagination_y {
            guard !viewModel.isPagenating else { return }
            
            if fetchPage < UserDefaults.standard.integer(forKey: "totalCount")/100 + 1 {
                fetchPage += 1
                fetchPolicyData(pageNation: true, page: fetchPage)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.policySectionDataArray[indexPath.section].data![indexPath.row]
        viewModel.realmService.updateClickData(data: data)
        
        
        let vc = PolicySupoortDetailViewController(policyid: data.policyID)
        transition(vc, transitionStyle: .push)
    }
}


// MARK: - SkeletonView 화면 만들기
extension PolicySupportViewController: SkeletonTableViewDataSource {
    
    func skeletonAttribute() {
        tableView.isSkeletonable = true
        
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .lightGray), animation: animation, transition: .crossDissolve(0.5))
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.viewModel.featch(pageNation: false, page: 1) {
                self.tableView.stopSkeletonAnimation()
                self.tableView.hideSkeleton(reloadDataAfter: true)
                self.tableView.reloadData()
            }
        }
    }
    
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return viewModel.policySectionDataArray.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = viewModel.policySectionDataArray[section]
        switch data.cellType {
        case .onlyHeader:
            return 0
        case .newPolicy, .oldPolicy:
            return data.data!.count

        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: PolicyTableViewViewCell.reuseIdentifier, for: indexPath) as! PolicyTableViewViewCell
        let type = viewModel.policySectionDataArray[indexPath.section].cellType
        
        switch type {
        case .onlyHeader:
            return cell
        case .newPolicy, .oldPolicy:
            let data = viewModel.policySectionDataArray[indexPath.section].data![indexPath.item]
            cell.configure(policyData: data)
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return PolicyTableViewViewCell.reuseIdentifier
    }
}


// MARK: - CellDelegate
extension PolicySupportViewController: CellDelegate {
    func swipeCell(indexPath: IndexPath) {
        let data = viewModel.policySectionDataArray[indexPath.section].data![indexPath.row]
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
            guard let cell = self.tableView.cellForRow(at: indexPath) as? PolicyTableViewViewCell else{
                return
            }
            cell.contentView.alpha = 0
        }, completion: { _ in self.tableView.performBatchUpdates({
            self.viewModel.realmService.updateHiddenData(data: data)
            self.viewModel.policySectionDataArray[indexPath.section].data?.remove(at: indexPath.item)
            
            // Deleting the row in the tableView
            if self.tableView.numberOfRows(inSection: indexPath.section) > 1 {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                let indexSet = NSMutableIndexSet()
                indexSet.add(indexPath.section)
                self.tableView.deleteSections(indexSet as IndexSet, with: .fade)
                self.viewModel.policySectionDataArray.remove(at: indexPath.section)
            }
            self.fetchPolicyData()
        })})
    }
}


// MARK: - taphiddenButton
extension PolicySupportViewController: TapActionDelegate {
    func tapActionButton() {
        let vc = HiddenPolicySupportViewController()
        transition(vc, transitionStyle: .push)
    }
}
