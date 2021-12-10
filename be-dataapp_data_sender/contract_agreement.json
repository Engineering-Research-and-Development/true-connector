{    
   "@context": {
      "ids":"https://w3id.org/idsa/core/",
      "idsc" : "https://w3id.org/idsa/code/"
   },    
  "@type": "ids:ContractAgreement",    
  "@id": "https://w3id.org/idsa/autogen/contract/restrict-access-interval",    
  "profile": "http://example.com/ids-profile",    
  "ids:provider": "ecc-provider",    
  "ids:consumer": "ecc-consumer",    
  "ids:permission": [{    
      "ids:target": {
          "@id":"http://w3id.org/engrd/connector/artifact/1"
       },    
      "ids:action": [{
        "@id":"idsc:USE"
      }],     
      "ids:constraint": [{    
        "@type":"ids:Constraint",  
        "ids:leftOperand": { "@id": "idsc:POLICY_EVALUATION_TIME"},  
        "ids:operator": { "@id": "idsc:TEMPORAL_EQUALS"},  
        "ids:rightOperand": { 
         "@type": "ids:interval", 
         "@value": { 
             "ids:begin": {
               "@value": "2021-06-15T00:00:00Z",
               "@type": "xsd:datetimeStamp"
            }, 
            "ids:end": {
               "@value": "2021-12-31T00:00:00Z",
               "@type": "xsd:datetimeStamp"
            } 
         } 
        }, 
        "ids:pipEndpoint": { "@id": "https//example.com/pip/policy_evaluation_time" } 
      }     
] 
  }] 
} 