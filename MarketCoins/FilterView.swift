//
//  FilterView.swift
//  MarketCoins
//
//  Created by Rafael Badaró on 19/09/23.
//

import UIKit

protocol ToolbarFiltersViewDelegate: AnyObject {
    func filtersView(_ filterView: FilterView, didSelect filter: Filter, forCellRow row: Int)
    func cancelFilter(for filterView: FilterView)
}

class FilterView: UIView {
    
    private var selectedOption: Filter?
    
    public weak var delegate: ToolbarFiltersViewDelegate?
    
    public var cellRow: Int = -1
    public var filterOptions: [Filter] = []{
        didSet {
            selectedOption = filterOptions.first
        }
    }
    
    lazy var filterToolbar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(self.doneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(self.cancelTapped))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        return toolBar
    }()
    
    lazy var filterpickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .systemTeal
        pickerView.isUserInteractionEnabled = true
        
        return pickerView
    }()
    
    override init (frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        setupView()
    }
    
    @objc private func doneTapped()
    {
        if let selectedOption {
            delegate?.filtersView(self, didSelect: selectedOption, forCellRow: cellRow)
        }else {
            cancelTapped()
        }
    }
    
    @objc private func cancelTapped(){
        delegate?.cancelFilter(for: self)
    }
}

extension FilterView {
    private func setupView(){
        addSubviews(filterToolbar,filterpickerView)
        
        
        filterToolbar.translatesAutoresizingMaskIntoConstraints = false
        filterpickerView.translatesAutoresizingMaskIntoConstraints = false
        
        filterToolbar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        filterToolbar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        filterToolbar.bottomAnchor.constraint(equalTo: filterpickerView.topAnchor).isActive = true
        
        filterpickerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        filterpickerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        filterpickerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension FilterView: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = filterOptions[row]
    }
}

extension FilterView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let filter = filterOptions[row]
        
        switch filter.type {
        case .coins:
            if let coinsFilter = CoinsFilterEnum(rawValue: filter.key){
                return "\(coinsFilter.symbol) - \(coinsFilter.name)"
            }
        case .top:
            if let key =  Int(filter.key), let topFilter = TopFilterEnum(rawValue: key){
                return topFilter.title
            } 
        case .priceChangePercentage:
            if let priceChangePercentageFilter = PriceChangePercentageFilterEnum(rawValue: filter.key){
                return priceChangePercentageFilter.title
            }
        case .orderBy:
            if let orderByFilter = OrderByFilterEnum(rawValue: filter.key){
                return "\(orderByFilter.title) \(orderByFilter.order)"
            }
        }
        
        return ""
        
    }
}
