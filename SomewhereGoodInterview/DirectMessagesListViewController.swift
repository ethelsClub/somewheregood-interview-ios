//
//  DirectMessagesListViewController.swift
//  SomewhereGoodInterview
//
//  Created by Vanessa Flores on 1/15/21.
//

import UIKit

struct Participant: Codable {
    
    let userId: Int
    let name: String
    let profileImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "channel_id"
        case name
        case profileImageURL = "profile_img_url"
    }
}

struct DirectMessage: Codable {
    
    let channelId: Int
    let participants: [Participant]
    
    enum CodingKeys: String, CodingKey {
        case channelId = "channel_id"
        case participants
    }
}

struct Model: Codable {
    
    let value: [DirectMessage]
}

class DirectMessagesListViewController: UIViewController {
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDirectMessages()
    }
    
    // MARK: - Network
    
    private func loadDirectMessages() {
        
        networkManager.fetchDirectMessages { result in
            
            switch result {
            case .success(let messages):
                print(messages)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}
