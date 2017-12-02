//
//  EditGroupViewController.swift
//  Stock
//
//  Created by Kim Younghoo on 11/28/17.
//  Copyright © 2017 0hoo. All rights reserved.
//

import UIKit

class EditGroupViewController: UIViewController {

    //[C4-5]
    @IBOutlet weak var tableView: UITableView!

    //[C9-1]
    let group: Group?
    
    //[C7-2]
    var titleField: UITextField?
    var noteField: UITextField?
    
    //[C7-1]
    var didSaveGroup: ((Group) -> Void)?
    
    //[C9-2]
    init(group: Group?) {
        self.group = group
        super.init(nibName: nil, bundle: nil)
    }
    
    //[C9-3]
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //[C5-11]
        //title = "새그룹"
        title = group?.title ?? "새그룹"
        //[C5-11]
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismiss_))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        
        //[C10-8]
        tableView.backgroundColor = .backgroundView
        tableView.separatorColor = .separator
        //[C6-21]
        tableView.register(UINib(nibName: TextFieldTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TextFieldTableViewCell.reuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //[C11-1]
        titleField?.becomeFirstResponder()
    }
    
    //[C5-11]
    @objc func dismiss_() {
        //[C11-2]
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    //[C5-12]
    @objc func save() {
        //[C7-4]
        guard let title = titleField?.text, let note = noteField?.text, !title.isEmpty else { return }
        //[C7-4]
        //let newGroup = Group(title: title, note: note)
        //didSaveGroup?(newGroup)
        
        //[C9-7]
        if let group = group {
            group.title = title
            group.note = note
            didSaveGroup?(group)
        } else {
            //[C9-7]
            let newGroup = Group(title: title, note: note)
            didSaveGroup?(newGroup)
        }
        
        dismiss_()
    }
}

extension EditGroupViewController: UITableViewDataSource {
    //[C10-1]
    func numberOfSections(in tableView: UITableView) -> Int {
        return group != nil ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //[C10-2]
        if section == 0 {
            //[C5-14]
            return 2
        } else if section == 1 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //[C10-3]
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                //[C6-22]
                let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.reuseIdentifier, for: indexPath) as! TextFieldTableViewCell
                //[C7-3]
                titleField = cell.textField
                //[C11-3]
                titleField?.returnKeyType = .next
                //[C11-4]
                titleField?.delegate = self
                //[C6-22]
                cell.label?.text = "그룹명:"
                cell.textField?.placeholder = "그룹의 이름을 입력하세요"
                //[C9-6]
                cell.textField?.text = group?.title
                return cell
            } else if indexPath.row == 1 {
                //[C6-22]
                let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.reuseIdentifier, for: indexPath) as! TextFieldTableViewCell
                //[C7-3]
                noteField = cell.textField
                //[C11-3]
                noteField?.returnKeyType = .done
                //[C11-4]
                noteField?.delegate = self
                //[C6-22]
                cell.label?.text = "설명:"
                cell.textField?.placeholder = "그룹의 설명을 입력하세요"
                //[C9-6]
                cell.textField?.text = group?.note
                return cell
            }
        } else if indexPath.section == 1 && indexPath.row == 0 {
            var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.reuseIdentifier)
            }
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .red
            cell.textLabel?.text = "그룹삭제"
            return cell
        }
        
        return UITableViewCell()
    }
    
    //[C10-5]
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    //[C10-5]
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        view.backgroundColor = .clear
        return view
    }
}

extension EditGroupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 && indexPath.row == 0 {
            //[C10-9]
            let alert = UIAlertController(title: "그룹삭제", message: "그룹을 삭제하시겠습니까? 종목이 같이 삭제 되지 않습니다.", preferredStyle: .alert)
            //[C10-10]
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                //[C10-12]
                NotificationCenter.default.post(name: Group.didDelete, object: self.group)
                self.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
        }
    }
}

//[C11-4]
extension EditGroupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleField {
            noteField?.becomeFirstResponder()
        } else if textField == noteField {
            save()
        }
        return true
    }
}
