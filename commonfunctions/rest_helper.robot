*** Settings ***
Library     RequestsLibrary
Resource  ..${/}config${/}config.robot

*** Keywords ***
Send Get Request to endpoint=${end_point}
    Log To Console  Send Get Request to ${end_point}
    Create Session  temp_session  ${base_url}   
    ${resp} =  GET On Session       temp_session        ${end_point}
    [return]  ${resp}

Send Post Request with data=${body} to endpoint=${end_point}
    Log To Console  Send Post Request to ${end_point}
    Create Session  temp_session  ${base_url}   
    #${body} =    evaluate    json.dumps(${body})
    ${resp} =  POST On Session       temp_session        ${end_point}    data=${body}
    [return]  ${resp}

Send PUT Request with data=${body} to endpoint=${end_point}
    Log To Console  Send PUT Request to ${end_point}
    Create Session  temp_session  ${base_url}   
    #${body} =    evaluate    json.dumps(${body})
    ${resp} =  PUT On Session       temp_session        ${end_point}    data=${body}
    [return]  ${resp}

Send PATCH Request with data=${body} to endpoint=${end_point}
    Log To Console  Send PATCH Request to ${end_point}
    Create Session  temp_session  ${base_url}   
    #${body} =    evaluate    json.dumps(${body})
    ${resp} =  PATCH On Session       temp_session        ${end_point}    data=${body}
    [return]  ${resp}
    
Send Delete Request to endpoint=${end_point}
    Log To Console  Send Delete Request to ${end_point}
    Create Session  temp_session  ${base_url}   
    ${resp} =  DELETE On Session       temp_session        ${end_point}
    [return]  ${resp}
