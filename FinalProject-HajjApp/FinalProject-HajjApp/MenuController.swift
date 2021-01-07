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
    case contactUs = "Contact US"
    case sos = "SOS"
    case Chat = "Chat with translator"
    
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
        tableView.backgroundColor = #colorLiteral(red: 0.02360551991, green: 0.2150389254, blue: 0.2304697633, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.02360551991, green: 0.2150389254, blue: 0.2304697633, alpha: 1)
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
        cell.textLabel?.textColor = .white
        cell.contentView.backgroundColor = #colorLiteral(red: 0.02360551991, green: 0.2150389254, blue: 0.2304697633, alpha: 1)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = menueItems[indexPath.row]
        delegate?.didselectMenuItem(named: selectedItem)
    }
    
    
}
