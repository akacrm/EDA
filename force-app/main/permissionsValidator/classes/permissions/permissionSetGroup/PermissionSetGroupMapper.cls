public virtual with sharing class PermissionSetGroupMapper {
    @TestVisible
    private static PermissionSetGroupMapper instance;

    protected PermissionSetGroupMapper() {
    }

    public static PermissionSetGroupMapper getInstance() {
        if (instance == null) {
            instance = new PermissionSetGroupMapper();
        }

        return instance;
    }

    public virtual List<PermissionSetGroupModel> getPermissionSetGroupModels() {
        List<PermissionSetGroup> permissionSetGroupList = this.queryPermissionSetGroups();

        List<PermissionSetGroupModel> permissionSetGroupModelList = new List<PermissionSetGroupModel>();

        for (PermissionSetGroup permissionSetGroup : permissionSetGroupList) {
            permissionSetGroupModelList.add(
                new PermissionSetGroupModel(permissionSetGroup.Id, permissionSetGroup.MasterLabel)
            );
        }

        return permissionSetGroupModelList;
    }

    @TestVisible
    protected virtual List<PermissionSetGroup> queryPermissionSetGroups() {
        SecurityService.getInstance().assertViewSetupPermissionForCurrentUser();
        return [SELECT Id, MasterLabel FROM PermissionSetGroup ORDER BY MasterLabel];
    }
}
