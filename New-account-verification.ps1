get-aduser -Identity sdickey -Properties * | Select name,mail,physicalDeliveryOfficeName,office,manager,title,l,department | fl
