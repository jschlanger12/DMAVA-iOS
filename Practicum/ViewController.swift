//
//  ViewController.swift
//  Practicum
//
//  Created by dev on 3/26/19.
//  Copyright © 2019 Monmouth University. All rights reserved.
//

import UIKit
import FirebaseFirestore
import SideMenu


class hotlineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var panGesture  = UIPanGestureRecognizer()
    var edgeGesture = [UIScreenEdgePanGestureRecognizer]()
    
    var hotlineList: [hotline] = []
    var index: Int = 0
    let cellSpacingHeight: CGFloat = 10

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.rowHeight = 75.0
        self.tableView.tableFooterView = UIView()
        
        getHotlines()
        
        edgeGesture = SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.view)
        panGesture = SideMenuManager.default.menuAddPanGestureToPresent(toView: self.view)
        
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuAllowPushOfSameClassTwice = false
        SideMenuManager.default.menuShadowRadius = 0

        // Do any additional setup after loading the view.
    }
    
    func getHotlines(){
        let db = Firestore.firestore()
        
        db.collection("hotlines").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let currentHotline = hotline.init(id: document.documentID, description: document.data()["desc"]! as! String, phone: document.data()["phone"]! as! String, title: document.data()["title"]! as! String, webURL: document.data()["webUrl"]! as! String)
                    self.hotlineList.append(currentHotline)
                    print("\(document.documentID) => \(document.data())")
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        self.performSegue(withIdentifier: "hotlineDetailSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return hotlineList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! TableViewCell
        
        cell.titleLabel.text = hotlineList[indexPath.section].title
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        
        cell.clipsToBounds = false
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "hotlineDetailSegue", let destination = segue.destination as? HotlineDetailViewController {
            
            let hotline = hotlineList[index]
            destination.desc = hotline.description
            destination.name = hotline.title
            destination.phone = hotline.phone
            destination.webURL = hotline.webURL
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
