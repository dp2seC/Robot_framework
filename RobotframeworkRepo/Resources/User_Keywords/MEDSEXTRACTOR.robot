*** Settings ***
Resource  ../UI/Pages/imedidata_Welcomepage.robot
Resource  ../UI/Pages/imedidata_Homepage.robot
Resource  ../UI/Pages/RaveEDC_AllStudiespage.robot
Resource  ../UI/Pages/RaveEDC_Sitespage.robot
Resource  ../UI/Pages/RaveEDC_Subjectpage.robot
Resource  ../UI/Pages/RaveEDC_SubjectDetailpage.robot
Resource  ../UI/Pages/RaveEDC_ScreeningVisitspage.robot
Resource  ../UI/Pages/RaveEDC_InformedConsentpage.robot
Resource  ../UI/Pages/RaveEDC_SubjectRandomisationpage.robot
Library     ScreenCapLibrary

*** Keywords ***
User log into Rave EDC
    imedidata_Welcomepage.Open
    imedidata_Welcomepage.Input Username
    imedidata_Welcomepage.Input Password
    imedidata_Welcomepage.Login
    imedidata_Homepage.Load
    imedidata_Homepage.Open Rave EDC

navigate to existing subject in Rave EDC
    RaveEDC_AllStudiespage.Load
    RaveEDC_AllStudiespage.Select a study
    RaveEDC_Sitespage.Load
    RaveEDC_Sitespage.Select a site
    RaveEDC_Subjectpage.Load
    RaveEDC_Subjectpage.Select a subject

navigate to screening Visit form with data for existing subject
    RaveEDC_SubjectDetailpage.Load
    RaveEDC_SubjectDetailpage.Select Screening Visit
    RaveEDC_ScreeningVisitspage.Load
    RaveEDC_ScreeningVisitspage.Enter Date
    RaveEDC_SubjectDetailpage.Click Save

navigate to Informed Consent form, add data in the form
    RaveEDC_SubjectDetailpage.Select Informed Consent
    RaveEDC_InformedConsentpage.load
    RaveEDC_InformedConsentpage.Enter Data
    RaveEDC_SubjectDetailpage.Click Save

navigate to Subject Randomisation form for existing subject, add data in the form
    RaveEDC_SubjectDetailpage.Select Subject Randomisation
    RaveEDC_SubjectRandomisationpage.Load
    RaveEDC_SubjectRandomisationpage.Enter Data