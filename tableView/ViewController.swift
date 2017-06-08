//
//  ViewController.swift
//  tableView
//
//  Created by Dakshesh patel on 4/8/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit
import GrowingTextView

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource ,GrowingTextViewDelegate{
   
    @IBOutlet weak var chatView: UIView!
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBOutlet weak var colView: UICollectionView!
    
    public var names: [String] = [];
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var chat: GrowingTextView!
    var placeholderLabel : UILabel!
    @IBOutlet weak var tblBottom: NSLayoutConstraint!
    
   
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBAction func send(_ sender: Any) {
        
        let nameToSave = chat.text;
        
        self.names.append(nameToSave!)
       
      
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImg.layer.masksToBounds = true
        profileImg.layer.cornerRadius = profileImg.frame.size.height/2
        
        chat.delegate = self
      
        //chat.translatesAutoresizingMaskIntoConstraints = true
        colView.delegate = self
        colView.dataSource = self
       
        
         
             // self.watchForKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            names.append(chat.text)
            chat.resignFirstResponder()
            colView.reloadData()
        }
        return true
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }

   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celll = colView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        //initialization of cell content
        celll.textView.text = names[indexPath.row]
        
        
        //bubble frame
        let bubbleFrame = getBubbleViewFrame(text: names[indexPath.row])
        
        
        //textview and uiview frames
        celll.textView.frame = CGRect(x: 40 + 8  , y: 0, width: bubbleFrame.width + 16, height: bubbleFrame.height + 20)
        celll.bgview.frame = CGRect(x: 40, y: 0, width: bubbleFrame.width + 8 + 16, height: bubbleFrame.height + 20)
        
        
        //create a shape around bubbleview
        let path = UIBezierPath(roundedRect: celll.bgview.bounds , byRoundingCorners: [.topLeft,.bottomRight], cornerRadii: CGSize(width : 10 , height : 10))
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        celll.bgview.layer.mask = shape
        
        
        
        return celll
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //initialization
        let messageText = names[indexPath.row]
        
        
        //bubble fram
       let bubbleFrame = getBubbleViewFrame(text: messageText)
        
        //return height
        return CGSize(width: view.frame.width, height: bubbleFrame.height + 20)
    }
    func keyboardWillChangeFrame(_ notification: Notification) {
        let endFrame = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        tblBottom.constant = UIScreen.main.bounds.height - endFrame.origin.y
       
       
        self.view.layoutIfNeeded()
    }
    
    func tapGestureHandler() {
        view.endEditing(true)
    }
        //
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
    
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //create bubble view frame and return it
    func getBubbleViewFrame(text : String) -> CGRect {
        
        //size = max width of bubbleview , and max height
        let size = CGSize(width: UIScreen.main.bounds.width/2, height: 1000)
        
        //options set textview as leading constraint and wrap it around
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        //CGRect frame create bubble view
        let estimateframe = NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12.0)], context: nil)
        
        return estimateframe
    }
    
    
    
}

extension UITableView {
    func scrollToBottom(animated: Bool = true) {
        let sections = self.numberOfSections
        let rows = self.numberOfRows(inSection: sections - 1)
        self.scrollToRow(at: NSIndexPath(row: rows - 1, section: sections - 1) as IndexPath, at: .bottom, animated: true)
    }
}



