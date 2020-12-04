//
//  NetworkingClient.swift
//  Genus
//
//  Created by Orionsyrus24 on 12/4/20.
//


import Foundation
import Alamofire

class NetworkingClient {
    
    
typealias WebServiceResponse = ([[String: Any]]?, Error?) -> Void

func execute(_ url: URL, completion: @escaping WebServiceResponse) {

AF.request(url).validate().responseJSON { response in
if let error = response.error {
completion(nil, error)
}
else if let jsonArray = response.result as? [[String: Any]] {
completion(jsonArray,nil)
}
else if let jsonDict = response.result as? [String: Any] {
completion([jsonDict],nil)
}
}
}
    
}
