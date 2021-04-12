*** Variables ***

#Variables for Sandbox

#${LOGIN URL}      https://login-sandbox.imedidata.net/login?service=https%3A%2F%2Fsandbox.imedidata.net%2F
#${BROWSER}        ff
#${encrypted_username}    crypt:xjARfd6gOxQ535HikQQdQLEhA0gpZeic/FF9RPuS7BjR+v/FGPskEYM2CVfuwWeyn4oGVrv4PxMJdVi0t0Fr7XVGJ2PU
#${username}    ShivNarayan03
#${encrypted_pass}    crypt:aH/fbOh5J5Zt3/fFCxiGTEUQBnt6IReuS9acdI23QgVvIaU2MEUlMSovUTk/l3QZNswRgqgb8GP0jgpXO0A=
#${password}
#@{Studies} =  hgsbxrave111 Study  MEX Study 1
#@{DataType} =  CTMS Issue Management

#Variables for Validation

${LOGIN URL}   https://validation.imedidata.net/
${BROWSER}        ff
${username}    medsuser01_uispecflow
${password}

#EDCRaw data for validation
@{Studies} =  hgvalrave021-Study  hgvalrave021-Study2
@{DataType} =  CTMS Issue Management
@{Sites} =  Rave-SM-Site100
@{Subjects} =  SN Val - 2021.1.0

${SubjectScreening_Date} =  06
${SubjectScreening_Month} =  Oct
${SubjectScreening_Year} =  2021

${Subject_InformedConsent} =  Yes
${InformedConsent_Date} =  09
${InformedConsent_Month} =  Mar
${InformedConsent_Year} =  2021

${SubjectRandomised?} =  Yes
${SubjectRandomisation_Date} =  15
${SubjectRandomisation_Month} =  Feb
${SubjectRandomisation_Year} =  2021
${SubjectRandomisation_AssignedArm} =  Left
${SubjectRandomisation_AssignedArmDescription} =  LeftSideArm