*** Settings ***
library  SeleniumLibrary    


*** Test Cases ***


Ouvrir La Page Robot
    [tags]  Ouvrir La Page Robot
    open browser  ${URL}  chrome
    VerifyKW
    close browser
    

*** Variables ***
${URL}    https://robotcode.io/
${content}    Ultimateer


*** Keywords ***
VerifyKW
    Set Browser Implicit Wait  5
    Page Should Contain    ${content}