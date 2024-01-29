// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

/**
 Base type to describe builder object
*/

public protocol Builder { }

public protocol ExpressibleWithoutParameters {
    init()
}

extension NSObject: Builder, ExpressibleWithoutParameters { }

public extension ExpressibleWithoutParameters {
    
    /**
     
     Helper to create configured object instance.
     
     ### Vehicle Example: ###
     ````
     let vehicle = Vehicle { vehicle in
        vehicle.id = 123
        vehicle.name = "VW"
     }
     ````
     
     */
    init(_ configure: (Self) -> Void) {
        
        self.init()
        
        configure(self)
    }
}

public extension Builder {
    
    /**
     
     Helper to configure object instance.
     
     ### Vehicle Example: ###
     ````
     vehicle.configure { vehicle in
        vehicle.id = 1
        vehicle.name = "VW"
     }
     ````
     
     */
    func configure(_ configure: (Self) -> Void) {
        configure(self)
    }
    
    /**
     
     Helper to create configured object instance.
     
     ### Vehicle Example: ###
     ````
     let configuredVehicle = vehicle.configured { vehicle in
        vehicle.id = 1
        vehicle.name = "VW"
     }
     ````
     
     */
    func configured(_ configure: (Self) -> Void) -> Self {
        
        configure(self)
        
        return self
    }
}
