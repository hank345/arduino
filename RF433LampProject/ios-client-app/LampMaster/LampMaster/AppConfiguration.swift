
import Foundation

class AppConfiguration {

    static let defaults = NSUserDefaults.standardUserDefaults()
    
    // Keys used for storing settings
    static let RFControllerHostKey = "RFControllerHost"
    static let DeviceOnCommandKey = "DeviceOnCommandKey"
    static let DeviceOffCommandKey = "DeviceOffCommandKey"
    
    // Default values
    static let defaultRFControllerHost = "192.168.1.177"
    static let defaultDeviceOnCommand = "deviceOn"
    static let defaultDeviceOffCommand = "deviceOff"
    
    
    static func getRFControllerHost()->String {
        var host = getValueForKey(AppConfiguration.RFControllerHostKey)
        if(host.isEmpty) {
            host = AppConfiguration.defaultRFControllerHost
            setValue(AppConfiguration.RFControllerHostKey, value: host)
        }
        NSLog("Getting host value for key %@, with value: %@",
            AppConfiguration.RFControllerHostKey, host)
        
        return host
    }
    
    
    static func getDeviceOnCommand()->String {
        var deviceOnCmd = getValueForKey(AppConfiguration.DeviceOnCommandKey)
        if(deviceOnCmd.isEmpty) {
            deviceOnCmd = AppConfiguration.defaultDeviceOnCommand
            setValue(AppConfiguration.DeviceOnCommandKey, value: deviceOnCmd)
        }
        NSLog("Getting device ON command value for key %@, with value: %@",
            AppConfiguration.DeviceOnCommandKey, deviceOnCmd)
        
        return deviceOnCmd
    }
    
    
    static func getDeviceOffCommand()->String {
        var deviceOffCmd = getValueForKey(AppConfiguration.DeviceOffCommandKey)
        if(deviceOffCmd.isEmpty) {
            deviceOffCmd = AppConfiguration.defaultDeviceOffCommand
            setValue(AppConfiguration.DeviceOffCommandKey, value: deviceOffCmd)
        }
        NSLog("Getting device OFF command value for key %@, with value: %@",
            AppConfiguration.DeviceOffCommandKey, deviceOffCmd)
        
        return deviceOffCmd
    }
    
    
    static func getValueForKey(key: String)->String {
        var stringOne = defaults.valueForKey(key) as? String
        if(stringOne == nil) {
            return "";
        }
        
        return stringOne!
    }
    
    
    static func setValue(key: String, value: String) {
        NSLog("Setting value for key %@, with value: %@", key, value)
        defaults.setValue(value, forKey: key)
    }
}