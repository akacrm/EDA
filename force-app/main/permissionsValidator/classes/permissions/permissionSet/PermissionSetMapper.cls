public virtual with sharing class PermissionSetMapper {
    @TestVisible
    private static PermissionSetMapper instance;

    protected PermissionSetMapper() {
    }

    public static PermissionSetMapper getInstance() {
        if (instance == null) {
            instance = new PermissionSetMapper();
        }

        return instance;
    }

    public virtual List<PermissionSetModel> getPermissionSetModels() {
        SecurityService.getInstance().assertViewSetupPermissionForCurrentUser();
        List<PermissionSet> permissionSetList = [
            SELECT Id, name, label
            FROM PermissionSet
            WHERE IsOwnedByProfile = FALSE AND PermissionSetGroupId = NULL
            ORDER BY label
        ];

        List<PermissionSetModel> permissionSetModelList = new List<PermissionSetModel>();

        for (PermissionSet permissionSet : permissionSetList) {
            permissionSetModelList.add(
                new PermissionSetModel(permissionSet.Id, permissionSet.name, permissionSet.label)
            );
        }

        return permissionSetModelList;
    }

    public virtual PermissionSetModel getModelFromProfileId(Id profileId) {
        SecurityService.getInstance().assertViewSetupPermissionForCurrentUser();
        PermissionSet profilePermissionSet = [
            SELECT Id, name, label
            FROM PermissionSet
            WHERE IsOwnedByProfile = TRUE AND ProfileId = :profileId
            LIMIT 1
        ];

        return new PermissionSetModel(profilePermissionSet.Id, profilePermissionSet.name, profilePermissionSet.label);
    }

    public virtual Map<Id, PermissionSetModel> getModelsFromPermissionSetGroupIdList(List<Id> permissionSetGroupIds) {
        List<PermissionSet> permissionSetList = this.queryPermissionSetFromGroupIdList(permissionSetGroupIds);

        Map<Id, PermissionSetModel> permissionSetModelById = new Map<Id, PermissionSetModel>();

        for (PermissionSet permissionSet : permissionSetList) {
            permissionSetModelById.put(
                permissionSet.Id,
                new PermissionSetModel(permissionSet.Id, permissionSet.name, permissionSet.label)
            );
        }

        return permissionSetModelById;
    }

    @TestVisible
    protected virtual List<PermissionSet> queryPermissionSetFromGroupIdList(List<Id> permissionSetGroupIds) {
        SecurityService.getInstance().assertViewSetupPermissionForCurrentUser();
        return [SELECT Id, name, label FROM PermissionSet WHERE PermissionSetGroupId IN :permissionSetGroupIds];
    }
}
