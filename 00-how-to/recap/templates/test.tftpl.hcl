%{ for  response_header_name, response_header_value in response_headers ~}
${response_header_name} : ${response_header_value}
%{ endfor ~}