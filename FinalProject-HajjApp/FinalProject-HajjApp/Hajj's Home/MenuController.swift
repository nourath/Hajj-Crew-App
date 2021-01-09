//
//  MenuController.swift
//  FinalProject-HajjApp
//
//  Created by Abeer Pr on 23/05/1442 AH.
//

import UIKit
import SideMenu


protocol MenuControllerDelegate {
    func didselectMenuItem(named: SideMenuItem)
}

enum SideMenuItem: String, CaseIterable {
    case home = "Home"
    case Chat = "Chat with translator"
    case sos = "SOS"
    case contactUs = "Contact US"
    case logOut = "Log out"
    
    //"Contact US","SOS","Chat with Translator"
}

class MenuController: UITableViewController {
    
    public var delegate: MenuControllerDelegate?
    
    private let menueItems: [SideMenuItem]
    
    init(with menueItems: [SideMenuItem]) {
        self.menueItems = menueItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     //   uina
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.2904876769, green: 0.4913773537, blue: 0.4412539601, alpha: 1)
        UINavigationBar.appearance().isTranslucent = true
        tableView.backgroundColor = #colorLiteral(red: 0.2904876769, green: 0.4913773537, blue: 0.4412539601, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.2904876769, green: 0.4913773537, blue: 0.4412539601, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menueItems.count
    }
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return menueItems.count
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menueItems[indexPath.row].rawValue
        if menueItems[indexPath.row].rawValue == "Log out" {
            cell.textLabel?.textColor = #colorLiteral(red: 0.6109319925, green: 0.1044158116, blue: 0.03852597252, alpha: 1)
            cell.textLabel?.font = .boldSystemFont(ofSize: 17)
        } else {
            cell.textLabel?.textColor = .white
        }
        
        cell.contentView.backgroundColor = #colorLiteral(red: 0.2904876769, green: 0.4913773537, blue: 0.4412539601, alpha: 1)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = menueItems[indexPath.row]
        delegate?.didselectMenuItem(named: selectedItem)
    }
    
    
}
