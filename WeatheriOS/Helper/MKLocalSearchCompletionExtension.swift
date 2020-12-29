//
//  MKLocalSearchCompletionExtension.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/29.
//

import MapKit

extension MKLocalSearchCompletion {
    var combineTitleWithSpace: String { return self.title + " " + self.subtitle }
}
