/*
 * Library: HIV.IND.30
 * New ART patients
 * Number of people living with HIV who initiated ART
 * 
 * Numerator: COUNT of clients with "HIV status"='HIV-positive' AND "On ART"=True AND "ART start date" is within reporting period
 * Numerator Exclusions: NONE
 * 
 * Denominator: NONE
 *
 * 
 * 
 * Disaggregation:
 *   - Gender
 *   - Age
 *   - Key population member type
 *   - Other PRIORITY POPULATION??? NOT DEFINED
 * Description:
 *   - Gender (female, male, other*)
 *   - Age (0–4, 5–9, 10–14, 15–19, 20–24, 25–29, 30–34, 35–39, 40–44, 45–49, 50+ years)**
 *   - Key populations (men who have sex with men, people living in prisons and other closed settings, people who inject drugs, sex workers, trans and gender diverse people)***
 *   - Cities and other administrative regions of epidemiologic importance
 * 
 *      * The category of other includes trans and gender diverse people who choose an identity other than male or female.
 *      ** Recommended in settings with robust electronic health information systems.
 *      *** Where feasible and data security and confidentiality can be ensured (see monitoring considerations in section 3.8 of WHO's 2022 HIV SI Guidelines on key
 *          populations for further guidance and section 6.4 on maintaining data privacy, security and confidential).
 * 
 * 
 * Consolidated guidelines on person-centred HIV strategic information: strengthening routine data for impact. Geneva: World Health Organization; 2022
 */

library HIVIND30

using FHIR version '4.0.1'
 

include HIVIndicatorCommon version '0.01' called HIC
include FHIRHelpers version '4.0.1'
include WHOCommon called WCom
include FHIRCommon called FC

parameter "Measurement Period" Interval<Date> default Interval[@2020-01-01, @2020-01-31]
 
context Unfiltered

 define "numerator":
   (exists(HIC."HIV Positive Condition" C
	where C.onset before end of "Measurement Period")
	or 
	exists(HIC."HIV Positive Observation" O
	where (O.issued before end of "Measurement Period")
	)) and 
	exists(HIC."HIV Treatment Active" H
   where H.effective starts during "Measurement Period")



/*
 * Disaggregators
 */

define "Administrative Gender Stratifier":
	HIC."By Administrative Gender Stratifier"

define "Age Stratifier":
	HIC."By Age Stratifier"

define "Geographic Region Stratifier":
	HIC."By Geographic Region Stratifier"

define "patientGroups Stratifier":
	HIC."patientGroups"
