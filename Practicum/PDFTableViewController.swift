//
//  PDFTableViewController.swift
//  Practicum
//
//  Created by dev on 3/4/19.
//  Copyright © 2019 Monmouth University. All rights reserved.
//

import UIKit

class PDFTableViewController: UITableViewController {
    
    var keyList :[String] = []
    //getFormFieldData()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFormFieldData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return keyList.count
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
                    
                    let GroupedFieldData = Dictionary(grouping: pdfFormData.fieldDataList ) { $0.altTitle }
                    print(GroupedFieldData.keys.sorted())
                    
                    self.keyList = GroupedFieldData.keys.sorted()
                    print(self.keyList)
                    
                    //self.seperateFieldData(data: pdfFormData)
                }
            }
        }
        task.resume();
        sleep(15)
        print("hello")
    }
    
    func seperateFieldData(data: pdfData){
        let GroupedFieldData = Dictionary(grouping: data.fieldDataList ) { $0.altTitle }
        print(GroupedFieldData.keys.sorted())
        
        keyList = GroupedFieldData.keys.sorted()
        print(keyList)
//        GroupedFieldData.keys.sorted().forEach{ section in
//            print(section)
//        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PDFSection", for: indexPath) as! PDFTableViewCell
        
        cell.sectionLabel.text = keyList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueToPDFFields", sender: self)
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueToPDFFields", let destination = segue.destination as? PDFFieldTableViewController {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                let keyForFields = keyList[indexPath.row]
                destination.key = keyForFields
            }
        }
    }
 

}
