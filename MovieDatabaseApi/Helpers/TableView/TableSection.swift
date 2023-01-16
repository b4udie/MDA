//
//  TableSection.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 31.03.2022.
//

import Foundation

final class TableSectionDescriptor {

    var headerDescriptor: ITableHeaderDescriptor?
    var cellsDescriptors: [ITableCellDescriptor]

    init(headerDescriptor: ITableHeaderDescriptor? = nil, cellsDescriptors: [ITableCellDescriptor]) {
        self.headerDescriptor = headerDescriptor
        self.cellsDescriptors = cellsDescriptors
    }
}
