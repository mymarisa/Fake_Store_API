*** Settings ***
Library     SeleniumLibrary
Resource  ..${/}config${/}config.robot
Resource  ..${/}commonfunctions${/}rest_helper.robot


*** Variables ***
${title}        test product
${price}        13.5
${description}  lorem ipsum set    
${image}        https://i.pravatar.cc
${category}     electronic

*** Keywords ***
Get All Products
    ${resp} =  Send Get Request to endpoint=${products}
    Response Status 200 and Reason OK   ${resp}

Get Products by ID=${products_id}
    ${resp} =  Send Get Request to endpoint=${products}/${products_id}
    Response Status 200 and Reason OK   ${resp}

Add New Products
    ${body} =  Generate Request Body   ${title}    ${price}    ${description}      ${image}    ${category}
    ${resp} =  Send Post Request with data=${body} to endpoint=${products}
    ${data} =  Evaluate    json.loads('${resp.content}')    json
    Log To Console    ${data}
    ${new_products_id}   set variable  ${data['id']}
    Response Status 200 and Reason OK   ${resp}
    #[Return]    ${new_products_id}

Update Product Some Values by ID=${products_id}
    ${body} =  Set Variable     { "title" : 'new title'}  
    ${resp} =  Send PATCH Request with data=${body} to endpoint=${products}/${products_id}
    Response Status 200 and Reason OK   ${resp}


Update Product All Values by ID=${products_id}
    Update Product Some Values by ID=${products_id}
    ${body} =  Generate Request Body   'new title'    ${price}    ${description}      ${image}    ${category}
    ${resp} =  Send PUT Request with data=${body} to endpoint=${products}/${products_id}
    Response Status 200 and Reason OK   ${resp}


Delete Product by ID=${products_id}
    ${resp} =  Send Delete Request to endpoint=${products}/${products_id}
    Response Status 200 and Reason OK   ${resp}


Generate Request Body
    [Arguments]     ${title}    ${price}    ${description}      ${image}    ${category}
    ${body} =  Catenate  {
    ...     "title"             : ${title},
    ...     "price"		        : ${price},
    ...     "description"		: ${description},
    ...     "image"             : ${image},
    ...     "category"          : ${category}
    ...     }
    [Return]  ${body}   


Response Status 200 and Reason OK
    [Arguments]    ${resp}
    Log     ${resp}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.reason}    OK



*** Test Cases ***
Test All method Products
    Get All Products
    Get Products by ID=1
    Add New Products
    Update Product Some Values by ID=7
    Update Product All Values by ID=7
    Delete Product by ID=6