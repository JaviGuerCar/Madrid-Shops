//
//  Events.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 23/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

protocol EventsProtocol {
    func count() -> Int
    func add(event: Event)
    func get(index: Int) -> Event
}

class Events: EventsProtocol {
    private var eventsList: [Event]?
    
    public init() {
       self.eventsList = []
    }

    func count() -> Int {
        return (eventsList?.count)!
    }
    
    func add(event: Event) {
        eventsList?.append(event)
    }
    
    func get(index: Int) -> Event {
        return (eventsList?[index])!
    }
    
}
