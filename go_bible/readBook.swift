//
//  readBook.swift
//  go_bible
//
//  Created by Jonathan Chin on 11/22/18.
//  Copyright © 2018 goplaychess. All rights reserved.
//

import UIKit
import Foundation

class readBook: UIViewController {
    var chapterText:String = ""
    var bookVersion:String = "KJV" // default book version is KJV
    var bookTitle:String = ""
    var chapterNum:String = "1"
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var  uiScrollView : UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = chapterText
        self.navigationItem.title = bookTitle + " " + chapterNum
        
        let nextChapterButton = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(goNextChapter))
        let previousChapterButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(goBackChapter))
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchChapter))
        
        let changeFont = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(increaseFontSize))
  
        
        navigationItem.rightBarButtonItems = [nextChapterButton, previousChapterButton, searchButton, changeFont]
    }
    
    @objc func increaseFontSize(){
        
        let alert = UIAlertController(title: "Enter desired font size", message: "Current font size: " + textView.font!.pointSize.description, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in })
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { (action: UIAlertAction!) in
            
            let textField = alert.textFields![0] as UITextField
            textField.keyboardType = UIKeyboardType.numberPad

            guard let n = NumberFormatter().number(from: textField.text!) else { return }
            self.textView.font = .systemFont(ofSize: CGFloat(truncating: n))
        })
        
        alert.addTextField(configurationHandler: { textField in
            textField.keyboardType = UIKeyboardType.numberPad
        })
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // Gets next or previous chapter
    func gotoChapter(targetChapter: Int) {

        let chapterContents:String = bookListTableViewController.readChapter(bookTitle: bookTitle, chapterNum: String(targetChapter), bookVersion: bookVersion)
        if chapterContents != "" {
            chapterNum = String(targetChapter)
            textView.text = chapterContents
            self.navigationItem.title = bookTitle +  " " + String(targetChapter)
        }
    }
    
    @objc func goNextChapter(sender: UIButton!) {
        gotoChapter(targetChapter: Int(chapterNum)!  + 1)
    }
    @objc func goBackChapter(sender: UIButton!) {
        gotoChapter(targetChapter: Int(chapterNum)!  - 1)
    }
    @objc func searchChapter(sender: UIButton!) {
        let alert = UIAlertController(title: "Search Chapter", message: "Enter the chapter you want to jump too.", preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in })
        
        let saveAction = UIAlertAction(title: "Jump", style: .default, handler: { (action: UIAlertAction!) in
            
            let textField = alert.textFields![0] as UITextField
            textField.keyboardType = UIKeyboardType.numberPad
            
            self.gotoChapter(targetChapter: Int(textField.text!)!)
        })
        
        alert.addTextField(configurationHandler: { textField in
            textField.keyboardType = UIKeyboardType.numberPad
        })
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
