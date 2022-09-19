# PulseDevCourc
Devops Labs
L1
https://microsoftlearning.github.io/AZ-204-DevelopingSolutionsforMicrosoftAzure/Instructions/Labs/AZ-204_lab_01.html<br>
https://docs.microsoft.com/en-us/training/paths/create-azure-app-service-web-apps/</br>
https://learn.microsoft.com/ru-ru/training/modules/configure-web-app-settings/3-configure-general-settings<br/>
https://github.com/MicrosoftLearning/AZ-204-DevelopingSolutionsforMicrosoftAzure</br>

DEploy Az blob storage:
Terraform ../L1/main.tf


Commands:</br>
AppEx1:</br>
Az login
az webapp list --resource-group webapp-rg --query "[?starts_with(name, 'webappksiawebapp')]"
az webapp list --resource-group webapp-rg --query "[?starts_with(name, 'webappksiawebapp')].{Name:name}" --output tsv
az webapp deployment source config-zip --resource-group webapp-rg --src api.zip --name webappksiawebapp


AppEx2:</br>
Az login
az webapp list --resource-group webapp-rg --query "[?starts_with(name, 'imgwebksi')]"
az webapp list --resource-group webapp-rg --query "[?starts_with(name, 'imgwebksi')].{Name:name}" --output tsv
az webapp deployment source config-zip --resource-group webapp-rg --src web.zip --name imgwebksi




