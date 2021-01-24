//
//  ViewController.swift
//  GMSampleApp
//
//  Created by K Madeve Gowda on 23/01/21.
//  Copyright © 2021 sheela. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ServiceManager.sharedManager.fetchGitCommits { (result) in
            print(result)
        }
    }


}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CommitCell") as? GitCell{

            cell.author.text = "Author\(indexPath.row)"
            cell.githash.text = "Hash123"
            cell.message.text = "Sample git message by author \(indexPath.row)"
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
