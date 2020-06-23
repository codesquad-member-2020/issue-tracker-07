//
//  DetailIssueUseCase.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/22.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct DetailIssueUseCase {
    
    func mockRequestIssueInfoSuccess(successHandler: @escaping (IssueInfo) -> ()) {
        let jsonString = """
        {
          "status": true,
          "contents": [
            {
              "id": 1,
              "title": "이슈 상세 정보 화면 네트워킹",
              "description": "Yeah 다시 돌아왔지 내 이름 레인(RAIN) 스웩을 뽐내 WHOO! They call it! 왕의 귀환 후배들 바빠지는 중! 신발끈 꽉 매고 스케줄 All Day 내 매니저 전화기는 조용할 일이 없네 WHOO!",
              "authorName": "rain_oppa",
              "imageUrl": "https://image.chosun.com/sitedata/image/202005/22/2020052201547_0.png",
              "isOpen": true,
              "createdAt": "2020-06-22 18:28:34",
              "modifiedAt": "2020-06-22 18:28:34",
              "milestone": [
                {
                  "id": 1,
                  "title": "마일스톤 제목"
                }
              ],
              "label": [
                {
                  "id": 1,
                  "title": "feature",
                  "backgroundColor": "#FF5D5D"
                }
              ]
            }
          ],
          "emoji": [
            {
              "id": 1,
              "unicode": "U+1F607",
              "clickCount": 2
            },
            {
              "id": 2,
              "unicode": "U+1F923",
              "clickCount": 5
            }
          ],
          "comment": [
            {
              "id": 1,
              "writer": "mocha",
              "imageUrl": "https://codesquad-mocha.s3.ap-northeast-2.amazonaws.com/github.png",
              "content": "댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용",
              "createdAt": "2020-06-22 18:28:34",
              "modifiedAt": "2020-06-22 18:28:34",
              "emoji": [
                {
                  "id": 1,
                  "unicode": "U+1F607",
                  "clickCount": 2
                },
                {
                  "id": 2,
                  "unicode": "U+1F923",
                  "clickCount": 5
                }
              ]
            },
            {
              "id": 2,
              "writer": "ttozzi",
              "imageUrl": "https://codesquad-mocha.s3.ap-northeast-2.amazonaws.com/github.png",
              "content": "댓글 내용",
              "createdAt": "2020-06-22 18:28:34",
              "modifiedAt": "2020-06-22 18:28:34",
              "emoji": []
            }
          ],
          "assignee": [
            {
              "id": 1,
              "name": "olaf",
              "imageUrl": "https://codesquad-mocha.s3.ap-northeast-2.amazonaws.com/github.png"
            }
          ]
        }
        """
        
        let data = Data(jsonString.utf8)
        do {
            let data = try JSONDecoder().decode(IssueInfo.self, from: data)
            successHandler(data)
        } catch {
            
        }
    }
}
