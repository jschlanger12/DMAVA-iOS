//
//  HotlineDetailViewController.swift
//  Practicum
//
//  Created by dev on 3/18/19.
//  Copyright © 2019 Monmouth University. All rights reserved.
//

import UIKit

class HotlineDetailViewController: UIViewController {
    
    var desc: String = ""
    var phone: String = ""
    var webURL: String = ""
    var name: String = ""

//    var titleLabel: UILabel = UILabel()
//    var descLabel: UILabel = UILabel()
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var descLabelSB: UILabel!

//    var websiteButton: UIButton = UIButton()
//    var phoneCallButton: UIButton = UIButton()

    @IBOutlet weak var webButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webButton.layer.cornerRadius = 8;
        callButton.layer.cornerRadius = 8;
        
        descLabelSB.text = desc
        self.title = name
    }
    
    @IBAction func goToWebsite(_ sender: Any) {
        if let url = URL(string: webURL) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func goToPhone(_ sender: Any) {
        let url = URL(string: "tel://\(phone)")

        UIApplication.shared.open(url!)
        
    }
//
//    func initLabelsAndButtons(){
//        //setTitleLabel()
//        setDescLabel()
//        createButtons()
//        setView(labelSV: setLabelStackView(), buttonSV: setButtonStackView())
//    }
//
//    func setView(labelSV: UIStackView, buttonSV: UIStackView){
////        self.view.addSubview(labelSV)
////        self.view.addSubview(buttonSV)
//        let stackView = UIStackView()
//        stackView.addArrangedSubview(labelSV)
//        stackView.addArrangedSubview(buttonSV)
//
//        labelSV.translatesAutoresizingMaskIntoConstraints = false
//        buttonSV.translatesAutoresizingMaskIntoConstraints = false
//
//        stackView.alignment = .top
//
////        stackView.setCustomSpacing(40, after: descLabel)
//
////        labelSV.widthAnchor.constraint(equalToConstant: view.bounds.maxX).isActive = true
////        labelSV.heightAnchor.constraint(equalToConstant: view.bounds.maxY - 150).isActive = true
////        labelSV.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
////        labelSV.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
//
////        descLabel.heightAnchor.constraint(equalToConstant: stackView.bounds.minY).isActive = true
//
////        buttonSV.widthAnchor.constraint(equalToConstant: view.bounds.maxX).isActive = true
////        buttonSV.heightAnchor.constraint(equalToConstant: view.bounds.maxY - 49).isActive = true
////        buttonSV.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
////        buttonSV.topAnchor.constraint(equalTo: labelSV.bottomAnchor).isActive = true
//
//        stackView.axis = .vertical
////        stackView.distribution = .fillProportionally
////        stackView.alignment = .fill
////        stackView.spacing = 300
//
//        self.view.addSubview(stackView)
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
////        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
////        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//
////        let heightConstraint1 = NSLayoutConstraint(item: buttonSV, attribute: .height, relatedBy: .equal, toItem: labelSV, attribute: .height, multiplier: 0.25, constant: 0.0)
////        let heightConstraint2 = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: descLabel, attribute: .height, multiplier: 0.15, constant: 0.0)
////        let heightConstraint3 = NSLayoutConstraint(item: websiteButton, attribute: .height, relatedBy: .equal, toItem: phoneCallButton, attribute: .height, multiplier: 0.15, constant: 0.0)
//
////        NSLayoutConstraint.activate([heightConstraint2])
//
//        let viewsDictionary = ["stackView":stackView]
//        let stackView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[stackView]-20-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
//        let stackView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[stackView]-100-|", options: NSLayoutConstraint.FormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
//
//        view.addConstraints(stackView_V)
//        view.addConstraints(stackView_H)
//
//
//    }
//
//    func setLabelStackView() -> UIStackView{
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.alignment = .top
////        stackView.spacing = UIStackView.spacingUseSystem
//        stackView.translatesAutoresizingMaskIntoConstraints = false
////        stackView.isLayoutMarginsRelativeArrangement = true
//
//        //stackView.addArrangedSubview(titleLabel)
//        stackView.addArrangedSubview(descLabel)
//
//        view.addSubview(stackView)
//
//        //titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        //descLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        return stackView
//    }
//
//    func setButtonStackView() -> UIStackView{
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
//        stackView.alignment = .fill
//        stackView.spacing = 10
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        stackView.addArrangedSubview(websiteButton)
//        stackView.addArrangedSubview(phoneCallButton)
//
//        view.addSubview(stackView)
//
//        return stackView
//    }
//
//    func setTitleLabel(){
//        titleLabel.text = name
//        titleLabel.textAlignment = .natural
//        titleLabel.textColor = .black
//        titleLabel.font = UIFont.systemFont(ofSize: 25)
//        titleLabel.numberOfLines = 2 //If you want to display only 2 lines replace 0(Zero) with 2.
//        titleLabel.lineBreakMode = .byWordWrapping //Word Wrap
//        titleLabel.sizeToFit()
//        titleLabel.center.x = self.view.bounds.midX
//
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//    }
//
//    func setDescLabel(){
//        descLabel.text = desc
//        descLabel.textAlignment = .center
//        descLabel.textColor = .black
//        descLabel.font = UIFont.systemFont(ofSize: 17)
//        descLabel.numberOfLines = 20 //If you want to display only 2 lines replace 0(Zero) with 2.
//        descLabel.lineBreakMode = .byWordWrapping //Word Wrap
////        descLabel.sizeToFit()
////        descLabel.center.x = self.view.bounds.midX
//        descLabel.translatesAutoresizingMaskIntoConstraints = false
//    }
//
//    func createButtons(){
//        websiteButton.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
//        websiteButton.backgroundColor = UIColor(red: 130/255.0, green: 128/255.0, blue: 103/255.0, alpha: 1.0)
//        websiteButton.setTitle("Go to Website", for: .normal)
//        websiteButton.addTarget(self, action: #selector(goToWebside), for: .touchUpInside)
//        websiteButton.setTitleColor(.black, for: .normal)
//
//        phoneCallButton.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
//        phoneCallButton.backgroundColor = UIColor(red: 130/255.0, green: 128/255.0, blue: 103/255.0, alpha: 1.0)
//        phoneCallButton.setTitle("Call Hotline", for: .normal)
//        phoneCallButton.addTarget(self, action: #selector(goToPhoneCall), for: .touchUpInside)
//        phoneCallButton.setTitleColor(.black, for: .normal)
//
//
//        websiteButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        phoneCallButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    }
//
//    @objc func goToWebside(sender: UIButton!) {
//
//    }
//
//    @objc func goToPhoneCall(sender: UIButton!) {
//
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
