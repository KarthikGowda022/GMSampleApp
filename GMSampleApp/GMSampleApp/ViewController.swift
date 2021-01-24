//
//  ViewController.swift
//  GMSampleApp
//
//  Created by K Madeve Gowda on 23/01/21.
//  Copyright © 2021 sheela. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var gitCommits = [GitNode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Constants.Views.navigationTitle
        // Do any additional setup after loading the view.
        ServiceManager.sharedManager.fetchGitCommits { (result) in
            if let list = result {
                self.gitCommits = list
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }


}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gitCommits.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Views.cellIdentifier) as? GitCell{
            
            let commitDetails = gitCommits[indexPath.row]
            cell.githash.text = commitDetails.sha
            cell.author.text = commitDetails.commit.author.name
            cell.message.text = commitDetails.commit.message
            
            return cell
        }
        
        return UITableViewCell()
    }
}

class GitCell:UITableViewCell{

    var id: String!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var githash: UILabel!
    @IBOutlet weak var message: UILabel!
}
