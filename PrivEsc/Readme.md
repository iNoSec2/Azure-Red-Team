# Privilege Escalation Hub for Azure

**SCRIPTS**

1. DetectServicePrincipalAbuse.ps1 - This script will detect service principals in an azure tenant and if they hold sensitive rights. [Original Post from SpecterOps.](https://posts.specterops.io/azure-privilege-escalation-via-service-principal-abuse-210ae2be2a5)

2. AutomationAccountSecretsDump.ps1 - This script can be used in a new automation runbook to dump access tokens if automation account is running a managed identity that is needed for privilege escalation.
