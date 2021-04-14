import os
import glob
import csv
import time
from datetime import datetime, timedelta
currentTime = time.strftime("%Y%m%d-%H%M%S")
dayBeforeYesterday = datetime.now() - timedelta(2)
yesterday = datetime.now() - timedelta(1)
today = datetime.now()
studyName="Team93-RF-Automation-Study"
siteName="RF-Automation-Site-1"
# remove previous clinical files if exist
# Step1: Get all csv files that has pattern RF-Automation
existingClinicalFileList = glob.glob("./*-RF-Automation-*.csv")
for filePath in existingClinicalFileList:
    try:
        os.remove(filePath)
    except:
        print("Error while deleting existing clinical files: " + filePath)

# Generate LB File
LB_File_Name = "./LB-" + "RF-Automation-" + currentTime + ".csv"
with open(LB_File_Name, 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["STUDYID", "SITEID", "SUBJID","VISIT","VISITNUM", "LBDTC", "LBSEQ", "LBGRPID", "LBREFID", "LBTESTCD", "LBTEST", "LBCAT", "LBSCAT", "LBORRES", "LBORRESU", "LBORNRLO", "LBORNRHI", "LBSTRESC", "LBSTRESN", "LBSTRESU", "LBSTRNRLO", "LBSTRNRHI", "LBSTNRC", "LBNRIND", "LBSTAT", "LBREASND", "LBNAM", "LBLOINC", "LBSPEC", "LBSPCCND", "LBMETHOD", "LBBLFL", "LBFAST", "LBDRVFL", "LBTOX", "LBTOXGR"])
    writer.writerow([studyName, siteName, "new_study_mixd_001", "VISIT1", "1", datetime.strftime(dayBeforeYesterday, '%Y%m%d'), "1", "5", "AB1010", "ANGPB1", time.strftime("%Y%m%d-%H%M%S"), "DEF456", "BIOMARKER", "377", "pg/mL", "0", "29", "BB", "1.971", "g/day", "1.8", "1.099", "Negative", "HIGH", "NOT DONE", "NOT ORDERED", "Ampersand Biosciences", "33", "Plasma", "hemolyzed", "IMMUNOASSAY", "D", "E", "F", "IMMUNOASSAY", "IMMUNOASSAY"])
    writer.writerow([studyName, siteName, "new_study_mixd_002", "VISIT2", "1", datetime.strftime(yesterday, '%Y%m%d'), "1", "5", "AB1010", "ANGPB1", time.strftime("%Y%m%d-%H%M%S"), "DEF456", "BIOMARKER", "377", "pg/mL", "0", "29", "BB", "1.971", "g/day", "1.8", "1.099", "Negative", "HIGH", "NOT DONE", "NOT ORDERED", "Ampersand Biosciences", "33", "Plasma", "hemolyzed", "IMMUNOASSAY", "D", "E", "F", "IMMUNOASSAY", "IMMUNOASSAY"])
    writer.writerow([studyName, siteName, "new_study_mixd_003", "VISIT3", "1", datetime.strftime(today, '%Y%m%d'), "1", "5", "AB1010", "ANGPB1", time.strftime("%Y%m%d-%H%M%S"), "DEF456", "BIOMARKER", "377", "pg/mL", "0", "29", "BB", "1.971", "g/day", "1.8", "1.099", "Negative", "HIGH", "NOT DONE", "NOT ORDERED", "Ampersand Biosciences", "33", "Plasma", "hemolyzed", "IMMUNOASSAY", "D", "E", "F", "IMMUNOASSAY", "IMMUNOASSAY"])
    print("LB file: " + LB_File_Name + " generated successfully")

# Generate AE File
AE_File_Name = "./AE-" + "RF-Automation-" + currentTime + ".csv"
with open(AE_File_Name, 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["STUDYID", "SITEID", "SUBJID ", "AETERM", "AESER", "AESTDTC", "AEENDTC", "DATA_ENTRY_COMPLETE_DATE", "DATA_ENTRY_START_DATE", "SDV_COMPLETE_STATUS", "SDV_COMPLETE_DATE", "VISIT_DATE", "VISIT"])
    writer.writerow([studyName, siteName, "Sub1", time.strftime("%Y%m%d-%H%M%S"), "Y", "20200605", "20200902", "20200131", "20200125", "Y", "20200120", datetime.strftime(dayBeforeYesterday, '%Y%m%d'), "VISIT1"])
    writer.writerow([studyName, siteName, "Sub2", time.strftime("%Y%m%d-%H%M%S"), "Y", "20200605", "20200902", "20200131", "20200125", "Y", "20200120", datetime.strftime(yesterday, '%Y%m%d'), "VISIT2"])
    writer.writerow([studyName, siteName, "Sub3", time.strftime("%Y%m%d-%H%M%S"), "Y", "20200605", "20200902", "20200131", "20200125", "Y", "20200120", datetime.strftime(today, '%Y%m%d'), "VISIT3"])
    print("AE file: " + AE_File_Name + " generated successfully")

# Generate SV File
SV_File_Name = "./SV-" + "RF-Automation-" + currentTime + ".csv"
with open(SV_File_Name, 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["STUDYID", "SITEID", "SUBJID", "VISIT", "VISIT_DATE", "FRM_NAME", "FRM_RPT_KEY", "SDV_COMPLETE_STATUS"])
    writer.writerow([studyName, siteName, "Sub1", "VISIT1", time.strftime("%Y%m%d %H:%M:%S"), "AE", "1", "N"])
    writer.writerow([studyName, siteName, "Sub2", "VISIT2", time.strftime("%Y%m%d %H:%M:%S"), "LB", "2", "Y"])
    writer.writerow([studyName, siteName, "Sub3", "VISIT3", time.strftime("%Y%m%d %H:%M:%S"), "SV", "3", "NO"])
    print("SV file: " + SV_File_Name + " generated successfully")

# Generate DS File
DS_File_Name = "./DS-" + "RF-Automation-" + currentTime + ".csv"
with open(DS_File_Name, 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["STUDYID", "SITEID", "SUBJID", "VISIT", "VISIT_DATE", "SCREENING_DATE", "SCREEN_FAILED_DATE", "EARLY_TERMINATED_DATE", "COMPLETED_DATE", "RANDOMIZED_DATE", "SDV_COMPLETE_STATUS"])
    writer.writerow([studyName, siteName, "Sub1", "VISIT1", time.strftime("%Y%m%d %H:%M:%S"), "20201223", "20201201", "20201101", "20201215", "20201220", "Y"])
    writer.writerow([studyName, siteName, "Sub2", "VISIT2", time.strftime("%Y%m%d %H:%M:%S"), "20201223", "20201201", "20201101", "20201215", "20201220", "N"])
    writer.writerow([studyName, siteName, "Sub3", "VISIT3", time.strftime("%Y%m%d %H:%M:%S"), "20201223", "20201201", "20201101", "20201215", "20201220", "NO"])
    print("DS file: " + DS_File_Name + " generated successfully")

# Generate DV File
DV_File_Name = "./DV-" + "RF-Automation-" + currentTime + ".csv"
with open(DV_File_Name, 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["STUDYID", "SITEID", "SUBJID", "VISIT", "SVSTDTC", "DVSEQ", "DVREFID", "DVSPID", "DVTERM", "DVDECOD", "DVCAT", "DVSCAT", "DVSTDTC", "DVENDTC"])
    writer.writerow([studyName, siteName, "Sub1", "VISIT1", time.strftime("%Y%m%d %H:%M:%S"), "1", "A", "f", "k", "p", "u", "A", "20201001", "20201001"])
    writer.writerow([studyName, siteName, "Sub2", "VISIT1", time.strftime("%Y%m%d %H:%M:%S"), "1", "A", "f", "k", "p", "u", "A", "20201001", "20201001"])
    writer.writerow([studyName, siteName, "Sub3", "VISIT1", time.strftime("%Y%m%d %H:%M:%S"), "1", "A", "f", "k", "p", "u", "A", "20201001", "20201001"])
    print("DV file: " + DV_File_Name + " generated successfully")

# Generate QS File
QS_File_Name = "./QS-" + "RF-Automation-" + currentTime + ".csv"
with open(QS_File_Name, 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["STUDYID", "SITEID", "SUBJID", "VISIT", "SVSTDTC", "QSSEQ", "QSGRPID", "QSSPID", "QSTESTCD", "QSTEST", "QSCAT", "QSSCAT", "QSORRES", "QSORRESU", "QSSTRESC", "QSSTRESN", "QSSTRESU", "QSSTAT", "QSREASND", "QSEVAL", "QSTPT", "QSTPTNUM", "QSDTC"])
    writer.writerow([studyName, siteName, "Sub1", "VISIT1", time.strftime("%Y%m%d %H:%M:%S"), "1", "A", "AB1010", "ANGPB1", "Anginpoietim_AB", "Hematology", "BIOMARKER", "377", "pg/mL", "0", "1.1", "BB", "AA", "g/day", "BB", "AA", "1", "20201101"])
    writer.writerow([studyName, siteName, "Sub2", "VISIT2", time.strftime("%Y%m%d %H:%M:%S"), "1", "A", "AB1010", "ANGPB1", "Anginpoietim_AB", "Hematology", "BIOMARKER", "377", "pg/mL", "0", "1.1", "BB", "AA", "g/day", "BB", "AA", "1", "20201101"])
    writer.writerow([studyName, siteName, "Sub3", "VISIT3", time.strftime("%Y%m%d %H:%M:%S"), "1", "A", "AB1010", "ANGPB1", "Anginpoietim_AB", "Hematology", "BIOMARKER", "377", "pg/mL", "0", "1.1", "BB", "AA", "g/day", "BB", "AA", "1", "20201101"])
    print("QS file: " + QS_File_Name + " generated successfully")

# Generate SDV File
SDV_File_Name = "./SDV-" + "RF-Automation-" + currentTime + ".csv"
with open(SDV_File_Name, 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["STUDYID", "SITEID", "SUBJID ", "VISIT", "SVSTDTC", "FRM_NAME", "FRM_RPT_KEY", "SDV_COMPLETE_STATUS", "SDV_COMPLETE_DATE"])
    writer.writerow([studyName, siteName, "Sub1", "VISIT1", time.strftime("%Y%m%d %H:%M:%S"), "AE", "1", "Y", "20210228"])
    writer.writerow([studyName, siteName, "Sub2", "VISIT2", time.strftime("%Y%m%d %H:%M:%S"), "SV", "1", "N", "20210228"])
    writer.writerow([studyName, siteName, "Sub3", "VISIT3", time.strftime("%Y%m%d %H:%M:%S"), "LB", "1", "NO", "20210228"])
    print("SDV file: " + SDV_File_Name + " generated successfully")

# Generate EG File
EG_File_Name = "./EG-" + "RF-Automation-" + currentTime + ".csv"
with open(EG_File_Name, 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["STUDYID", "SITEID", "SUBJID", "VISIT", "VISITDATE", "EGSEQ", "EGGRPID", "EGREFID", "EGSPID", "EGTESTCD", "EGTEST", "EGCAT", "EGSCAT", "EGPOS", "EGBEATNO", "EGORRES", "EGORRESU", "EGSTRESC", "EGSTRESN", "EGSTRESU", "EGSTAT", "EGREASND", "EGNAM", "EGMETHOD", "EGLEAD", "EGEVAL", "EGEVALID", "EGREPNUM", "EGTPT", "EGTPTNUM", "EGTIM"])
    writer.writerow([studyName, siteName, "Sub1", "VISIT1", time.strftime("%Y%m%d %H:%M:%S"), "1", "u", "AB1009", "ANGPB1", "Anginpoietim_AB", "Hematology", "BIOMARKER", "s", "pg/mL", "1", "e", "BB", "f", "1.1", "a", "t", "Negative", "HIGH", "NOT DONE", "NOT ORDERED", "Ampersand Biosciences", "33", "2", "hemolyzed", "3", "E"])
    writer.writerow([studyName, siteName, "Sub2", "VISIT2", time.strftime("%Y%m%d %H:%M:%S"), "1", "u", "AB1009", "ANGPB1", "Anginpoietim_AB", "Hematology", "BIOMARKER", "s", "pg/mL", "1", "e", "BB", "f", "1.1", "a", "t", "Negative", "HIGH", "NOT DONE", "NOT ORDERED", "Ampersand Biosciences", "33", "2", "hemolyzed", "3", "E"])
    writer.writerow([studyName, siteName, "Sub3", "VISIT3", time.strftime("%Y%m%d %H:%M:%S"), "1", "u", "AB1009", "ANGPB1", "Anginpoietim_AB", "Hematology", "BIOMARKER", "s", "pg/mL", "1", "e", "BB", "f", "1.1", "a", "t", "Negative", "HIGH", "NOT DONE", "NOT ORDERED", "Ampersand Biosciences", "33", "2", "hemolyzed", "3", "E"])
    print("EG file: " + EG_File_Name + " generated successfully")

# Generate QUERIES File
QUERIES_File_Name = "./QUERIES-" + "RF-Automation-" + currentTime + ".csv"
with open(QUERIES_File_Name, 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["QUERYID", "STUDYID", "SITEID", "SUBJID", "VISIT", "SVSTDTC", "FRM_NAME", "FRM_RPT_KEY", "FIELD_NAME", "QUERY", "QUERY_OPEN_METHOD", "QUERY_TYPE", "QUERY_CREATED_DATETIME", "QUERY_ACTION", "QUERY_ACTION_TEXT", "QUERY_ACTION_DATETIME"])
    writer.writerow(["100", studyName, siteName, "Sub1", "VISIT1", time.strftime("%Y%m%d %H:%M:%S"), "AE", "1", "BRTHDAT", "Data entered is non-conformant.  Please correct.", "Manual", "Stickies", datetime.strftime(dayBeforeYesterday, '%Y%m%d'), "Open", "Data Corrected", datetime.strftime(dayBeforeYesterday, '%Y%m%d')])
    writer.writerow(["100", studyName, siteName, "Sub2", "VISIT1", time.strftime("%Y%m%d %H:%M:%S"), "SV", "1", "BRTHDAT", "Data entered is non-conformant.  Please correct.", "Manual", "Stickies", datetime.strftime(dayBeforeYesterday, '%Y%m%d'), "Open", "Data Corrected", datetime.strftime(yesterday, '%Y%m%d')])
    writer.writerow(["100", studyName, siteName, "Sub3", "VISIT1", time.strftime("%Y%m%d %H:%M:%S"), "LB", "1", "BRTHDAT", "Data entered is non-conformant.  Please correct.", "Manual", "Stickies", datetime.strftime(dayBeforeYesterday, '%Y%m%d'), "Open", "Data Corrected", datetime.strftime(today, '%Y%m%d')])
    print("QUERIES file: " + QUERIES_File_Name + " generated successfully")