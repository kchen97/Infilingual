//
//  ViewController.swift
//  Infilingual
//
//  Created by Korman Chen on 1/18/18.
//  Copyright © 2018 Korman Chen. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework
import AVFoundation
import SVProgressHUD

class ChatViewController: UITableViewController, AVAudioRecorderDelegate {

    private var messageArray = [Message]()
    private var recordButton = UIButton()
    var recordingSession : AVAudioSession!
    var audioRecorder : AVAudioRecorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        configureTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        //cell.avatarImageView.image = UIImage(named: "egg")
        
        if cell.senderUsername.text == FIRAuth.auth()?.currentUser?.email as String! {
            cell.avatarImageView.backgroundColor = UIColor.flatMaroon()
            cell.messageBackground.backgroundColor = UIColor.flatWatermelon()
        }
        else {
            cell.messageBackground.backgroundColor = UIColor.flatSkyBlue()
            cell.avatarImageView.backgroundColor = UIColor.flatBlue()
        }
        
        return cell
    }
    
    //MARK: Functions
    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120.00
        tableView.separatorStyle = .none
        
        recordButton.setImage(UIImage(named: "microphone.png" ), for: .normal)
        recordButton.setImage(UIImage(named: "microphoneSelected.png"), for: .selected)
        recordButton.addTarget(self, action: #selector(record), for: .touchUpInside)
        tableView.addSubview(recordButton)
        
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        recordButton.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        recordButton.leftAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.leftAnchor).isActive = true
        recordButton.rightAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.rightAnchor).isActive = true
        recordButton.widthAnchor.constraint(equalToConstant: 128).isActive = true
        recordButton.heightAnchor.constraint(equalToConstant: 128).isActive = true
    }
    
    func setupAudioProperties() {
        recordingSession = AVAudioSession.sharedInstance()
        AVAudioSession.sharedInstance().requestRecordPermission { (allowed) in
            if allowed {
                print("allowed")
            }
        }
    }
    
    func getDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    
    
    @objc func record() {
        if audioRecorder == nil {
            
            let fileName = getDirectory().appendingPathComponent("voice.wav")
        }
    }
    
}

