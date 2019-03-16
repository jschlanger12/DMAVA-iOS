//
//  ResourceViewController.swift
//  Practicum
//
//  Created by dev on 3/3/19.
//  Copyright © 2019 Monmouth University. All rights reserved.
//

import UIKit

public class ResourceViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        getFormFieldData()
        // Do any additional setup after loading the view.
    }
    
    func getFormFieldData(){
        let urlString =  "https://g6an8imw21.execute-api.us-east-2.amazonaws.com/default/dmava_get_pdf_json?key1=application_2.pdf"
        
        let formDataURL = URL(string: urlString)
        
        let task = URLSession.shared.dataTask(with: formDataURL!){ (data, response, error) in
            if error == nil{
                do {
                    guard let pdfFormData = try? JSONDecoder().decode(pdfData.self, from: data!) else {
                        print("failed")
                        return
                    }
                    self.seperateFieldData(data: pdfFormData)
                }
            }
        }
        task.resume();
    }
    
    func seperateFieldData(data: pdfData){
        let GroupedFieldData = Dictionary(grouping: data.fieldDataList ) { $0.altTitle }
        print(GroupedFieldData.keys.sorted())
        
        GroupedFieldData.keys.sorted().forEach{ section in
            print(section)
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
