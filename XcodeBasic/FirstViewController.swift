import UIKit

class FirstViewController: UIViewController {
    
    var addTaxCost:Decimal = 0
    var costsArray:[Decimal] = []
    
    @IBOutlet var showLabel: UILabel!
    @IBOutlet var costField: UITextField!
    @IBOutlet var taxController: UISegmentedControl!
    @IBOutlet var itemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTableView.delegate = self
        itemTableView.dataSource = self
        updateLabel()
        costsArray.removeAll()
        UserDefaults.standard.set(costsArray, forKey: "item")
    }
    
    // 入力する都度更新される 紐付けはEditing Changed
    @IBAction func costField(_ sender: Any) {
        updateLabel()
    }

    // 税率を変更すると更新される
    @IBAction func taxChanger(_ sender: Any) {
        updateLabel()
    }
    
    // ラベル更新用関数
    func updateLabel() {
        let tax:Decimal = taxController.selectedSegmentIndex == 0 ? 1.1 : 1.08
        let cost = Decimal(string: costField.text!) ?? 0

        addTaxCost = cost * tax
        let addTaxCostString:String = "\(addTaxCost)"

        showLabel.text = addTaxCostString
    }

    // 追加(Button)
    @IBAction func addButton(_ sender: Any) {
        guard costField.text != "" else { return }
        
        costsArray.append(contentsOf: [addTaxCost])
        
        UserDefaults.standard.set(costsArray, forKey: "item")
        print(UserDefaults.standard.object(forKey: "item") as! [Double])
        
        costField.text = ""
        updateLabel()
        
        self.itemTableView.reloadData()
    }
}

extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            costsArray.remove(at: indexPath.row)
            UserDefaults.standard.set(costsArray, forKey: "item")
            itemTableView.reloadData()
        }
    }
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return costsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(costsArray[indexPath.row])"
        return cell
    }
}

