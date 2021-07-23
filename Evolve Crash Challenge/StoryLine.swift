//
//  StoryLine.swift
//  Evolve Crash Challenge
//
//  Created by Thiago Medeiros on 22/07/21.
//

import Foundation

class StoryLine {
    let label: String
    let options: [(buttonLabel: String, storyLineLabel: String)]
    var timesVisited = 0
    let imageName: String?
    let backgroundImage: String?
    
    init(_ label: String, options: [(buttonLabel: String, storyLineLabel: String)], backgroundImage: String?, imageName: String?) {
        self.label = label
        self.options = options
        self.backgroundImage = backgroundImage
        self.imageName = imageName
    }
}
