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
              "title": "이슈 제목",
              "description": "이슈 내용",
              "authorName": "sedin",
              "imageUrl": "https://codesquad-mocha.s3.ap-northeast-2.amazonaws.com/github.png",
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
              "content": "댓글 내용",
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
