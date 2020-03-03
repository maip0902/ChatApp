//
//  ChatViewController.swift
//  Chat
//
//  Created by 舞 on 2020/02/21.
//  Copyright © 2020 mai kanda. All rights reserved.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import FirebaseDatabase

class ChatViewController: MessagesViewController {

//    let user1 = MockUser(senderId: "鈴木", displayName: "鈴木")
//    let user2 = MockUser(senderId: "佐藤", displayName: "佐藤")
    
    var messages: [MockMessage] = []
    //データベース初期化
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        createFirebaseMessage()
    }
    
    
//    func createSampleMessage() {
//        let mes1 = MockMessage(text: "鈴木ですこんにちは", user: user1, messageId: UUID().uuidString, date: Date())
//        let mes2 = MockMessage(text: "佐藤ですこんにちは", user: user2, messageId: UUID().uuidString, date: Date())
//        let mes3 = MockMessage(text: "天気がいいですね", user: user1, messageId: UUID().uuidString, date: Date())
//        let mes4 = MockMessage(text: "そうですね", user: user2, messageId: UUID().uuidString, date: Date())
//
//        self.messages.append(mes1)
//        self.messages.append(mes2)
//        self.messages.append(mes3)
//        self.messages.append(mes4)
//
//        self.messagesCollectionView.reloadData()
//    }
    
    func createFirebaseMessage()
    {
        // valueのイベントリスナー
        // 子ノードが追加された時に発火
        self.ref.observe(DataEventType.childAdded, with: { (snapshot) in
          let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            
            if let name = postDict["name"] as? String, let message = postDict["message"] as? String {
                
                let user = MockUser(senderId: name, displayName: name)
                let mes = MockMessage(text: message, user: user, messageId: UUID().uuidString, date: Date())
                self.messages.append(mes)
                self.messagesCollectionView.reloadData()
                self.messagesCollectionView.scrollToBottom()
            }
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ChatViewController: MessagesDataSource {
    // 送信者が誰か
    func currentSender() -> SenderType {
        return MockUser(senderId: "佐藤", displayName: "佐藤")
    }

    //表示するmessge数
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    // 日時ラベル
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd HH:mm"
        let dateString = formatter.string(from: message.sentDate)
        return NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption2)])
    }

    
}

extension ChatViewController: MessagesLayoutDelegate {
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 15
    }
    
    func cellBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 15
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 15
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 15
    }
}

extension ChatViewController: MessagesDisplayDelegate {
    // 送信ユーザーなら白
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .darkText
    }
    // 吹き出しの向きを送信側と受信側で変える
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let tail: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(tail, .curved)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let avatar = Avatar(image: nil, initials: message.sender.displayName)
        avatarView.set(avatar: avatar)
    }
}

extension ChatViewController: MessageInputBarDelegate {

func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {

    let messageData = [
        "name" : "佐藤",
        "message" : text
    ]
    self.ref.childByAutoId().setValue(messageData)
    }
}
