
import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var RFHostTxt: UITextField!
    @IBOutlet weak var deviceOnTxt: UITextField!
    @IBOutlet weak var deviceOffTxt: UITextField!
    
    
    override func viewDidAppear(animated: Bool) {
        NSLog("*** Settings view did appear ***")
        super.viewDidAppear(animated)
        populateSettings()
    }
    
    
    override func viewDidLoad() {
        NSLog("*** Settings view did load ***")
        super.viewDidLoad()
        populateSettings()
    }
    
    func populateSettings() {
        
        RFHostTxt.tag = 0
        deviceOnTxt.tag = 1
        deviceOffTxt.tag = 2
        
        RFHostTxt.text = AppConfiguration.getRFControllerHost()
        deviceOnTxt.text = AppConfiguration.getDeviceOnCommand()
        deviceOffTxt.text = AppConfiguration.getDeviceOffCommand()
    }

    
    @IBAction func onTextFieldChange(sender: UITextField) {
            NSLog("Text field changed with tag %d", sender.tag)
        
        switch(sender.tag) {
            case RFHostTxt.tag:
                AppConfiguration.setValue(AppConfiguration.RFControllerHostKey, value: sender.text)
            case deviceOnTxt.tag:
                AppConfiguration.setValue(AppConfiguration.DeviceOnCommandKey, value: sender.text)
            case deviceOffTxt.tag:
                AppConfiguration.setValue(AppConfiguration.DeviceOffCommandKey, value: sender.text)
            
            default:
                NSLog("Unknown settings text area tag.")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

