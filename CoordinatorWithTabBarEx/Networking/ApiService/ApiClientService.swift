//
//  ApiClientService.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import Foundation

protocol ApiClientService {
    func request<T: Decodable>(
        endPoint: String,
        decodeType: T.Type
    ) async throws -> T
}

struct ApiClientServiceImpl: ApiClientService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(
        endPoint: String,
        decodeType: T.Type
    ) async throws -> T {
        guard let url = URL(string: endPoint) else {
            throw ApiError.errorInUrl
        }
        
        return try await makeRequest(url: url)
    }
    
    private func makeRequest<T: Decodable>(url: URL) async throws -> T {
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await session.data(for: urlRequest)
        return try validateHttpResponse(data: data, response: response)
    }
    
    private func validateHttpResponse<T: Decodable>(
        data: Data,
        response: URLResponse
    ) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.unknownError
        }
        
        switch httpResponse.statusCode {
        case HttpStatusResponse.ok:
            return try decodeModel(data: data)
        case HttpStatusResponse.clientError:
            throw ApiError.clientError
        case HttpStatusResponse.serverError:
            throw ApiError.serverError
        default:
            throw ApiError.unknownError
        }
    }
    
    private func decodeModel<T: Decodable>(
        data: Data
    ) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
