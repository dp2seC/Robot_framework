*** Variables ***
# DB connection strings-SANDBOX
${MEDS_DbConString}     'userid','password','127.0.0.1:51204/MEDSSB01_READER'
${RODS_DbConString}     'userid','password','127.0.0.1:15210/RODSSB02_WRITER'
${RODSMSTR_DbConString}   'userid','password','127.0.0.1:15209/etlsb01'
${RAVE_DbConString}      server='localhost:14343', user='userid', password='password', database='CDCStaging'
${MH_DbConString}       'userid','password','127.0.0.1:50001/medsinsights'
${MW_DbConString}       database='medsinsights',user='userid',password='password',host='localhost',port=51208
${IMEDI_DbConString}    database='imedidata_sandbox',user='userid',password='password',host='127.0.0.1',port=14344
${SBJ_DbConString}      database='Subjects_sandbox',user='userid',password='password',host='127.0.0.1',port=14345
${DALTON_DbConString}   database='Dalton_sandbox',user='userid',password='password',host='localhost',port=14353

# DB connection strings-VALIDATION
#${RODS_DbConString}         'userid','password','127.0.0.1:15111/RODSVL02_WRITER'
#${MEDS_DbConString}        'userid','password','127.0.0.1:15333/MEDSVL01_WRITER'
#${IMEDI_DbConString}       database='imedidata_validation',user='userid',password='password',host='127.0.0.1',port=14347
#${SBJ_DbConString}         database='Subjects_validation',user='userid',password='password',host='127.0.0.1',port=14341
#${DALTON_DbConString}      database='Dalton_validation',user='userid',password='password',host='localhost',port=14357

#DB connection strings-DISTRO
#${RODS_DbConString}         'userid','welcome01','127.0.0.1:15217/RODSDT02_WRITER'
#${MEDS_DbConString}        'userid','welcome01','127.0.0.1:15225/MEDSDT01_WRITER'
#${IMEDI_DbConString}       database='imedidata_production',user='userid',password='password',host='127.0.0.1',port=14346

