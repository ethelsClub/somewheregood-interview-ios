
import UIKit
import Foundation


class DMViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        Service.loadMessage()
    }
}



final class Service {
    
    
   static func loadMessage() {
        
        guard let dmURL = SGURLRequest.dmURL else {
            return
        }
        
    var request = URLRequest(url: dmURL)
    
    URLSession.shared.dataTask(with: request) { (data, res, error) in
        //
        
        guard let data = data else {
            // handles this after
            return
        }
        
        /**
          // kinda messy but quick json paser
         let paser = try? JSONSerialization.jsonObject(with: data, options: [])
         print(paser)
         
         */
        let decoder = JSONDecoder()
        
        let decodedData = try? decoder.decode([DMList].self, from: data)
        print(decodedData)
        
        // try to get one user test
        if let user = decodedData?[0] {
            let name = user.participants[0].name
            print("V: 🦕", name)
        }

    }.resume()
    
    }
}


/**
 
 https://lgb8ppx4e5.execute-api.us-east-1.amazonaws.com/dev/messages
 
 */

struct SGURLRequest {
    
    static var dmURL : URL? {
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "lgb8ppx4e5.execute-api.us-east-1.amazonaws.com"
        comp.path = "/dev/messages"
        // add chanel later here
        return comp.url
    }
}

struct DMList: Codable {
    var channelId : Int
    var participants : [DMModel]
    
    enum CodingKeys: String, CodingKey {
        case channelId = "channel_id"
        case participants = "participants"
    }
}

struct DMModel: Codable {
    var name: String
    var profileURL : String
    var userId : Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case profileURL = "profile_img_url"
        case userId = "user_id"
    }
}
