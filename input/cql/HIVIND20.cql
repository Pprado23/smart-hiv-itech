/*
HIV.IND.20
Individuals testing positive for HIV
% testing positive among people who received an HIV test in the reporting period

NUMERATOR
COUNT of clients with "HIV test result"='HIV-positive' AND "HIV test date" in the reporting period AND (("Date HIV test results returned" in the reporting period) OR ("HIV diagnosis date" in the reporting period))

DENOMINATOR
COUNT of clients with "HIV test date" in the reporting period AND "Date HIV test results returned" in the reporting period

• Gender (female, male, other**)
• Age (0–4, 5–9, 10–14, 15–19, 20–24, 25–29, 30–34, 35–39, 40–44, 45–49, 50+ years)***
• Key populations (men who have sex with men, people living in prisons and other closed settings, people who inject drugs, sex workers, trans and gender diverse people)***
• TB status (presumptive TB, diagnosed TB, none)
• Testing entry point:
- Facility-level testing: Provider-initiated testing and counselling in clinics or emergency facilities, ANC clinics (including labour and delivery), voluntary counselling and testing (within a health facility setting), family planning clinics (only in high HIV burden settings), TB clinics, other facility-level testing
- Community-level testing: Mobile testing (for example, through vans or temporary testing facilities), voluntary counselling and testing centres (not within a health facility setting), other community-based testing.
• Cities and other administrative regions of epidemiologic importance

*/

library HIVIND20

using FHIR version '4.0.1'
 

include HIVIndicatorCommon version '0.01' called HIC
include FHIRHelpers version '4.0.1'
include WHOCommon called WCom
include FHIRCommon called FC

parameter "Measurement Period" Interval<Date> default Interval[@2020-01-01, @2020-01-31]
 
context Unfiltered


// From BRYN
//you use a Measure resource, and your Measure would be based on either Patients or Observations.
//If you want to count number of Patients that have received the test, that's a Patient-based Measure using an "exists", 
//if you want to count the number of Tests, that could be a Patient-based continuous variable measure, where the Measure Observation is a Count of tests, or it could be an Observation-based proportion measure, where the basis is actually Observation.


//Does this also filter out self HIV tests 
//right now using HIVIND19 definition which does
define "numerator":
    exists(HIC."HIV Positive Condition" C
	where C.onset during "Measurement Period")
	or 
	exists(HIC."HIV Positive Observation" O
	where (O.issued before end of "Measurement Period"
	and O.issued after start of "Measurement Period")
	) 

define "denominator":
    exists(HIC."HIV test resulted" T
	where T.issued before end of "Measurement Period"
	and T.issued after start of "Measurement Period")


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
	HIC."patientGroups_3"