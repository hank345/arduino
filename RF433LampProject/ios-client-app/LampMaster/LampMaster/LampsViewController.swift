
import UIKit

class LampsViewController: UIViewController {
    
    // TODO: Make dynamic
    // TODO: Fetch lamp status? (last known state from arduino)
    // TODO: Name/Re-name the lamps in settings
    
    @IBOutlet weak var allLamps: UISwitch!
    @IBOutlet weak var device0: UISwitch!
    @IBOutlet weak var device1: UISwitch!
    @IBOutlet weak var device2: UISwitch!
    
    @IBAction func onAllLampsSwitch(sender: AnyObject) {
  
        if(allLamps.on) {
            switchLamp("All", on: true)
            device0.setOn(true, animated:true)
            device1.setOn(true, animated:true)
            device2.setOn(true, animated:true)
        }
        else {
            switchLamp("All", on: false)
            device0.setOn(false, animated:true)
            device1.setOn(false, animated:true)
            device2.setOn(false, animated:true)
        }
    }
    
    @IBAction func onLamp0Switch(sender: AnyObject) {
        
        if(device0.on) {
            switchLamp("0", on: true)
        }
        else {
            switchLamp("0", on: false)
        }
    }

    @IBAction func onLamp1Switch(sender: AnyObject) {
        
        if(device1.on) {
            switchLamp("1", on: true)
        }
        else {
            switchLamp("1", on: false)
        }
    }

    @IBAction func onLamp2Switch(sender: AnyObject) {
        
        if(device2.on) {
            switchLamp("2", on: true)
        }
        else {
            switchLamp("2", on: false)
        }
    }

    
    
    func switchLamp(lampId : String, on : Bool) {
        
        var urlStr = "";
        
        if(on){
            urlStr = "http://" + AppConfiguration.getRFControllerHost() + "/?" +
                AppConfiguration.getDeviceOnCommand() + lampId;
            NSLog("Turning on lamp with id: %@", lampId);
        }
        else {
            urlStr = "http://" + AppConfiguration.getRFControllerHost() + "/?" +
                AppConfiguration.getDeviceOffCommand() + lampId;
            NSLog("Turning off lamp with id: %@", lampId);
        }

        let url = NSURL(string: urlStr);
        NSLog("Sending request to: %@", urlStr)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            
            if((error) != nil) {
                NSLog("Error: %@", error.description)
            }
            if((response) != nil) {
                NSLog("Response: %@", response.description);
            }
        }
        
        task.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

