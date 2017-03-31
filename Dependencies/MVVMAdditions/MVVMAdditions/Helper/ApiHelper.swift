//
//  ApiHelper.swift
//  View
//
//  Created by Giáp Trần on 12/7/16.
//  Copyright © 2016 Giáp Trần. All rights reserved.
//

import Alamofire
import KeychainSwift
import SwiftyJSON

public class ApiHelper: NSObject {

    // MARK: Property
    
    public typealias ResponseHandler = (JSON?, Error?) -> Void
    
    private let baseUrl: String
    
    private var defaultHeaders: HTTPHeaders {
        var headers = HTTPHeaders()
        if let jwt = KeychainSwift.jwt {
            headers["Authorization"] = "Bearer \(jwt)"
        }
        return headers
    }
    
    // MARK: Constructor
    
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    
        super.init()
    }
    
    // MAKR: Public method
    
    public func get(
        _ url           : URLConvertible,
        parameters      : Parameters? = nil,
        headers         : HTTPHeaders? = nil,
        responseHandler : @escaping ResponseHandler) {

        request(
            url,
            method          : .get,
            parameters      : parameters,
            encoding        : URLEncoding.default,
            headers         : headers,
            responseHandler : responseHandler
        )
    }
    
    public func post(
       _ url            : URLConvertible,
        parameters      : Parameters? = nil,
        encoding        : ParameterEncoding = URLEncoding.default,
        headers         : HTTPHeaders? = nil,
        responseHandler : @escaping ResponseHandler) {
        
        request(
            url,
            method          : .post,
            parameters      : parameters,
            encoding        : encoding,
            headers         : headers,
            responseHandler : responseHandler
        )
    }
    
    public func put(
        _ url           : URLConvertible,
        parameters      : Parameters? = nil,
        encoding        : ParameterEncoding = URLEncoding.default,
        headers         : HTTPHeaders? = nil,
        responseHandler : @escaping ResponseHandler) {
        
        request(
            url,
            method          : .put,
            parameters      : parameters,
            encoding        : encoding,
            headers         : headers,
            responseHandler : responseHandler
        )
    }
    
    public func delete(
        _ url           : URLConvertible,
        parameters      : Parameters? = nil,
        encoding        : ParameterEncoding = URLEncoding.default,
        headers         : HTTPHeaders? = nil,
        responseHandler : @escaping ResponseHandler) {
        
        request(
            url,
            method          : .delete,
            parameters      : parameters,
            encoding        : encoding,
            headers         : headers,
            responseHandler : responseHandler
        )
    }
    
    public func patch(
        _ url           : URLConvertible,
        parameters      : Parameters? = nil,
        encoding        : ParameterEncoding = URLEncoding.default,
        headers         : HTTPHeaders? = nil,
        responseHandler : @escaping ResponseHandler) {
        
        request(
            url,
            method          : .patch,
            parameters      : parameters,
            encoding        : encoding,
            headers         : headers,
            responseHandler : responseHandler
        )
    }
    
    public func upload(
        _ url           : URLConvertible,
        parameters      : Parameters? = nil,
        headers         : HTTPHeaders? = nil,
        responseHandler : @escaping ResponseHandler) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.upload(multipartFormData: { (formData) in
            
            if let hasParam = parameters {
                for (key, value) in hasParam {
                    if let url = value as? URL {
                        formData.append(url, withName: key)
                    } else {
                        formData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                }
            }
        }, to: "\(baseUrl)\(url)", headers: headers ?? defaultHeaders) { (completion) in
            switch completion {
            case .success(let request, _, _):
                request.validate(statusCode: 200..<300)
                       .responseJSON { response in
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        self.handleResponse(response, responseHandler: responseHandler)
                }
            case .failure(let error):
                responseHandler(nil, error)
            }
        }
    }
    
    public func upload(
        _ url           : URLConvertible,
        parameters      : Parameters? = nil,
        headers         : HTTPHeaders? = nil,
        progressHandler : @escaping Request.ProgressHandler,
        responseHandler : @escaping ResponseHandler) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.upload(multipartFormData: { (formData) in
            
            if let hasParam = parameters {
                for (key, value) in hasParam {
                    if let url = value as? URL {
                        formData.append(url, withName: key)
                    } else {
                        formData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                }
            }
        }, to: "\(baseUrl)\(url)", headers: headers ?? defaultHeaders) { (completion) in
            switch completion {
            case .success(let request, _, _):
                request.uploadProgress(closure: progressHandler)
                       .validate(statusCode: 200..<300)
                       .responseJSON { response in
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        self.handleResponse(response, responseHandler: responseHandler)
                }
            case .failure(let error):
                responseHandler(nil, error)
            }
        }
    }
    
    // MARK: Private method
    
    private func request(
        _ url           : URLConvertible,
        method          : Alamofire.HTTPMethod,
        parameters      : Parameters? = nil,
        encoding        : ParameterEncoding = URLEncoding.default,
        headers         : HTTPHeaders? = nil,
        responseHandler : @escaping ResponseHandler) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request("\(baseUrl)\(url)", method: method, parameters: parameters, encoding: encoding, headers: headers ?? defaultHeaders)
                 .validate(statusCode: 200..<300)
                 .responseJSON { response in
                
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.handleResponse(response, responseHandler: responseHandler)
        }
    }

    private func handleResponse(_ response: DataResponse<Any>, responseHandler: ResponseHandler) {
        switch response.result {
        case .success:
            if let value = response.result.value {
                let json = JSON(value)
                responseHandler(json, json.error)
            } else {
                responseHandler(nil, response.result.error)
            }
        case .failure(let error):
            responseHandler(nil, error)
        }
    }

}
