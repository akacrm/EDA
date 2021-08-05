public with sharing class SObjectPermissionsDefinitionModel extends PermissionDefinitionModel {
    private static Map<String, String> accessListMap {
        get {
            if (accessListMap == null) {
                accessListMap = new Map<String, String>{
                    '' => '',
                    'c' => Label.missingAccessCreate,
                    'cr' => Label.missingAccessReadCreate,
                    'cru' => Label.missingAccessReadCreateEdit,
                    'crd' => Label.missingAccessReadCreateDelete,
                    'crud' => Label.missingAccessReadCreateEditDelete,
                    'cu' => Label.missingAccessCreateEdit,
                    'cud' => Label.missingAccessCreateEditDelete,
                    'cd' => Label.missingAccessCreateDelete,
                    'd' => Label.missingAccessDelete,
                    'r' => Label.missingAccessRead,
                    'ru' => Label.missingAccessReadEdit,
                    'rud' => Label.missingAccessReadEditDelete,
                    'rd' => Label.missingAccessReadDelete,
                    'u' => Label.missingAccessEdit,
                    'ud' => Label.missingAccessEditDelete
                };
            }
            return accessListMap;
        }
        set;
    }

    public SObjectPermissionsDefinitionModel() {
        super();
    }

    public SObjectPermissionsDefinitionModel(
        String featureName,
        String apiName,
        Boolean createAccessRequired,
        Boolean readAccessRequired,
        Boolean updateAccessRequired,
        Boolean deleteAccessRequired
    ) {
        this.featureName = featureName;
        this.apiName = apiName;
        this.createAccessRequired = createAccessRequired;
        this.readAccessRequired = readAccessRequired;
        this.updateAccessRequired = updateAccessRequired;
        this.deleteAccessRequired = deleteAccessRequired;
    }

    public override String getRequiredAccess(
        Boolean createAccess,
        Boolean readAccess,
        Boolean updateAccess,
        Boolean deleteAccess
    ) {
        String crudAccess = '';

        if (this.createAccessRequired && !createAccess) {
            crudAccess += 'c';
        }

        if (this.readAccessRequired && !readAccess) {
            crudAccess += 'r';
        }

        if (this.updateAccessRequired && !updateAccess) {
            crudAccess += 'u';
        }

        if (this.deleteAccessRequired && !deleteAccess) {
            crudAccess += 'd';
        }

        return SObjectPermissionsDefinitionModel.accessListMap.get(crudAccess);
    }

    public override String getMetadataType() {
        return 'SObject';
    }
}
