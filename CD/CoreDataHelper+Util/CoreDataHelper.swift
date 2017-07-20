import Foundation
import CoreData

class CoreDataHelper: CoreDataStack {

    // Singleton
    static let sharedInstance = CoreDataHelper()

    func entityDescription(_ entityName: String) -> NSEntityDescription? {
        if let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext) {
            return entity
        }
        return nil
    }

    func mobileEntity() -> NSEntityDescription? {
        return entityDescription("Mobile")
    }

    fileprivate func fetchRequest(_ entityName: String, withPredicate predicate: NSPredicate?) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "sn", ascending: true)
        ]
        fetchRequest.predicate = predicate
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch let fetchError as NSError {
            print("fetchError ", fetchError)
        }
        return fetchedResultsController
    }

    func fetchMobileArray(withPredicate predicate: NSPredicate?) -> [Mobile]? {
        return fetchRequest("Mobile", withPredicate: predicate).fetchedObjects as? [Mobile]
    }
}
