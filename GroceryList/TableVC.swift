

import UIKit
import CoreData


class TableVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let context : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!

    var frc : NSFetchedResultsController = NSFetchedResultsController()
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        frc = NSFetchedResultsController(fetchRequest: listFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    
    func listFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "List")
        let SortDescriptor = NSSortDescriptor(key: "item", ascending: true)
        fetchRequest.sortDescriptors = [SortDescriptor]
        return fetchRequest
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        frc = getFetchedResultsController()
        frc.delegate = self
        frc.performFetch(nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        let numberofSections = frc.sections?.count
        return numberofSections!
        
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        let numberOfRowsInSection = frc.sections?[section].numberOfObjects
        return numberOfRowsInSection!
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        //var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        let list = frc.objectAtIndexPath(indexPath) as! List
        

        // Configure the cell...
        
        cell.textLabel?.text = list.item
        
        var note = list.note
        var qty = list.qty
        
        cell.detailTextLabel?.text = "Qty: \(qty) - \(note)."
    
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
        let managedObject : NSManagedObject = frc.objectAtIndexPath(indexPath) as! NSManagedObject
        
        context.deleteObject(managedObject)
        context.save(nil)
    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    
        if segue.identifier == "edit" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let itemController : MainVC = segue.destinationViewController as! MainVC
            let nItem : List = frc.objectAtIndexPath(indexPath!) as! List
            itemController.nItem = nItem
        }
    
    
    
    }
    

}
