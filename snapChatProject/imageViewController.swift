//
//  imageViewController.swift
//  snapChatProject
//
//  Created by Jim Bai on 2017/3/14.
//  Copyright © 2017年 org.iosdecal. All rights reserved.
//

import UIKit

class imageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet var imageTable: UITableView!
    var selectedImage:UIImage?
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        imageTable.delegate = self
        imageTable.dataSource = self
        
        refreshControl.addTarget(self,
                                 action: #selector(refreshOptions(sender:)),
                                 for: .valueChanged)
        imageTable.refreshControl = refreshControl

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func refreshOptions(sender: UIRefreshControl) {
        imageTable.reloadData()
        sender.endRefreshing()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return threadNames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        let feed = threadNames[section]
        if let imageList = threads[feed] {

                return imageList.count
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! imageTableViewCell
        var count = 0
        cell.username.text = "Jim"
        let feed = threadNames[indexPath.section]
        if let imageList = threads[feed] {
            for elem in imageList {
                for image in elem.keys {
                    if count == indexPath.row {
                        cell.imageLink = image
                        let min = UInt((CFAbsoluteTimeGetCurrent() - elem[image]!)/60)
                        cell.postTime.text = String(format: "%d minutes ago", min)
                        if threadRead[threadNames[indexPath.section]]?[indexPath.row] == 1 {
                            cell.readBit.image = UIImage(named: "read")
                        } else {
                            cell.readBit.image = UIImage(named: "unread")
                        }
                        return cell
                    }
                    count = count + 1
                }
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return threadNames[section]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! imageTableViewCell
        if cell.readBit.image != UIImage(named: "read") {
            cell.readBit.image = UIImage(named: "read")
            threadRead[threadNames[indexPath.section]]?[indexPath.row] = 1
            selectedImage = cell.imageLink
            performSegue(withIdentifier: "cellToImageDisplay", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "cellToImageDisplay" {
                if let dest = segue.destination as? showPhotoViewController {
                    if let image = selectedImage {
                        dest.image = image
                    }
                    
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
