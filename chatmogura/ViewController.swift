//
//  ViewController.swift
//  chatmogura
//
//  Created by 片平駿介 on 2019/03/23.
//  Copyright © 2019 片平駿介. All rights reserved.
//

import UIKit
import SVProgressHUD
import JSQMessagesViewController
import Firebase
import FirebaseAuth
import FirebaseDatabase

//class ViewController: UIViewController {
class ViewController: JSQMessagesViewController {
    
    var messages: [JSQMessage] = [JSQMessage(senderId: "Tsuru", displayName: "tsuru", text: "こんにちは！！"),JSQMessage(senderId: "Gami", displayName: "gami", text: "こんにちは！！")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        senderDisplayName = "tsuru"
        senderId = "Tsuru"
        // Do any additional setup after loading the view, typically from a nib.
        SVProgressHUD.show();
    }
    
    override func collectionView(_ collectionView:JSQMessagesCollectionView!,messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
    
    // コメントの背景色の指定
    override func collectionView(_ collectionView:JSQMessagesCollectionView!,messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        if messages[indexPath.row].senderId == senderId {
            return JSQMessagesBubbleImageFactory()?.outgoingMessagesBubbleImage(with: UIColor(red: 112/255, green: 192/255, blue: 75/255, alpha: 1))
            
        } else {
            return JSQMessagesBubbleImageFactory()?.incomingMessagesBubbleImage(with: UIColor(red: 112/255, green: 192/255, blue: 229/255, alpha: 1))
        }
    }
    
    // コメントの文字色の指定
    override func collectionView(_ collectionView:
        UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        if messages[indexPath.row].senderId == senderId {
            cell.textView.textColor = UIColor.white
        } else {
            cell.textView.textColor = UIColor.darkGray
        }
        return cell
    }
    
    // メッセージの数
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return messages.count
    }
    
    // ユーザのアバターの設定
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        /*
        return JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: messages[IndexPath.row].senderDisplayName, backgroundColor: UIColor.lightGray, textColor: UIColor.white, font: UIFont.systemFont(ofSize: 10), diameter: 30)
        */
        return JSQMessagesAvatarImageFactory.avatarImage(
            withUserInitials: messages[indexPath.row].senderDisplayName,
            backgroundColor: UIColor.lightGray,
            textColor: UIColor.white,
            font: UIFont.systemFont(ofSize: 10),
            diameter: 30)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    送信ボタン押下時
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        inputToolbar.contentView.textView.text = ""
       let ref = FIRDatabase.database().reference()
        ref.child("messages").childByAutoId().setValue(["senderId": senderId, "text": text, "displayName": senderDisplayName])
    }
}

