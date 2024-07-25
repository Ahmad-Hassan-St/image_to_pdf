import UIKit

class TableViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var students: [Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign self as the data source
        tableView.dataSource = self
        
        // Load and parse the JSON data
        guard let url = Bundle.main.url(forResource: "studentRecord", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let loadedStudents = try? JSONDecoder().decode([Student].self, from: data) else {
                fatalError("Failed to load and parse studentRecord.json")
        }
        
        self.students = loadedStudents
        
        // Reload the table view to reflect the changes
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let student = students[indexPath.row]
        
        
        // Update the labels in your custom cell
        cell.lblName.text = student.name
        cell.lblAge.text = "\(student.age)"
        cell.lblCgpa.text = "\(student.cgpa)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
