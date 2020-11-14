import Foundation

var OrganaizerItems: [[String:Any]]  {
    set {
        UserDefaults.standard.set(newValue , forKey: "OrganaizerDataKey")
        UserDefaults.standard.synchronize()
    }
    get {
        if let array = UserDefaults.standard.array(forKey: "OrganaizerDataKey" ) as? [[String : Any]] {
            return array
        } else {
            return []
        }
    }
}

func addItem( nameItem: String , isCompleted : Bool = false) {
    OrganaizerItems.append(["Name" : nameItem, "isCompleted" : false ])

}

func removeItem (at index : Int) {
    OrganaizerItems.remove(at: index)

}

func moveItem(fromIndex: Int , toIndex: Int) {
    let from = OrganaizerItems[fromIndex]
    OrganaizerItems.remove(at: fromIndex)
    OrganaizerItems.insert(from,at: toIndex)
}


func changeState (at item: Int) -> Bool {
    OrganaizerItems[item]["isCompleted"] = !(OrganaizerItems[item]["isCompleted"] as! Bool)

    
    return OrganaizerItems[item]["isCompleted"] as! Bool
   
}

