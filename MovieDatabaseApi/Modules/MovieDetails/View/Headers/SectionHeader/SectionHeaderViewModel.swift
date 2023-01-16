//
//  SectionHeaderViewModel.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 31.03.2022.
//

import UIKit

struct SectionHeaderViewModel {
    let title: String
}

final class SectionHeaderDescriptior {

    private let viewModel: SectionHeaderViewModel

    init(
        viewModel: SectionHeaderViewModel
    ) {
        self.viewModel = viewModel
    }
}

extension SectionHeaderDescriptior: ITableHeaderDescriptor {
    var height: CGFloat {
        45
    }
    
    func register(for tableView: UITableView) {
        tableView.register(headerType: SectionHeader.self)
    }
    
    func dequeue(for tableView: UITableView, in section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeader(headerType: SectionHeader.self)
        headerView.configure(with: viewModel)
        headerView.apply()
        return headerView
    }
}
