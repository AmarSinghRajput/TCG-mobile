//
//  ProductListingModel.swift
//  TCG mobile
//
//  Created by Amar Kumar Singh on 26/04/23.
//

import Foundation

struct ProductListingResponse: Codable {
    let access_token: String?
    let expires_in: Int?
    let refresh_expires_in: Int?
    let refresh_token: String?
    let token_type: String?
    let notBeforePolicy: Int?
    let session_state: String?
    let scope: String?

    enum CodingKeys: String, CodingKey {
        case access_token = "access_token"
        case expires_in = "expires_in"
        case refresh_expires_in = "refresh_expires_in"
        case refresh_token = "refresh_token"
        case token_type = "token_type"
        case notBeforePolicy = "not-before-policy"
        case session_state = "session_state"
        case scope = "scope"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        access_token = try container.decodeIfPresent(String.self, forKey: .access_token)
        expires_in = try container.decodeIfPresent(Int.self, forKey: .expires_in)
        refresh_expires_in = try container.decodeIfPresent(Int.self, forKey: .refresh_expires_in)
        refresh_token = try container.decodeIfPresent(String.self, forKey: .refresh_token)
        token_type = try container.decodeIfPresent(String.self, forKey: .token_type)
        notBeforePolicy = try container.decodeIfPresent(Int.self, forKey: .notBeforePolicy)
        session_state = try container.decodeIfPresent(String.self, forKey: .session_state)
        scope = try container.decodeIfPresent(String.self, forKey: .scope)
    }
}

