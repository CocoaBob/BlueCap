//
//  PeripheralManagerServiceCharacteristicViewController.swift
//  BlueCap
//
//  Created by Troy Stribling on 8/19/14.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import UIKit
import CoreBluetooth
import BlueCapKit

class PeripheralManagerServiceCharacteristicViewController: UITableViewController {
    
    var characteristic: MutableCharacteristic?
    var peripheralManagerViewController: PeripheralManagerViewController?

    
    @IBOutlet var uuidLabel: UILabel!
    
    @IBOutlet var permissionReadableLabel: UILabel!
    @IBOutlet var permissionWriteableLabel: UILabel!
    @IBOutlet var permissionReadEncryptionLabel: UILabel!
    @IBOutlet var permissionWriteEncryptionLabel: UILabel!
    
    @IBOutlet var propertyBroadcastLabel: UILabel!
    @IBOutlet var propertyReadLabel: UILabel!
    @IBOutlet var propertyWriteWithoutResponseLabel: UILabel!
    @IBOutlet var propertyWriteLabel: UILabel!
    @IBOutlet var propertyNotifyLabel: UILabel!
    @IBOutlet var propertyIndicateLabel: UILabel!
    @IBOutlet var propertyAuthenticatedSignedWritesLabel: UILabel!
    @IBOutlet var propertyExtendedPropertiesLabel: UILabel!
    @IBOutlet var propertyNotifyEncryptionRequiredLabel: UILabel!
    @IBOutlet var propertyIndicateEncryptionRequiredLabel: UILabel!

    struct MainStoryboard {
        static let peripheralManagerServiceCharacteristicValuesSegue = "PeripheralManagerServiceCharacteristicValues"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let characteristic = self.characteristic {
            self.uuidLabel.text = characteristic.UUID.UUIDString
            
            self.permissionReadableLabel.text = self.booleanStringValue(characteristic.permissionEnabled(CBAttributePermissions.Readable))
            self.permissionWriteableLabel.text = self.booleanStringValue(characteristic.permissionEnabled(CBAttributePermissions.Writeable))
            self.permissionReadEncryptionLabel.text = self.booleanStringValue(characteristic.permissionEnabled(CBAttributePermissions.ReadEncryptionRequired))
            self.permissionWriteEncryptionLabel.text = self.booleanStringValue(characteristic.permissionEnabled(CBAttributePermissions.WriteEncryptionRequired))
            
            self.propertyBroadcastLabel.text = self.booleanStringValue(characteristic.propertyEnabled(CBCharacteristicProperties.Broadcast))
            self.propertyReadLabel.text = self.booleanStringValue(characteristic.propertyEnabled(CBCharacteristicProperties.Read))
            self.propertyWriteWithoutResponseLabel.text = self.booleanStringValue(characteristic.propertyEnabled(CBCharacteristicProperties.WriteWithoutResponse))
            self.propertyWriteLabel.text = self.booleanStringValue(characteristic.propertyEnabled(CBCharacteristicProperties.Write))
            self.propertyNotifyLabel.text = self.booleanStringValue(characteristic.propertyEnabled(CBCharacteristicProperties.Notify))
            self.propertyIndicateLabel.text = self.booleanStringValue(characteristic.propertyEnabled(CBCharacteristicProperties.Indicate))
            self.propertyAuthenticatedSignedWritesLabel.text = self.booleanStringValue(characteristic.propertyEnabled(CBCharacteristicProperties.AuthenticatedSignedWrites))
            self.propertyExtendedPropertiesLabel.text = self.booleanStringValue(characteristic.propertyEnabled(CBCharacteristicProperties.ExtendedProperties))
            self.propertyNotifyEncryptionRequiredLabel.text = self.booleanStringValue(characteristic.propertyEnabled(CBCharacteristicProperties.NotifyEncryptionRequired))
            self.propertyIndicateEncryptionRequiredLabel.text = self.booleanStringValue(characteristic.propertyEnabled(CBCharacteristicProperties.IndicateEncryptionRequired))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let characteristic = self.characteristic {
            self.navigationItem.title = characteristic.name
        }
        NotificationCenter.default.addObserver(self, selector:#selector(PeripheralManagerServiceCharacteristicViewController.didEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object:nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
        NotificationCenter.default.removeObserver(self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == MainStoryboard.peripheralManagerServiceCharacteristicValuesSegue {
            let viewController = segue.destination as! PeripheralManagerServicesCharacteristicValuesViewController
            viewController.characteristic = self.characteristic
            if let peripheralManagerViewController = self.peripheralManagerViewController {
                viewController.peripheralManagerViewController = peripheralManagerViewController
            }
        }
    }
    
    func didEnterBackground() {
        Logger.debug()
        if let peripheralManagerViewController = self.peripheralManagerViewController {
            self.navigationController?.popToViewController(peripheralManagerViewController, animated:false)
        }
    }
    
    func booleanStringValue(_ value:Bool) -> String {
        return value ? "YES" : "NO"
    }

}
