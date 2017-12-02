//
//  GroupsViewController.swift
//  Stock
//
//  Created by Kim Younghoo on 11/28/17.
//  Copyright © 2017 0hoo. All rights reserved.
//

import UIKit

//[C8-4]
typealias Groups = [Group]

class GroupsViewController: UIViewController {

    //[C4-3]
    @IBOutlet weak var tableView: UITableView!
    
    //[C4-6]
    //var groups: [Group] = [Group(title: "성장", note: "성장하는 종목들")]
    //[C8-5]
    var groups: Groups = [Group(title: "성장", note: "성장하는 종목들")]
    
    deinit {
        //[C10-14]
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //[C10-13]
        NotificationCenter.default.addObserver(self, selector: #selector(deleteGroup(_:)), name: Group.didDelete, object: nil)
        
        //[C3-6]
        title = "그룹"
        
        //[C3-8]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-add_folder"), style: .plain, target: self, action: #selector(newGroup))
        
        //[C12-1]
        tableView.separatorColor = .separator
        //[C12-4]
        tableView.hideBottomSeparator()
        
        //[C8-6]
        reload()
    }
    
    //[C10-15]
    @objc func deleteGroup(_ notification: Notification) {
        guard let groupToDelete = notification.object as? Group else { return }
        guard let index = groups.index(where: { $0.title == groupToDelete.title }) else { return }
        
        //[C10-15]
        //groups.remove(at: index)
        //saveGroups()
        //tableView.reloadData()

        //[C12-6]
        removeGroupAt(index)
    }
    
    @IBAction func newGroup() {
        //[C5-8]
        //present(EditGroupViewController(), animated: true, completion: nil)

        //[C9-4]
        let editGroupViewController = EditGroupViewController(group: nil)
        
        //[C7-5]
        editGroupViewController.didSaveGroup = { group in
            self.groups.append(group)
            //[C8-5]
            self.saveGroups()
        }
        //[C5-9]
        let navigationController = UINavigationController(rootViewController: editGroupViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    //[C8-3]
    func reload() {
        if let data = UserDefaults.standard.object(forKey: "groups") as? Data {
            groups = try! PropertyListDecoder().decode(Groups.self, from: data)
        }
        
        tableView.reloadData()
    }
    
    //[C8-2]
    func saveGroups() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(groups), forKey: "groups")
        UserDefaults.standard.synchronize()
    }
    
    //[C12-6]
    private func removeGroupAt(_ index: Int) {
        groups.remove(at: index)
        saveGroups()
        tableView.reloadData()
    }
}

//[C4-10]
extension GroupsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //[C4-11]
        //return 0
        
        return groups.count
    }
    
    //[C12-5]
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //[C12-6]
            removeGroupAt(indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //[C4-12]
        //return UITableViewCell()
        
        //[C4-16]
        let cell = UITableViewCell()
        cell.textLabel?.text = groups[indexPath.row].title
        return cell
    }
}

//[C4-13]
extension GroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //[C4-14]
        tableView.deselectRow(at: indexPath, animated: true)
        
        //[C9-5]
        let editGroupViewController = EditGroupViewController(group: groups[indexPath.row])
        editGroupViewController.didSaveGroup = { group in
            self.saveGroups()
            self.tableView.reloadData()
        }
        let navigationController = UINavigationController(rootViewController: editGroupViewController)
        present(navigationController, animated: true, completion: nil)
    }
}
