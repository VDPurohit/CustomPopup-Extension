
//  Created by Admin on 27/03/19.
//  Copyright © 2019 Vivek. All rights reserved.
//

import UIKit

class CustomAlertVC: UIViewController {
    
    //IBOutlet declaration
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var btnClose : UIButton!
    @IBOutlet weak var imgBlurImage : UIImageView!
    
    //Variable declaration
    typealias CompletionHandler = (_ success:Bool) -> Void
    private var SetResponder :  CompletionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /*
     Class function to setup popup and show it
     - Authors:
     - Created By - 2432
     - Modified By - 2432
     - Date:
     - Created At - 27/03/19
     - Modified At - date
     - Version: 1.0
     - Remark: nil
     */
    class func showPopup(in selectedController : UIViewController,_ handler: @escaping CompletionHandler) {
        let kStoryboard_DischargePopUpSB = UIStoryboard(name: "CustomAlertSB", bundle: nil)
        let kViewIdentifier_kDischargePopUpVC = "CustomAlertVC"
        let controller = kStoryboard_DischargePopUpSB.instantiateViewController(withIdentifier: kViewIdentifier_kDischargePopUpVC)  as! CustomAlertVC
        controller.modalPresentationStyle = .overCurrentContext
        controller.definesPresentationContext = true
        controller.view.alpha = 0
        controller.SetResponder = handler

        DispatchQueue.main.async {
            selectedController.present(controller, animated: false) {
                
                controller.imgBlurImage.removeBlurEffect()
                controller.imgBlurImage.addBlurEffect()
                controller.btnClose.setBackgroundImage(ThemeGradient.shared.setGradientDefaultImageForButton(withRadius: controller.btnClose.bounds.height/2, andFrame: controller.btnClose.bounds), for: .highlighted)
                
                UIView.animate(withDuration: 0.5, animations: {
                    controller.view.alpha = 1.0
                })
            }
        }
    }
    
    @IBAction func btnCloseClicked(_ sender : UIButton!) {
        self.dismiss(animated: true, completion: nil)
        self.SetResponder!(true)
    }

}
