//
//  KeywordPackage.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 7. 14..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import Foundation

struct Message {
    let isMissionCount = "오늘의 미션을 완료하셨습니까?"
    let yes = "네"
    let no = "아니오"
    let more = "더보기"
    let haveNotCycle = "알 수 없음"
    let noComment = "No Comment"
}

struct ProgressNames {
    // 이후에 gobal 언어 처리 cheeseing
    let get = [
        ProgressKey.projectName:"프로젝트명"
        , ProgressKey.goalTotal:"총 목표"
        , ProgressKey.missionTotal:"총 미션"
        , ProgressKey.remaining: "남은 본전"
        , ProgressKey.unit:"단위"
        , ProgressKey.cycle:"주기"
        , ProgressKey.startDate:"시작 날짜"
        , ProgressKey.achievementRate:"달성율"
        , ProgressKey.missionSuccessTotal:"성과"
        , ProgressKey.expectedBonJeonDay:"예상 완료 일"
        
    ]
}

enum ProgressKey {
    case projectName
    case goalTotal
    case missionTotal
    case remaining
    case unit
    case cycle
    case startDate
    case achievementRate
    case missionSuccessTotal
    case expectedBonJeonDay
    case error
}

struct ChoiceList {
    let error = ["지정되지 않은 리스트 입니다."]
    let unit = ["₩", "km", "횟수", "사용자 지정"]
    let cycle = ["없음", "매일", "매주", "매달"]
    let cycleNumber = [0, 1, 7, 30]
}

struct FontManager {
    let name = "SeoulHangangB"
    let navigationBarSize = 20.0
    let cellTitleLabelSize = 15.0
}

