//
//  PDFSectionPopoverViewController.swift
//  Practicum
//
//  Created by dev on 4/10/19.
//  Copyright © 2019 Monmouth University. All rights reserved.
//

import UIKit

class PDFSectionPopoverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var PDFSections: UITableView!
    
    var keyList: [String] = []
    var currentIndex: Int = 0
    
    var delegate: loadViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PDFSections.delegate = self
        PDFSections.dataSource = self
        
        self.PDFSections.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as! MyTestTableViewCell
        
        cell.sectionLabel.text = keyList[indexPath.row]
        cell.sectionLabel.lineBreakMode = .byWordWrapping
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hello is this thing working?")
        delegate?.loadScrollView(index: indexPath.row)
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
