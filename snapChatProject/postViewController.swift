//
//  postViewController.swift
//  snapChatProject
//
//  Created by Jim Bai on 2017/3/13.
//  Copyright © 2017年 org.iosdecal. All rights reserved.
//

import UIKit

class postViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var postTableView: UITableView!
    @IBOutlet var postButton: UIButton!
    @IBOutlet var feedSelected: UILabel!
    var selectedFeed = 0
    var selectedPic:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        postTableView.delegate = self
        postTableView.dataSource = self
        feedSelected.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return threadNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postFeedCell") as! postTableViewCell
        let feedName = threadNames[indexPath.row]
        cell.postFeedSection.text = feedName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        feedSelected.text = threadNames[indexPath.row]
        selectedFeed = indexPath.row
    }
    
    @IBAction func pressPostButton(_ sender: UIButton) {
        if feedSelected.text != "" {
            if let image = selectedPic {
                threads[threadNames[selectedFeed]]?.append([image:CFAbsoluteTimeGetCurrent()])
                threadRead[threadNames[selectedFeed]]?.append(0)
  
                let alertController = UIAlertController(title: "Success", message:
                    "You have posted a picture!", preferredStyle: UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: {(_)in
                    _ = self.navigationController?.popViewController(animated: true)
                })
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
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
