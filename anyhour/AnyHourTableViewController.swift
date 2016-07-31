//
//  AnyHourTableViewController.swift
//  anyhour
//
//  Created by pramono wang on 7/30/16.
//  Copyright © 2016 fnu. All rights reserved.
//

import UIKit

class AnyHourTableViewController: UITableViewController {
    
    @IBAction func reserveButtonPressed(sender: AnyObject) {
        let alertView = UIAlertController(title: "Reserved", message: "Your Restaurant has been reserved", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alertView, animated: true, completion: nil)

    }
    var data: [Restaurant] = [Restaurant(name: "DRAGO Centro", address:"525 S Folwer St Ste 120, Los Angeles", state: "CA", zipcode: "90017"),
                              Restaurant(name: "Bottega", address:"700 S Grand Ave, Los Angeles", state: "CA", zipcode: "90017"),
                              Restaurant(name: "Wokcano", address:"800 W 7th St, Los Angeles", state: "CA", zipcode: "90017"),
                              Restaurant(name: "Water Grill", address:"544 S Grand Ave, Los Angeles", state: "CA", zipcode: "90017"),
                              Restaurant(name: "Perch", address:"448 S Hill St, Los Angeles", state: "CA", zipcode: "90017"),
                              Restaurant(name: "PlanCheck", address:"1111 Wilshire Blvd, Los Angeles", state: "CA", zipcode: "90017"),
                                Restaurant(name: "Au Lac", address:"710 W 1st ST", state: "CA", zipcode: "90012"),
                                Restaurant(name: "Mendocino Farms", address:"444 S Flower St, Los Angeles", state: "CA", zipcode: "90017"),
                                Restaurant(name: "EKO Eats", address:"630 W 6st ST, Los Angeles", state: "CA", zipcode: "90017"),
                                Restaurant(name: "EggSlut", address:"317 S Broadway, Los Angeles", state: "CA", zipcode: "90017")
                              ]
    
    var discounts = ["10", "10", "30", "15", "20", "30", "5" , "18", "20", "50"]
    
    var images = [UIImage(named: "Bottega.jpg"),UIImage(named: "DRAGO centro.jpg"),UIImage(named: "Wokcano.jpg"),UIImage(named: "Water Grill.jpg"),UIImage(named: "Perch.jpg"),UIImage(named: "Eko.jpg"), UIImage(named: "Au.jpg"), UIImage(named: "Mendocino.jpg"), UIImage(named: "Plancheck.jpg"), UIImage(named: "eggslut.jpg")]
    
    var reviews = ["20", "1100", "52", "323", "562", "144", "15", "88", "122", "1780"]
    
    var realdata = ["Food", "KFC", "Mcdonald", "Burger King", "Shack shack"]
    
    var restaurants: [Restaurant] = []
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AnyHourCell", forIndexPath: indexPath) as! AnyHourCustomCell
        
        cell.photo.image = images[indexPath.row]
        cell.name.text = data[indexPath.row].name
        cell.address.text = data[indexPath.row].address
        cell.review.text = reviews[indexPath.row] + " reviews"
        cell.discount.text = "Deal Now " + discounts[indexPath.row] + "% off"
        //cell.textLabel!.text = data[indexPath.row].name
        
        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let newCell = tableView.cellForRowAtIndexPath(indexPath)
        newCell?.accessoryType = .Checkmark

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showmap"
        {
            let destination = segue.destinationViewController as? ShowMapViewController
            let restaurantIndex = tableView.indexPathForSelectedRow?.row
            
            destination!.name = data[restaurantIndex!].name
            destination!.state = data[restaurantIndex!].state
            destination?.zipcode = data[restaurantIndex!].zipcode
            destination?.address = data[restaurantIndex!].address
        }
        
        
    }
    

}
