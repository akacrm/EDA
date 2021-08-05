public virtual with sharing class SObjectPermissionsMapper {
    @TestVisible
    private static SObjectPermissionsMapper instance;

    protected SObjectPermissionsMapper() {
    }

    public static SObjectPermissionsMapper getInstance() {
        if (instance == null) {
            instance = new SObjectPermissionsMapper();
        }

        return instance;
    }

    public virtual Map<String, SObjectPermissionsModel> getModelMapFromPermissionSetIdListAndSObjectNameList(
        List<Id> permissionSetIdList,
        List<String> sObjectTypeList
    ) {
        SecurityService.getInstance().assertViewSetupPermissionForCurrentUser();
        List<ObjectPermissions> objectPermissionsList = [
            SELECT SObjectType, PermissionsCreate, PermissionsDelete, PermissionsEdit, PermissionsRead
            FROM ObjectPermissions
            WHERE ParentId IN :permissionSetIdList AND SObjectType IN :sObjectTypeList
            ORDER BY SObjectType
        ];

        Map<String, SObjectPermissionsModel> modelMapFromPermissionSetIdListAndSObjectNameList = new Map<String, SObjectPermissionsModel>();

        for (ObjectPermissions objectPermissions : objectPermissionsList) {
            SObjectPermissionsModel sObjectPermissionsModel = new SObjectPermissionsModel(
                objectPermissions.SObjectType,
                objectPermissions.PermissionsCreate,
                objectPermissions.PermissionsRead,
                objectPermissions.PermissionsEdit,
                objectPermissions.PermissionsDelete
            );

            SObjectPermissionsModel retrievedModel = modelMapFromPermissionSetIdListAndSObjectNameList.get(
                objectPermissions.SObjectType
            );

            if (retrievedModel == null) {
                modelMapFromPermissionSetIdListAndSObjectNameList.put(
                    sObjectPermissionsModel.SObjectType,
                    SObjectPermissionsModel
                );
            } else {
                retrievedModel.combineModels(sObjectPermissionsModel);
            }
        }

        return modelMapFromPermissionSetIdListAndSObjectNameList;
    }
}
