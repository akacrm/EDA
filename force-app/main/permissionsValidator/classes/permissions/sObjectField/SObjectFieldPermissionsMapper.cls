public virtual with sharing class SObjectFieldPermissionsMapper {
    @TestVisible
    private static SObjectFieldPermissionsMapper instance;

    protected SObjectFieldPermissionsMapper() {
    }

    public static SObjectFieldPermissionsMapper getInstance() {
        if (instance == null) {
            instance = new SObjectFieldPermissionsMapper();
        }

        return instance;
    }

    public virtual Map<String, SObjectFieldPermissionsModel> getModelMapFromDefinitionLists(
        List<Id> permissionSetIdList,
        List<String> nameList
    ) {
        SecurityService.getInstance().assertViewSetupPermissionForCurrentUser();
        List<FieldPermissions> fieldPermissionsList = [
            SELECT SObjectType, Field, PermissionsEdit, PermissionsRead
            FROM FieldPermissions
            WHERE ParentId IN :permissionSetIdList AND Field IN :nameList
            ORDER BY SObjectType, Field
        ];

        Map<String, SObjectFieldPermissionsModel> modelMapFromDefinitionLists = new Map<String, SObjectFieldPermissionsModel>();

        for (FieldPermissions fieldPermissions : fieldPermissionsList) {
            SObjectFieldPermissionsModel sObjectFieldPermissionsModel = new SObjectFieldPermissionsModel(
                fieldPermissions.SObjectType,
                fieldPermissions.Field,
                fieldPermissions.PermissionsRead,
                fieldPermissions.PermissionsEdit
            );

            SObjectFieldPermissionsModel retrievedModel = modelMapFromDefinitionLists.get(
                sObjectFieldPermissionsModel.name
            );

            if (retrievedModel == null) {
                modelMapFromDefinitionLists.put(sObjectFieldPermissionsModel.name, sObjectFieldPermissionsModel);
            } else {
                retrievedModel.combineModels(sObjectFieldPermissionsModel);
            }
        }

        return modelMapFromDefinitionLists;
    }
}
