//
//  ViewController.swift
//  DevPractice
//
//  Created by Tony Mu on 8/11/21.
//

import UIKit
import SnapKit

class DisplayListController: UIViewController {
    
    var viewModel: DisplayListViewModelPortocol!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.regisger(cellClass: PhotoTableViewCell.self)
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.loadList()
    }
    
    private func setup() {
        viewModel = DisplayListViewModel()
        viewModel.delegate = self
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension DisplayListController: UITableViewDelegate ,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.cellId) as! PhotoTableViewCell
        let item = getItem(indexPath: indexPath)
        cell.photoTitle.text = item.name
        cell.photoDetail.text = item.description
        return cell
    }
    
    private func getItem(indexPath: IndexPath) -> Photo {
        return viewModel.items[indexPath.row]
    }
}

extension DisplayListController: DisplayListViewModelDelegate {
    func displayError(_ error: ListError) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.presentMessage(message: error.localizedMessage)
        }
    }
    
    func didLoadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

extension UIViewController {
    func presentMessage(message: String, title: String = "", completion:(()->Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        alertController.present(self, animated: true, completion: completion)
    }
}

