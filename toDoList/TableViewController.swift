import UIKit

class TableViewController: UITableViewController {
    
    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    
    @IBAction func pushAddAction(_ sender: Any) {
        let AlertController = UIAlertController(title: "Создать новое дело", message: nil, preferredStyle: .alert)
        AlertController.addTextField { (TextField) in
            TextField.placeholder = "Нозая заметка"
            
        }
        let AlertAction1 = UIAlertAction(title: "Отмена", style: .default) {
            (alert) in
            
        }
        
        let AlertAction2 = UIAlertAction(title: "Создать", style: .cancel) {
            (alert) in
            // Add new tag
            let NewItem = AlertController.textFields![0].text
            addItem(nameItem: NewItem!)
            self.tableView.reloadData()
        }
        
        AlertController.addAction(AlertAction1)
        AlertController.addAction(AlertAction2)
        
        present(AlertController, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let currentItem = ToDoList[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String
        
        if (currentItem["IsCompleted"] as? Bool) == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()

    }
}
