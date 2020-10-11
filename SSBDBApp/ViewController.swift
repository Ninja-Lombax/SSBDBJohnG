//
//  ViewController.swift
//  SSBDBApp
//
//  Created by John Grasser on 10/11/20.
//  Copyright © 2020 John Grasser. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController
{
    var dataManager : NSManagedObjectContext!
    var listArray = [NSManagedObject]()
    @IBOutlet var txtEnterCharacter: UITextField!
    
    
    @IBOutlet var txtCharLisy: UITextView!
    
    @IBOutlet var txtdeleteChar: UITextField!
    
    
    @IBAction func addChar(_ sender: UIButton) {
        
         let newEntity = NSEntityDescription.insertNewObject(forEntityName: "SuperSmashBros", into: dataManager)
        
        newEntity.setValue(txtEnterCharacter.text!, forKey: "character")
        
        do{
            try self.dataManager.save()
            listArray.append(newEntity)
        }catch{
            print("Error saving data")
            
            
        }
        txtEnterCharacter.text?.removeAll()
        txtdeleteChar.text?.removeAll()
        txtCharLisy.text?.removeAll()
        
        retrieveData()
        
    }
    
    
    
    @IBAction func removeChar(_ sender: UIButton) {
        let deleteItem = txtdeleteChar.text!
        for item in listArray
        {
            if item.value(forKey: "character") as! String == deleteItem{
            dataManager.delete(item)
            }
        }
        
        do{
            try self.dataManager.save()
        }
        catch{
            
            print("Error deleting data")
        }
        
        txtEnterCharacter.text?.removeAll()
        txtdeleteChar.text?.removeAll()
        txtCharLisy.text?.removeAll()
        retrieveData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        txtCharLisy.text?.removeAll()
        retrieveData()        // Do any additional setup after loading the view.
    }

    func retrieveData()
     {
         let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SuperSmashBros")
         do{
             let result = try dataManager.fetch(fetchRequest)
             listArray = result as! [NSManagedObject]
             
             for item in listArray
             {
                 let product = item.value(forKey: "character") as! String
                 txtCharLisy.text! += product
                txtCharLisy.text! += "\n"
                 
             }
             
         } catch{
             print("Error retrieving data")
         }
         
     }
    
}

