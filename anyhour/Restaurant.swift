import UIKit

class Restaurant {
    
    var name:String
    var state:String
    var address:String
    var zipcode: String
    
    init (name:String, address:String, state:String, zipcode:String)
    {
        self.name = name
        self.state = state
        self.address = address
        self.zipcode = zipcode
    }
    
    
}