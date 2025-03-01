param policyName string = 'Deny-Public-IP'
param policyDisplayName string = 'Deny Public IP'
param scope string = '/subscriptions/9c52dd72-7727-47a6-9854-4004f128313c'

resource policyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    policyType: 'Custom'
    displayName: policyDisplayName
    mode: 'All'
    policyRule: {
      if: {
        field: 'Microsoft.Network/publicIPAddresses'
        exists: 'true'
      }
      then: {
        effect: 'deny'
      }
    }
  }
}

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: '${policyName}-Assignment'
  scope: scope
  properties: {
    displayName: '${policyDisplayName} Assignment'
    policyDefinitionId: policyDefinition.id
  }
}
