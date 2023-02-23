//
//  AuthorizationTokenProviderManager.swift
//  UalaCore
//
//  Created by Luis Perez on 30/03/22.
//

public final class AuthorizationTokenProviderManager {
    
    /**
        Return token based on **UalaCore** environment  data

        Please check if you can use this method because uses `CoreEnvironment` instance
         - Precondition: `CoreEnvironment.shared` must be previously set
         - Returns:AuthorizationTokenProvider using credentials set by UalaCore
    */
    public static func authCore() -> AuthorizationTokenProvider {
        let environment = CoreEnvironment.shared.environment
        guard let country = CountryEnvironment(rawValue: environment.name),
              let amazonConfig = environment.amazon as? DefaultAmazonConfiguration else {
            return DefaultAuthorizationTokenProvider()
        }
        return Self.credentials(for: country, amazonConfig: amazonConfig)
    }
    
    public static func credentials(for country: CountryEnvironment,
                                   amazonConfig: AmazonConfiguration) -> AuthorizationTokenProvider {
        switch country {
        case .Argentina:
            return getCognitoProvider(amazonConfig: amazonConfig)
        case .Mexico, .MexicoABC, .Colombia, .ArgentinaBank:
            return getAuth0Provider()
        }
    }

    public static func getCognitoProvider(amazonConfig: AmazonConfiguration) -> AuthorizationTokenProvider {
        return CognitoTokenProvider(configuration: amazonConfig,
                                    timeoutIntervalForRequest: 120,
                                    timeoutIntervalForResource: 120) ?? DefaultAuthorizationTokenProvider()
    }

    public static func getAuth0Provider() -> AuthorizationTokenProvider {
        return Auth0TokenProvider(configuration: AuthConfig())
    }
}
