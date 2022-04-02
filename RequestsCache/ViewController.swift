//
//  ViewController.swift
//  RequestsCache
//
//  Created by Alexander Avdacev on 2.04.22.
//

import UIKit

class ViewController: UIViewController {
    let cellIdentifier = "Cell"
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero,
                                style: .plain)
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: cellIdentifier)
        return table
    }()
    
    var dataSource = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate      = self
        tableView.dataSource    = self
        
        Service.shared.fetchData { [weak self] (result) in
            switch result {
            case .success(posts: let posts):
                self?.dataSource = posts
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(error: let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.frame = view.bounds
    }    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        var content                 = cell?.defaultContentConfiguration()
        content?.text               = dataSource[indexPath.row].title
        content?.secondaryText      = dataSource[indexPath.row].body
        cell?.contentConfiguration  = content
//        cell?.textLabel?.text        = dataSource[indexPath.row].title
//        cell?.textLabel?.numberOfLines = 0
//        cell?.detailTextLabel?.text  = dataSource[indexPath.row].body
//        cell?.detailTextLabel?.numberOfLines = 0
//        cell?.backgroundColor        = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return cell!
    }
}

