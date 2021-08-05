public with sharing class PermissionSetGroupVModel {
    public PermissionSetGroupVModel(Id value, String label) {
        this.value = value;
        this.label = label;
    }

    @AuraEnabled
    public Id value { get; private set; }

    @AuraEnabled
    public String label { get; private set; }
}
