//
//  StageResponse.swift
//  Webrick
//
//  Created by kyota on 2019/06/23.
//  Copyright © 2019 kyotaw. All rights reserved.
//

import Foundation

struct ParseStageResponse : Codable {
    let error: Bool
    var stage: JSStage
}

struct JSStage : Codable {
    let rect: Dictionary<String, Double>
    var blocks: [JSBlock]
}

struct JSBlock : Codable {
    let id: String
    var rect: Dictionary<String, Double>
    let content: String
}
