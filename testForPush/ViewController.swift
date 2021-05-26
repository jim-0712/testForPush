//
//  ViewController.swift
//  testForPush
//
//  Created by Jim on 2021/5/25.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var alert: UIButton!
    
    private enum AlertSheetType {
    case total
    case custom
    case minium
    case cancel
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
//    let day = Date()
//    let a = day.get(.day, .month, .year)
//    if let year = a.year, let month = a.month, let day = a.day {
//      let changeMonth = String(format: "%02x", month)
//      let changeday = String(format: "%02x", day)
//      let dateFormatter = DateFormatter()
//      dateFormatter.dateFormat = "yyyy/MM/dd hh mm ss"
//      let dateString = "\(year)/\(changeMonth)/\(changeday) 23:59:59"
//      let dates = dateFormatter.date(from: dateString)
//      print("complete")
//    }
//    alert.modifyShape(borderWidth: 1, borderColor: UIColor.green.cgColor, cornerRadius: 10, masksToBounds: false)
  }
  
  @IBAction func showAlert(_ sender: Any) {
    self.showAlertSheet { type in
      switch type {
      case .custom:
        if let payAmountVC = self.storyboard?.instantiateViewController(withIdentifier: "BViewController") as? BViewController
        {
//          payAmountVC.minAmount = minPayAmount
//          payAmountVC.totalAmount = totalAmount
          payAmountVC.modalPresentationStyle = .overCurrentContext
          self.present(payAmountVC, animated: true, completion: nil)
        }
      default:
        break
      }
    }
  }
  
  private func showAlertSheet(_ actionHandler: ((AlertSheetType) -> Void)?)
  {
    let alertSheet = UIAlertController(title: "產生 7-ELEVEN 繳費條碼",
                                       message: """
                                                      注意事項 :
                                                      1.每次產生條碼，條碼有效時間為三小時，請儘速於三小時內持該條碼至 7-ELEVEN 門市繳費。若超過三小時，請重新產生一次條碼。
                                                      2.超商繳款金額以新台幣貳萬元為限。
                                                      """,
                                       preferredStyle: .actionSheet)
    alertSheet.view.tintColor = .red
    
    let total = UIAlertAction(title: "本 期 應 繳 總 額 條 碼", style: .default) { (_) in
      actionHandler?(.total)
    }
    
    alertSheet.addAction(total)
    
    let custom = UIAlertAction(title: "自訂繳款金額", style: .default) { (_) in
      actionHandler?(.custom)
    }
    alertSheet.addAction(custom)
    
    let minium = UIAlertAction(title: "最 低 繳 款 金 額 條 碼", style: .default) { (_) in
      actionHandler?(.minium)
    }
    alertSheet.addAction(minium)
    
    let cancel = UIAlertAction(title: "取消", style: .cancel) { (_) in
      actionHandler?(.cancel)
    }
    alertSheet.addAction(cancel)
    
    self.present(alertSheet, animated: true, completion: nil)
    
  }
  
}


