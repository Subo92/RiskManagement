using { riskmanagement as rm } from '../db/schema';

// Define the service RiskService
@path: 'service/risk'
service RiskService @(requires: 'authenticated-user') {

  // Define the Risks entity with restrictions based on roles
  entity Risks @(restrict: [
    { grant: 'READ', to: 'RiskViewer' },
    { 
      grant: ['READ', 'WRITE', 'UPDATE', 'UPSERT', 'DELETE'], 
      // Allowing CDS events by explicitly mentioning them to 'RiskManager'
      to: 'RiskManager' 
    }
  ]) as projection on rm.Risks;

  // Annotate Risks entity for draft functionality
  annotate Risks with @odata.draft.enabled;

  // Define the Mitigations entity with restrictions based on roles
  entity Mitigations @(restrict: [
    { grant: 'READ', to: 'RiskViewer' },
    { grant: '*', // Allow everything using wildcard to 'RiskManager'
      to: 'RiskManager' 
    }
  ]) as projection on rm.Mitigations;

  // Annotate Mitigations entity for draft functionality
  annotate Mitigations with @odata.draft.enabled;

  // Define the BusinessPartners entity as read-only
  @readonly
  entity BusinessPartners as projection on rm.BusinessPartners;
}


