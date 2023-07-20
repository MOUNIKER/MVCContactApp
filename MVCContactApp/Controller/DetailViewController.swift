//
//  DetailViewController.swift
//  MVCContactApp
//
//  Created by Narasimha on 18/07/23.
//

import UIKit

var details: [DetailFields] = []

class DetailViewController: UIViewController {

    var selectedContact: ContactFields?

    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var imageView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        nameTitle()
    }
    func nameTitle() {
        nameLBL.text = (selectedContact?.firstname ?? "") + " " + (selectedContact?.lastname ?? "")
        imageView.setImage(UIImage(named: selectedContact?.image ?? ""), for: .normal)
    }
}
