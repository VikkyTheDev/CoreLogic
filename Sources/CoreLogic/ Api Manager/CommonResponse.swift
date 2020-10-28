//
//  CommonResponse.swift
//  CoreLogicRealState
//
//  Created by Admin on 26/06/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

public struct CLAuthenticationModel: Decodable {
    public init(accessToken: String, tokenType: String, expiresIn: Int, scope: String, iss: String, envAccessRestrict: Bool, geoCodes: [String], roles: [String], sourceExclusion: [String]) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiresIn = expiresIn
        self.scope = scope
        self.iss = iss
        self.envAccessRestrict = envAccessRestrict
        self.geoCodes = geoCodes
        self.roles = roles
        self.sourceExclusion = sourceExclusion
    }
    
    public let accessToken: String
    public let tokenType: String
    public let expiresIn: Int
    public let scope: String
    public let iss: String
    public let envAccessRestrict: Bool
    public let geoCodes: [String]
    public let roles, sourceExclusion: [String]
}
public struct CLMatchAddressModel: Decodable {
    public init(matchDetails: CLMatchDetails) {
        self.matchDetails = matchDetails
    }
    
    public let matchDetails: CLMatchDetails?
}
public struct CLMatchDetails: Decodable {
      public let updateDetail: String
      public let propertyId: Int?
      public let matchType, matchRule, updateIndicator: String
}

struct CLProperty: Decodable {
    let contacts: [CLContact]
}

struct CLContact: Decodable {
    let company: CLCompany
    let contactType: String
    let doNotCall, doNotMail: Bool
    let person: CLPerson
    let phoneNumber: String
    let postalAddress: CLPostalAddress
}

struct CLCompany: Decodable {
    let abn, acn, companyName: String
}

struct CLPerson: Decodable {
    let firstName, lastName: String
}

struct CLPostalAddress: Decodable {
    let addressCareOfText, addressLine1, addressLine2, country: String
    let postcode, state, suburb: String
}

struct CLErrorResponse: Decodable {
    let errors: [CLErrorMessage]
}
struct CLErrorMessage: Decodable {
    let msg: String
}
struct CLAuthErrorResponse: Decodable {
    let messages: [CLAuthErrorMessage]
}
struct CLAuthErrorMessage: Decodable {
    let type: String
    let message: String
}
public struct CLCoreProperyDetail: Decodable {
    public let propertyType, propertySubType: String?
    public let beds, baths, carSpaces, lockUpGarages: Int?
    public let landArea: Int?
    public let isCalculatedLandArea: Bool?
    public let landAreaSource: String?
}
 public struct CLAdditionalProperyDetail: Decodable {
    public let airConditioned: Bool?
    public let airConditioningFeatures, decadeBuilt, deck: String?
    public let ductedHeating: Bool?
    public let ensuite: Int?
    public let fireplace: Bool?
    public let floorArea: Int?
    public let pool: Bool?
    public let roofMaterial: String?
    public let salesGroupID: Int?
    public let salesGroupName: String?
    public let siteCover: Int?
    public let solarPower: Bool?
    public let tennisCourt, unitsOfUse: Int?
    public let wallMaterial, yearBuilt: String?
 }

public struct CLPropertyLocation: Codable {
    public let singleLine, councilArea: String?
    public let councilAreaId: Int?
    public let state: String?
    public let street: CLStreet?
    public let postcode, locality: CLLocality?
    public let longitude, latitude: Double?
}


public struct CLLocality: Codable {
    public let id: Int?
    public let singleLine, name: String?
}

public struct CLStreet: Codable {
    public let id: Int?
    public let singleLine, name, nameAndNumber: String?
    
    
}
public struct CLSchoolPlace: Codable {
    public let latitude, longitude: Double?
    public let placeId: Int?
    public let placeName, placeType: String?
    
}
public struct CLSchoolDetail: Codable {
    public let hasShape: Bool
    public let latitude: Double
    public let localityId: Int
    public let localityName: String
    public let longitude: Double
    public let placeId: Int
    public let placeMetaData: CLPlaceMetaData
    public let placeName, placeSingleLineAddress, placeType: String
    public let postcodeId: Int
    public let postcodeName: String
}

// MARK: - PlaceMetaData
public struct CLPlaceMetaData: Codable {
    public let school: [CLSchool]
}

// MARK: - School
public struct CLSchool: Codable {
    public let schoolName, schoolType: String?
    public let schoolGender, schoolSector: String?
   // public let acaraSchoolId: Int?
  //  public let schoolWebsite: String?
    public let schoolYearLow, schoolYearHigh: String?
    public let schoolEnrolments: Int?
    private enum CodingKeys: String, CodingKey {
        case schoolYearLow , schoolYearHigh ,schoolName,schoolType,schoolEnrolments,schoolGender,schoolSector
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        schoolName = try container.decode(String.self, forKey: .schoolName)
        schoolType = try container.decode(String.self, forKey: .schoolType)
        schoolEnrolments = try container.decode(Int.self, forKey: .schoolEnrolments)
        schoolGender = try container.decode(String.self, forKey: .schoolGender)
        schoolSector = try container.decode(String.self, forKey: .schoolSector)

        do {
          //  try container.decodeIfPresent(<#T##type: Bool.Type##Bool.Type#>, forKey: <#T##KeyedDecodingContainer<CodingKeys>.Key#>)
            
          let schoolYearLow = try container.decodeIfPresent(Int.self, forKey: .schoolYearLow)
            self.schoolYearLow = String(schoolYearLow ?? 0)
        } catch DecodingError.typeMismatch {
            schoolYearLow = try container.decodeIfPresent(String.self, forKey: .schoolYearLow)
        }
        do {
           let schoolYearHigh = try container.decodeIfPresent(Int.self, forKey: .schoolYearHigh)
            self.schoolYearHigh = String(schoolYearHigh ?? 0)

        } catch DecodingError.typeMismatch {
            schoolYearHigh = try container.decodeIfPresent(String.self, forKey: .schoolYearHigh)
        }
    }
}
public struct PropertyInsightDetail: Codable {
    public let lastSale: LastSale?
    public let isActiveProperty: Bool?
}

public struct LastSale: Codable {
    public let settlementDate: String?
    public let price: Int?
}
public struct PropertyInsightModel: Codable {
    public let forSalePropertyCampaign: ForSalePropertyCampaign?
}
public struct ForSalePropertyCampaign: Codable {
    public let isActiveProperty: Bool?
    public let campaigns: [ForSalePropertyCampaignCampaign]
}
public struct ForSalePropertyCampaignCampaign: Codable {
    public let firstPublishedPrice: String?
}
public struct Census: Codable {
   public var censusResponseList: [CensusResponseList]?
}

public struct CensusResponseList: Codable {
    public let isSumStatistic: Bool?
    public let localityName, locationType, metricDisplayType, metricType: String?
    public let metricTypeDescription: String?
    public let metricTypeGroupID, metricTypeID: Int?
    public let metricTypeShort, postcodeName: String?
    public let seriesDataList: [SeriesDataList]?
}
public struct SeriesDataList: Codable {
    public let dateTime: String?
    public  let value: Double
}
public struct AddressSuggestion: Codable {
    public let systemInfo: SystemInfo?
    public var suggestions: [Suggestion]?
}

public struct Suggestion: Codable {
    public let postcodeID, stateID, streetID, countryID: Int?
    public let suggestion: String?
    public let localityId, propertyId: Int?
    public let suggestionType:String?
    public let isActiveProperty: Bool?
    public let councilAreaID: Int?
    public let isBodyCorporate, isUnit: Bool?
}

public struct SystemInfo: Codable {
    public let instanceName, requestDate: String?
}

