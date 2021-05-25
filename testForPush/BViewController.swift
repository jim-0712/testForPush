//
//  BViewController.swift
//  testForPush
//
//  Created by Jim on 2021/5/25.
//

import UIKit

class BViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    roundTextField.delegate = self
    roundTextField.keyboardType = .numberPad
    roundTextField.addDoneCancelToolbar()
  }
  
  @IBOutlet weak var whiteView: UIView!
  @IBOutlet weak var roundTextField: UITextField!
  
  @IBAction func back(_ sender: Any)
  {
    self.dismiss(animated: true, completion: nil)
  }
  
}

extension BViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return true
  }
}
