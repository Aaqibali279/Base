// 
//  Network.swift
//  breadwallet
//
//  Created by ElintMinds_11 on 11/05/20.
//  Copyright © 2020 Breadwinner AG. All rights reserved.
//
//  See the LICENSE file at the project root for license information.
//


typealias Success<T:Decodable> = (_ data:T?,_ message:String?) -> ()
typealias ErrorMessage<U:Decodable> = (_ errors:U?,_ message:String?) -> ()

class Status<T:Decodable,U:Decodable>:Decodable {
    let data:T?
    let response:Response<U>?
}

struct Response<U:Decodable>:Decodable {
    let code:Int?
    let errors:U?
    let message:String?
}



enum Message {
    case custom(String)
    case message
    case network
    case email
    case password
    
    var value: String {
        switch self {
        case .custom(let message) : return message
        case .message : return "Something went wrong."
        case .network : return "Network not available."
        case .email : return "Please provide valid username or email."
        case .password : return "please enter valid Password."
        }
    }
}

import Foundation
import Alamofire



class NetworkManager {
    
    static let instance = NetworkManager()
    private init(){}
    
    
    //MARK:- REQUEST
    func request<T:Decodable,U:Decodable>(endPoint:ApiEndpoint,
                                          method:Alamofire.HTTPMethod = .post,
                                    parameters: [String: Any]? = nil,
                                    showIndicator: Bool = true,
                                    loadingMessage:String = "loading",
                                    success: Success<T>? = nil,
                                    errors:ErrorMessage<U>? = nil) {
        
        if !NetworkReachabilityManager()!.isReachable{
            errors?(nil,Message.network.value)
            return
        }
        
        var headers = [String:String]()
//        headers.append(HTTPHeader(name: "Content-Type", value: "application/json"))
        
        if let token:String = MyUserDefaults.instance.get(key: .accessToken),token.count > 0{
            headers["Authorization"] = "Bearer " + token
        }
        
        let urlString = baseUrl + endPoint.value
        
        debugPrint("********************************* API REQUEST START **************************************")
        debugPrint("Request URL: ",urlString)
        debugPrint("Request Parameters: ",parameters ?? "no parameters")
        debugPrint("Request Headers: ",headers)
        debugPrint("*************************************************** API REQUEST END *********************************")
        
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else{
            errors?(nil,Message.message.value)
            return
        }
        if showIndicator {
            ActivityIndicator.instance.show(with:loadingMessage)
        }
        
        
        Alamofire.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: headers).responseData { (dataResponse) in
                    
                    if showIndicator {
                        DispatchQueue.main.async {
                            ActivityIndicator.instance.hide()
                        }
                    }
                    
                    if let error = dataResponse.error{
                        errors?(nil,error.localizedDescription)
                        return
                    }
                    
                    guard let data = dataResponse.data else{
                        errors?(nil,Message.message.value)
                        return
                    }
                    
                    debugPrint("********************************* RESPONSE START **************************************")
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments)
                        debugPrint("JSON: ",json)
                    }catch{
                        debugPrint("ERROR:",error)
                    }
                    
                    do{
                        let status = try JSONDecoder().decode(Status<T,U>.self, from: data)
                        if let responseCode = status.response?.code{
                            switch responseCode {
                            case 200:
                                success?(status.data, status.response?.message)
                            default:
                                errors?(status.response?.errors,status.response?.message)
                            }
                        }
                    }catch{
                        errors?(nil,Message.message.value)
                        debugPrint("ERROR:",error)
                    }
                    debugPrint("********************************* RESPONSE END **************************************")
                    
        }
    }
    
    
    
    
    
    
    
    
    
    //    //MARK:- UPLOAD
    //    func upload(endpoint: Apis.ImageType, image: [String: Data],
    //                             parameters: [String: AnyObject]? = nil,
    //                             showIndicator: Bool? = true, success: @escaping Success<String?>
    //        , errorMessage:@escaping ErrorMessage) {
    //        if !NetworkReachabilityManager()!.isReachable {
    //            errorMessage(Message.network.value)
    //            return
    //        }
    //
    //        if showIndicator! {
    //            Indicator.instance.show()
    //        }
    //
    //        var headers = [String:String]()
    //
    //        if let token:String = MyUserDefaults.instance.get(key: .token),token.count > 0{
    //            headers["x-access-token"] = token
    //            headers["Content-Type"] = "multipart/form-data"
    //        }
    //        let apiString = Apis.baseUrl.rawValue + "uploadImage/" + endpoint.rawValue
    //        print(apiString)
    //        debugPrint("********************************* API Request **************************************")
    //        debugPrint("Request URL:\(apiString)")
    //        debugPrint("Request Parameters: \(parameters ?? [: ])")
    //        debugPrint("Request Headers: ",headers)
    //        debugPrint("************************************************************************************")
    //        var url = try! URLRequest.init(url: apiString, method: .post, headers: headers)
    //        url.timeoutInterval = 180
    //
    //
    //        Alamofire.upload(multipartFormData: { (formdata) in
    //            if let params = parameters {
    //                for (key, value) in params {
    //                    formdata.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
    //                }
    //            }
    //                for (key,value) in image {
    //                    let interval = NSDate().timeIntervalSince1970 * 1000
    //                    let imgMimeType : String = "image/jpg"
    //                    let imgFileName = "img\(interval).jpg"
    //                    formdata.append(value, withName: key, fileName: imgFileName, mimeType: imgMimeType)
    //                }
    //
    //        },with: url) { (encodingResult) in
    //            switch encodingResult {
    //            case .success(let upload,_,_):
    //                upload.uploadProgress(queue: .global(qos: .background)) { (progress) in
    //                    print("PROGRESS",progress)
    //                }
    //                upload.responseData(completionHandler: { (dataResponse) in
    //                    if showIndicator! {
    //                        DispatchQueue.main.async {
    //                            Indicator.instance.hide()
    //                        }
    //                    }
    //
    //                    if let error = dataResponse.error{
    //                        errorMessage(error.localizedDescription)
    //                        return
    //                    }
    //
    //                    guard let data = dataResponse.data else{
    //                        errorMessage(Message.message.value)
    //                        return
    //                    }
    //
    //                    debugPrint("********************************* RESPONSE START **************************************")
    //                    do{
    //                        let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments)
    //                        debugPrint("JSON: ",json)
    //                    }catch{
    //                        debugPrint("JSON ERROR:",error)
    //                    }
    //
    //                    do{
    //                        let status = try JSONDecoder().decode(Status<String>.self, from: data)
    //                        if status.status ?? false{
    //                            success(status.data,status.message)
    //                        }else{
    //                            errorMessage(status.message)
    //                        }
    //                    }catch{
    //                        errorMessage(Message.message.value)
    //                        debugPrint("ERROR:",error)
    //                    }
    //                    debugPrint("********************************* RESPONSE END **************************************")
    //                })
    //
    //            case .failure(let error):
    //                errorMessage(error.localizedDescription)
    //            }
    //        }
    //    }
    
    
    
}
