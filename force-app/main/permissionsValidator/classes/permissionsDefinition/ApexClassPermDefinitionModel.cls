public with sharing class ApexClassPermDefinitionModel extends PermissionDefinitionModel {
    public String namespacePrefix;
    public ApexClassPermDefinitionModel() {
        super();
    }

    public ApexClassPermDefinitionModel(String featureName, String apiName, String namespacePrefix) {
        this.featureName = featureName;
        this.apiName = apiName;
        this.namespacePrefix = namespacePrefix;
        this.createAccessRequired = false;
        this.deleteAccessRequired = false;
        this.readAccessRequired = true;
        this.updateAccessRequired = false;
    }

    public override String getRequiredAccess(
        Boolean createAccess,
        Boolean readAccess,
        Boolean updateAccess,
        Boolean deleteAccess
    ) {
        if (this.readAccessRequired == readAccess) {
            return '';
        }

        return Label.apexClassAccessRequired;
    }

    public override String getMetadataType() {
        return 'Apex Class';
    }

    public override String getQualifiedName() {
        if (String.isBlank(this.namespacePrefix)) {
            return this.apiName;
        }

        return this.namespacePrefix + '.' + this.apiName;
    }
}
