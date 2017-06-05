//
//  ViewController.swift
//  tableView
//
//  Created by Dakshesh patel on 4/8/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    public var names: [String] = [];
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var chat: UITextField!
    @IBOutlet weak var tblBottom: NSLayoutConstraint!
    
    @IBOutlet weak var chatview: UIView!
    @IBOutlet weak var containerBtmConstrain: NSLayoutConstraint!
    @IBOutlet var scrollView: UIScrollView!
    
    var keyBoardHeight : Bool = false;
    
    @IBAction func send(_ sender: Any) {
        
        let nameToSave = chat.text;
        
        self.names.append(nameToSave!)
        self.tbl.reloadData()
        self.tbl.scrollToRow(at: self.tbl.lastIndexPath!, at: .bottom, animated: false);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chat.delegate = self ;
        tbl.delegate = self;
        tbl.dataSource = self;
        
        
        // self.watchForKeyboard()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        chat.resignFirstResponder()
        
        return true
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.watchForKeyboard()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCell(withIdentifier: "second") as? SecondViewCell;
        cell?.lbl.text = names[indexPath.row];
        return cell!;
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.chat = textField
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func watchForKeyboard () {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    func keyboardWasShown(notification: NSNotification) {
        if let dic = notification.userInfo {
            if let keyboardFrame = (dic[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue {
                
                //  containerBtmConstrain.constant = keyboardFrame.height
                self.tbl.scrollsToTop = true;
                
                self.tbl.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.height, 0)
                
                self.tbl.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, keyboardFrame.height, 0)
                
                
                self.tbl.contentOffset = CGPoint(x:0, y:0 + keyboardFrame.height)
                self.chatview.frame.origin.y = 1.0
                
            }
        }
        // self.view.layoutIfNeeded()
        
        
    }
    func appBecomeActive() {
        //reload your Tableview here
        self.tbl.reloadData()
    }
    
    
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0, animations: { () -> Void in
            
            self.tbl.contentInset = UIEdgeInsetsMake(0,0,0,0);
            self.tbl.scrollIndicatorInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
            self.view.layoutIfNeeded()
        })
    }
    
}

private var xoAssociationKeyForBottomConstrainInVC: UInt8 = 0
private var table: UInt8 = 1
private var arry : UInt = 2


