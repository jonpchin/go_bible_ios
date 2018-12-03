//
//  bookListTableViewController.swift
//  go_bible
//
//  Created by Jonathan Chin on 11/19/18.
//  Copyright © 2018 goplaychess. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class bookListTableViewController: UITableViewController {
    
    var books = [String]();
    @IBOutlet weak var sortBooks: UISwitch!
    var selectedBookVersion: String = ""
    var chapterText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bookVersions = ["ASV", "KJV", "Webster", "World English"]
        let defaultBookVersionIndex = 1
        selectedBookVersion = bookVersions[defaultBookVersionIndex]
        
        let menuView = BTNavigationDropdownMenu(title: BTTitle.index(defaultBookVersionIndex), items: bookVersions)
        self.navigationItem.titleView = menuView
        
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            self.selectedBookVersion = bookVersions[indexPath]
        }
        
        sortBooks.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        setDefaultBookOrder()
    }
    
    // Returns blank string means the chapter failed to load
    static func readChapter(bookTitle: String, chapterNum: String, bookVersion: String) -> String {
        
        var chapterText:String = "";
        
        let selectedBookDir = (((((Bundle.main.resourcePath! as NSString).appendingPathComponent("assets") as NSString).appendingPathComponent(bookVersion) as NSString).appendingPathComponent(bookTitle) as NSString).appendingPathComponent(bookTitle +  chapterNum + ".txt") as NSString)

        do {
            chapterText = try String(contentsOfFile: selectedBookDir as String)
        }catch{
            
        }
        return chapterText
    }
    
    func switchScreen(bookTitle: String) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "readBook") as! readBook
        
        vc.chapterText = bookListTableViewController.readChapter(bookTitle: bookTitle, chapterNum: "1", bookVersion: selectedBookVersion)

        vc.bookTitle = bookTitle
        vc.chapterNum = "1"
        vc.bookVersion = selectedBookVersion
        navigationController?.pushViewController(vc, animated: true)
    }
  
    @objc func switchChanged(mySwitch: UISwitch) {
        if mySwitch.isOn {
            setDefaultBookOrder();
        }else{
            books.sort()
        }
        tableView.reloadData()
    }
    
    func setDefaultBookOrder(){
        books.removeAll();
        books.append("Genesis");
        books.append("Exodus");
        books.append("Leviticus");
        books.append("Numbers");
        books.append("Deuteronomy");
        
        books.append("Joshua");
        books.append("Judges");
        books.append("Ruth");
        books.append("1 Samuel");
        books.append("2 Samuel");
        
        books.append("1 Kings");
        books.append("2 Kings");
        books.append("1 Chronicles");
        books.append("2 Chronicles");
        books.append("Ezra");
        
        books.append("Nehemiah");
        books.append("Esther");
        books.append("Job");
        books.append("Psalms");
        books.append("Proverbs");
        
        books.append("Ecclesiastes");
        books.append("Song of Solomon");
        books.append("Isaiah");
        books.append("Jeremiah");
        books.append("Lamentations");
        
        books.append("Ezekiel");
        books.append("Daniel");
        books.append("Hosea");
        books.append("Joel");
        books.append("Amos");
        
        books.append("Obadiah");
        books.append("Jonah");
        books.append("Micah");
        books.append("Nahum");
        books.append("Habakkuk");
        
        books.append("Zephaniah");
        books.append("Haggai");
        books.append("Zechariah");
        books.append("Malachi");
        
        books.append("Matthew");
        
        books.append("Mark");
        books.append("Luke");
        books.append("John");
        books.append("Acts of the Apostles");
        books.append("Romans");
        
        books.append("1 Corinthians");
        books.append("2 Corinthians");
        books.append("Galatians");
        books.append("Ephesians");
        books.append("Philippians");
        
        books.append("Colossians");
        books.append("1 Thessalonians");
        books.append("2 Thessalonians");
        books.append("1 Timothy");
        books.append("2 Timothy");
        
        books.append("Titus");
        books.append("Philemon");
        books.append("Hebrews");
        books.append("James");
        books.append("1 Peter");
        
        books.append("2 Peter");
        books.append("1 John");
        books.append("2 John");
        books.append("3 John");
        books.append("Jude");
        books.append("Revelation");
    }
    
    func contentsOfDirectoryAtPath(path: String) -> [String]? {
        guard let paths = try? FileManager.default.contentsOfDirectory(atPath: path) else { return nil}
        return paths.map { aContent in (path as NSString).appendingPathComponent(aContent)}
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        cell.textLabel?.text = books[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.switchScreen(bookTitle: books[indexPath.row])
    }
}
