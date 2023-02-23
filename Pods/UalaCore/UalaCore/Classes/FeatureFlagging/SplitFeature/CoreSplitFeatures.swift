//
//  CoreSplitFeatures.swift
//  UalaCore
//
//  Created by Luis Perez on 08/09/21.
//
@available(*, deprecated, message: "Implement SplitFeatureType inside your pod")
public enum Feature: String, CaseIterable {

    case installments = "installments"
    case multipleTransactions = "multiple_transactions"
    case cardTravelNotice = "card_travel_notice"
    case ocdeForm = "OCDEForm"
    case cobroExpress = "cash_in_cash_cobro_express"
    case teleRecargas = "cash_in_cash_telerecargas"
    case automaticSuscription = "investments_automatic_subscription"
    case billPaymentsInstallmentsFeedback = "bill_payment_installments_feedback"
    case VUOnboarding = "onboarding_sdk_vu"
    case VUDNI = "onboarding_vu_id"
    case processDNIImage = "onboarding_retry_id"
    case onlineCreditFeature = "online_credit_feature_available"
    case isCashOutRapipagoEnabled = "cash-out-rapipago"
    case acquiringAvailabillity = "acquiring_iOS_available"
    case cashInToken = "cash-in-token"
    case cashInTokenRP = "cash-in-token-rapipago"
    case helpTreeExperiment = "help_tree_experiment"
    case faqsNewDesign = "faqs_new_design"
    case realTnaSimulation = "real_tna_simulation"
    case virtualCardMexEnabled = "virtual_card_mex_enabled"
    case userLastSessionDate = "user_last_session_date"
    case cashOutFee = "cash_out_rapipago_fee"
    case usernameAlternative = "username_alternative_mode"
    case cardNumberTransferMex = "card-number-transfer-mex"
    case sendEmailToRecoverAccount = "send_email_to_recover_account"
    case loyalty = "loyalty_program"
    case loyaltyMX = "loyalty_program_mx"
    case acquiringMposFeature = "acquiring_ios_mpos_feature"
    case incodeSelfieArg = "sign_up_incode_selfie_ar"
    case exceededCashInCharge = "exceeded_cash_in_charge"
    case insuranceWTW = "insurance_wtw"
    case insuranceWTWHealthAssistanceActive = "insurance_wtw_health_assistance_active"
    case acquiringQR = "acquiring_qr_feature"
    case referralProgramPPJJ = "referral_program_ppjj"
    case contactAgenda = "transfers_list_contact"
    // MX
    case complianceMXUpdateEmail = "compliance_mx_update_email"
    case complienceMXAccountStatementsMFA = "complience_mx_account_statements_mfa"
    case passwordRulesMx = "password-rules-compliance-mex"
    case changePasswordMx = "change-password-compliance-mex"
    case forgotPasswordMx = "sign-in-change-password-compliance-mex"
    case closeSessionInactivityUser = "close_session_inactivity_user"
    case complianceUserRecognition = "compliance_user_recognition"
    case complianceMXBeneficiary = "compliance_mx_beneficiary"
    case loansAvailableMx = "loans_mx_available"
    case paymentsFeatureABC = "mex_abc_payment_feature"
    case controlSignUpButtonABC = "control_sign_up_button_abc"
    case notificationCenter = "notification_center"
}

extension Feature: SplitFeatureType {
    public var id: String {
        return self.rawValue
    }
}
