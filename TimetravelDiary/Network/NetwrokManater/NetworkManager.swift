//
//  NetworkManager.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/14/24.
//

import Foundation
import Combine


final class NetworkManager {
    
    static let shared = NetworkManager()
    
    // 공휴일 API
    func fetchPublicHolidays(for year: Int, countryCode: String) -> AnyPublisher<[PublicHolidayModel], Error> {
        let baseURL = "https://date.nager.at/Api/v2/PublicHolidays"
        let url = URL(string: "\(baseURL)/\(year)/\(countryCode)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [PublicHolidayModel].self, decoder: JSONDecoder())
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
    // 캘린더 뷰에서 호출할 공휴일 데이터 가져오기
    func fetchHolidays(for year: Int, countryCode: String, completion: @escaping (Result<Set<Date>, Error>) -> Void) {
        fetchPublicHolidays(for: year, countryCode: countryCode)
            .map { holidays in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dates = holidays.compactMap { holiday -> Date? in
                    dateFormatter.date(from: holiday.date)
                }
                return Set(dates)
            }
            .sink(receiveCompletion: { completionResult in
                switch completionResult {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            }, receiveValue: { holidaySet in
                completion(.success(holidaySet))
            })
            .store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
}
