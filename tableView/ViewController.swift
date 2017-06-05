//
//  ViewController.swift
//  tableView
//
//  Created by Dakshesh patel on 4/8/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    public var names: [String] = [];
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var chat: UITextField!
    @IBOutlet weak var tblBottom: NSLayoutConstraint!
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var chatview: UIView!
    @IBOutlet weak var containerBtmConstrain: NSLayoutConstraint!
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet weak var innerView: UIView!
    var keyBoardHeight : Bool = false;
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBAction func send(_ sender: Any) {
        
        let nameToSave = chat.text;
        
        self.names.append(nameToSave!)
        self.tbl.reloadData()
        self.tbl.scrollToRow(at: self.tbl.lastIndexPath!, at: .bottom, animated: false);
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImg.layer.masksToBounds = true
        profileImg.layer.cornerRadius = profileImg.frame.size.height/2
        self.chat.delegate = self ;
        tbl.delegate = self;
        tbl.dataSource = self;
        tbl.backgroundColor = UIColor.clear;
       
        //make the table view cells self sizing depends on content - by setting label -> lines 0
        tbl.rowHeight = UITableViewAutomaticDimension
        tbl.estimatedRowHeight = 140
        tbl.separatorColor = UIColor.clear;
        
        
        let path = UIBezierPath(roundedRect: self.view.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width : 40, height : 40))
        let shape = CAShapeLayer()
            shape.path = path.cgPath
        self.backImage.layer.mask = shape
       
        
       // self.watchForKeyboard()
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        chat.resignFirstResponder()
        
        return true
    }
    
    //
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
        let cell = tbl.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell;
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
               
                
                if(self.tbl.contentSize.height < keyboardFrame.size.height){
                   
                  self.tbl.frame.size = CGSize(width: UIScreen.main.bounds.width, height: self.innerView.frame.height - keyboardFrame.height - chatview.frame.height)
                    self.tbl.frame.origin.y = keyboardFrame.height
                }
                
                
                 self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.height, 0)

                self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, keyboardFrame.height, 0)
             
                var aRect : CGRect = self.innerView.frame
                aRect.size.height -= keyboardFrame.height
                self.scrollView.contentOffset = CGPoint(x:self.scrollView.contentOffset.x, y:0 + keyboardFrame.height)
                if let actField = chat
                {
                    if (aRect.contains(chat.frame.origin))
                    {
                        scrollView.scrollRectToVisible(chatview.frame, animated: false)
                    }
                }
                
            }
        }
        
        
    }

    //
    
     func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0, animations: { () -> Void in
           self.tbl.frame.size = CGSize(width: UIScreen.main.bounds.width, height: self.innerView.frame.height - self.chatview.frame.height)
            
             self.tbl.frame.origin.y = 0
             self.tbl.contentInset = UIEdgeInsetsMake(0,0,0,0);
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            self.view.layoutIfNeeded()
        })
    }

}
extension UITableView {
    
    var lastIndexPath: IndexPath? {
        
        let lastSectionIndex = numberOfSections - 1
        guard lastSectionIndex >= 0 else { return nil }
        
        let lastIndexInLastSection = numberOfRows(inSection: lastSectionIndex) - 1
        guard lastIndexInLastSection >= 0 else { return nil }
        
        return IndexPath(row: lastIndexInLastSection, section: lastSectionIndex)
    }
  
    
    
}
extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}
private var xoAssociationKeyForBottomConstrainInVC: UInt8 = 0
private var table: UInt8 = 1
private var arry : UInt = 2


