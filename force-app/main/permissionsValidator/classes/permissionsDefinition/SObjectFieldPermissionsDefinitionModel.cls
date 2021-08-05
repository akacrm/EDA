public with sharing class SObjectFieldPermissionsDefinitionModel extends PermissionDefinitionModel {
    private static Map<String, String> accessListMap {
        get {
            if (accessListMap == null) {
                accessListMap = new Map<String, String>{
                    '' => '',
                    'r' => Label.missingAccessRead,
                    'ru' => Label.missingAccessReadEdit,
                    'u' => Label.missingAccessEdit
                };
            }
            return accessListMap;
        }
        set;
    }

    public SObjectFieldPermissionsDefinitionModel() {
        super();
    }

    public SObjectFieldPermissionsDefinitionModel(
        String featureName,
        String apiName,
        String apiSubname,
        Boolean readAccessRequired,
        Boolean updateAccessRequired
    ) {
        this.featureName = featureName;
        this.apiName = apiName;
        this.apiSubname = apiSubname;
        this.createAccessRequired = false;
        this.deleteAccessRequired = false;
        this.readAccessRequired = readAccessRequired;
        this.updateAccessRequired = updateAccessRequired;
    }

    public override String getRequiredAccess(
        Boolean createAccess,
        Boolean readAccess,
        Boolean updateAccess,
        Boolean deleteAccess
    ) {
        String crudAccess = '';

        if (this.readAccessRequired && !readAccess) {
            crudAccess += 'r';
        }

        if (this.updateAccessRequired && !updateAccess) {
            crudAccess += 'u';
        }

        return SObjectFieldPermissionsDefinitionModel.accessListMap.get(crudAccess);
    }

    public override String getMetadataType() {
        return 'SObjectField';
    }
}
