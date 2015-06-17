

import Foundation
import CoreData
@objc (List)
class List: NSManagedObject {

    @NSManaged var item: String
    @NSManaged var note: String
    @NSManaged var qty: String

}
