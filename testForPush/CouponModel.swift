//
//  CouponModel.swift
//  testForPush
//
//  Created by user on 2021/5/26.
//

import Foundation

struct CouponModel {
    enum Period {
        case Before
        case Limited
        case OutofStock
        case NotDetermine
    }
    enum CouponStatus {
        case ComingSoon(_ describe: String)
        case OutofStock(_ describe: String)
        case Limited(_ describe: String)
        case LimitedBenefit(_ describe: String)
    }
    
    let content: String?
    let displayCount: Int?
    let displayLimit: Int?
    let endDate: Date?
    let link: String?
    let modalCode: String?
    //let modalType: String?
    let remainingCount: String?
    let sequence: String?
    let startDate: Date?
    let title: String?
    //let totalCount: String?
    let updateDatetime: String?
    let serialCoupon: String?
    
    let remark: String?
    
    //coupon status
    var timePeriod: Period? = nil
    var status: CouponStatus? = nil
    
    private enum CodingKeys: CodingKey {
        case content, displayCount, displayLimit, endDate, link, modalCode, remainingCount, sequence, title, startDate, updateDatetime, serialCoupon, remark
        }
    }

extension CouponModel {
    private func caculateTimePeriod(startDate start: Date, endDate end: Date, sequence: String) -> Period {
        let currentTime = Date()
        let stock = Int(self.remainingCount ?? "0") ?? 0
        if currentTime <= start {
            return .Before
        } else if sequence != "6" || sequence != "7" || sequence != "8" {
            return .NotDetermine
        } else if stock != 0 || sequence == "7" {
            return .Limited
        } else {
            return .OutofStock
        }
    }
    
    private func caculateStatus(timePeriod period: Period, sequence: String) -> CouponStatus? {
        switch period {
        case .Before:
            return CouponStatus.ComingSoon(Description.Coupon.Content.comingSoon)
        case .OutofStock:
            return CouponStatus.OutofStock(Description.Coupon.Content.outofStock)
        case .Limited:
            return sequence == "8" ? CouponStatus.LimitedBenefit(Description.Coupon.Content.limitedBenefit) : CouponStatus.Limited(Description.Coupon.Content.limited)
        case .NotDetermine:
            return nil
        }
    }
}

extension CouponModel: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        content = try? container.decode(String.self, forKey: .content)
        displayCount = try? container.decode(Int.self, forKey: .displayCount)
        displayLimit = try? container.decode(Int.self, forKey: .displayLimit)
        endDate = try? container.decode(Date.self, forKey: .endDate)
        link = try? container.decode(String.self, forKey: .link)
        modalCode = try? container.decode(String.self, forKey: .modalCode)
        remainingCount = try? container.decode(String.self, forKey: .remainingCount)
        sequence = try? container.decode(String.self, forKey: .sequence)
        startDate = try? container.decode(Date.self, forKey: .startDate)
        title = try? container.decode(String.self, forKey: .title)
        updateDatetime = try? container.decode(String.self, forKey: .updateDatetime)
        serialCoupon = try? container.decode(String.self, forKey: .serialCoupon)
        remark = try? container.decode(String.self, forKey: .remark)
        if let start = self.startDate, let end = self.endDate, let sequence = self.sequence {
            self.timePeriod = self.caculateTimePeriod(startDate: start, endDate: end, sequence: sequence)
        }
        
        if let period = self.timePeriod, let sequence = self.sequence {
            self.status = self.caculateStatus(timePeriod: period, sequence: sequence)
        }
    }
}

extension CouponModel: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(content, forKey: .content)
        try? container.encode(displayCount, forKey: .displayCount)
        try? container.encode(displayLimit, forKey: .displayLimit)
        try? container.encode(endDate, forKey: .endDate)
        try? container.encode(link, forKey: .link)
        try? container.encode(modalCode, forKey: .modalCode)
        try? container.encode(remainingCount, forKey: .remainingCount)
        try? container.encode(sequence, forKey: .sequence)
        try? container.encode(startDate, forKey: .startDate)
        try? container.encode(title, forKey: .title)
        try? container.encode(updateDatetime, forKey: .updateDatetime)
        try? container.encode(serialCoupon, forKey: .serialCoupon)
        try? container.encode(remark, forKey: .remark)
    }
}
