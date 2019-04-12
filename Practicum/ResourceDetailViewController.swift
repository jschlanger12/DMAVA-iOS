//
//  ResourceDetailViewController.swift
//  Practicum
//
//  Created by dev on 4/1/19.
//  Copyright © 2019 Monmouth University. All rights reserved.
//

import UIKit

class ResourceDetailViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var currentResource: resource = resource.init(id: "", description: "", getURL: "", pdf: "", title: "")
    
    @IBOutlet weak var pdfViewButton: UIButton!
    @IBOutlet weak var fillPDFButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = currentResource.description
        
        pdfViewButton.layer.cornerRadius = 8;
        fillPDFButton.layer.cornerRadius = 8;
        // Do any additional setup after loading the view.
    }
    
    @IBAction func viewPDF(_ sender: Any) {
        if let url = URL(string: currentResource.pdf) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func fillPDF(_ sender: Any) {
        self.performSegue(withIdentifier: "fillPDFSegue", sender: self)

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "fillPDFSegue", let destination = segue.destination as? MyViewController {
            destination.currentURL = currentResource.getURL
//            let resource = resourceList[index]
//            destination.currentResource = resource
        }
    }
 

}
