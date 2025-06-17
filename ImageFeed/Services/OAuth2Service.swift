import UIKit

enum AuthError: Error, LocalizedError {
    case invalidUrl
    
    var errorDescription: String? {
        "Не удалось сформировать URL для получения токена"
    }
}

struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}

final class OAuth2Service {
    static let shared = OAuth2Service()
    private init() {}
    
    private let authWebView = AuthViewController()
    private let url = Constants.defaultBaseURL
    
    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard let url else { return nil }
        var urlComponents = URLComponents(string: url.absoluteString)
        urlComponents?.path = "/oauth/token"
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]
        
        guard let url = urlComponents?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
    
    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let tokenRequest = makeOAuthTokenRequest(code: code) else {
            completion(.failure(AuthError.invalidUrl))
            return
        }
        URLSession.shared.data(for: tokenRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(OAuthTokenResponseBody.self, from: data)
                    completion(.success(response.accessToken))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }.resume()
    }
}
