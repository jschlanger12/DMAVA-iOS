//
//  MyViewController.swift
//  Practicum
//
//  Created by dev on 3/4/19.
//  Copyright © 2019 Monmouth University. All rights reserved.
//

import UIKit
import M13Checkbox

class MyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    @IBOutlet weak var pdfSections: UITableView!
    @IBOutlet weak var pdfScrollSectionFields: UIScrollView!
    
    var testButton = UIButton()
    var keyList: [String] = []
    var dictFieldData: [String:[formData]] = [:]
    var currentFields: [formData] = []
    var currentKey: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pdfSections.delegate = self
        pdfSections.dataSource = self
        
        pdfScrollSectionFields.delegate = self
        
        self.view.backgroundColor = UIColor.gray
        getFormFieldData()
    }
    
    func scrollViewDidScroll(pdfScrollSectionFields: UIScrollView) {
            pdfScrollSectionFields.contentOffset.x = 0
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
                    
                    self.dictFieldData = GroupedFieldData
                    
                    self.keyList = GroupedFieldData.keys.sorted()
                    print(self.keyList)
                }
            }
        }
        task.resume();
        sleep(20)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keyList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as! MyTestTableViewCell
        
        cell.sectionLabel.text = keyList[indexPath.row]
        cell.sectionLabel.lineBreakMode = .byWordWrapping
        //cell.sectionLabel.textAlignment = .center
        
        return cell
    }
    
    func getAllTextFields(fromView view: UIView)-> [UITextField] {
        return view.subviews.compactMap { (view) -> [UITextField]? in
            if view is UITextField{
                return [(view as! UITextField)]
            } else {
                return getAllTextFields(fromView: view)
            }
            }.flatMap({$0})
    }
    
    func getAllCheckboxes(fromView view: UIView)-> [M13Checkbox] {
        return view.subviews.compactMap { (view) -> [M13Checkbox]? in
            if view is M13Checkbox{
                return [(view as! M13Checkbox)]
            } else {
                return getAllCheckboxes(fromView: view)
            }
            }.flatMap({$0})
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let currentViewTextFields = getAllTextFields(fromView: pdfScrollSectionFields)
        let currentViewCheckboxes = getAllCheckboxes(fromView: pdfScrollSectionFields)
        var index = 0
        
        currentViewTextFields.forEach{ textfield in
            dictFieldData[currentKey]![index].fieldValue = textfield.text!
            index+=1
        }
        
        index = 0
        currentViewCheckboxes.forEach{ checkbox in
            
            print(checkbox.checkState)
            if(checkbox.checkState == .checked){
                dictFieldData[currentKey]![index].fieldValue = "true"
            }
            index+=1
        }
        
        
        
        print("Button tapped")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pdfScrollSectionFields.subviews.forEach({ $0.removeFromSuperview() })
        currentFields = []
        currentKey = keyList[indexPath.row]
        var stackArray: [UIStackView] = []
        dictFieldData[keyList[indexPath.row]]!.forEach{ field in
            currentFields.append(field)
            if(field.fieldType == "Text"){
                stackArray.append(createLabelsAndFields(label: createLabel(text: field.title), field: createTextField(fieldText: field.fieldValue), type: "Text"))
                createFinalStackView(stackArray: stackArray)
            }else if(field.fieldType == "Button"){
                stackArray.append(createLabelsAndFields(label: createLabel(text: field.title), field: createCheckBox(state: field.fieldValue), type: "Button"))
                createFinalStackView(stackArray: stackArray)
            }
        }
    }
    
    func createFinalStackView(stackArray: [UIStackView]){
        let stackView = UIStackView()
        
        stackArray.forEach{ stack in
            stackView.addArrangedSubview(stack)
        }
        
        testButton.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
        testButton.backgroundColor = .green
        testButton.setTitle("Save Section", for: .normal)
        testButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(testButton)
        
        pdfScrollSectionFields.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: pdfScrollSectionFields.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: pdfScrollSectionFields.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: pdfScrollSectionFields.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: pdfScrollSectionFields.bottomAnchor)
            ])
        
        stackView.widthAnchor.constraint(equalTo: pdfScrollSectionFields.widthAnchor).isActive = true
    }
    
    func createLabelsAndFields(label: UILabel, field: UIView, type: String) -> UIStackView{
        
        let LFStackView = UIStackView()

        LFStackView.addArrangedSubview(label)
        LFStackView.addArrangedSubview(field)
        
        if(type == "Text"){
            LFStackView.axis = .vertical
        } else if(type == "Button"){
            LFStackView.axis = .horizontal
        }
        LFStackView.distribution = .fillEqually
        LFStackView.alignment = .fill
        LFStackView.spacing = 5
        LFStackView.translatesAutoresizingMaskIntoConstraints = false
        LFStackView.center.x = pdfScrollSectionFields.bounds.midX
        pdfScrollSectionFields.addSubview(LFStackView)
        
        let viewsDictionary = ["stackView":LFStackView]
        let stackView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[stackView]-20-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let stackView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[stackView]-30-|", options: NSLayoutConstraint.FormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
        
        pdfScrollSectionFields.addConstraints(stackView_V)
        pdfScrollSectionFields.addConstraints(stackView_H)
        
        return LFStackView
    }
    
    func createLabel(text: String) -> UILabel {
        let lbl = UILabel()
        var labelText = text
        
        lbl.textAlignment = .center //For center alignment
        if(text.contains("_")){
            let index = text.firstIndex(of: "_") ?? text.endIndex
            let beginning = text[..<index]
            labelText = String(beginning)
        }
        lbl.text = labelText
        lbl.textColor = .black
        //lbl.backgroundColor = .lightGray//If required
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.numberOfLines = 0 //If you want to display only 2 lines replace 0(Zero) with 2.
        lbl.lineBreakMode = .byWordWrapping //Word Wrap
        lbl.sizeToFit()//If required

        lbl.center.x = pdfScrollSectionFields.bounds.midX

        return lbl
    }
    
    func createTextField(fieldText: String) -> UITextField{
        let sampleTextField =  UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        print(fieldText)
        sampleTextField.placeholder = "Enter text here"
        sampleTextField.text = fieldText
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.pdfScrollSectionFields.addSubview(sampleTextField)
        sampleTextField.center.x = pdfScrollSectionFields.bounds.midX
        
        return sampleTextField
    }
    
    func createCheckBox(state: String) -> M13Checkbox{
        let checkbox = M13Checkbox(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
        checkbox.boxType = .square
        if(state == "true"){
            checkbox.toggleCheckState()
        }
        print(checkbox.checkState)
        pdfScrollSectionFields.addSubview(checkbox)
        
        //checkbox.center.x = pdfScrollSectionFields.bounds.midX
        
        return checkbox
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
