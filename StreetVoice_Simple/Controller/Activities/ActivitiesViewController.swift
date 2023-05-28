
import UIKit

class ActivitiesViewController: UIViewController {
    
    
    
    var tableView:UITableView = {
        let tableView = UITableView()
//        tableView.rowHeight = 150
        tableView.register(ActivityTableViewCell.self, forCellReuseIdentifier: ActivityTableViewCell.identify)
        return tableView
    }()
    
    var reports:[Report] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "活動"
        view.addSubview(tableView)

        
        setDelegate()
        reports = fetchData()
    }
    
    //MARK: - Constrain TableView
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    func setDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ActivitiesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.identify,for: indexPath) as! ActivityTableViewCell
        let report = reports[indexPath.row]
        cell.set(report: report)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ADVC = ActifityDetailViewController()
        ADVC.report = reports[indexPath.row]
        self.navigationController?.pushViewController(ADVC, animated: true)
    }
}

// MARK: - Dummy Data

extension ActivitiesViewController{

    
    func fetchData() -> [Report]{
        let report1 = Report(managerName: "TheRappers", content: "大嘻哈時代握手會5/19    At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et", contentImage: UIImage(named: "Activity519"))
        let report2 = Report(managerName: "TheRappers", content: "大嘻哈時代握手會5/12    At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et", contentImage: UIImage(named: "Activity512"))
        let report3 = Report(managerName: "TheRappers", content: "大嘻哈時代演唱會高雄場    At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et", contentImage: UIImage(named: "Activity506507"))
        return [report1,report2,report3]
    }
}
