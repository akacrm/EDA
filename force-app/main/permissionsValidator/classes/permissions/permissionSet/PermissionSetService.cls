public virtual class PermissionSetService {
    @TestVisible
    private static PermissionSetService instance;

    protected PermissionSetService() {
    }

    public static PermissionSetService getInstance() {
        if (instance == null) {
            instance = new PermissionSetService();
        }

        return instance;
    }

    public virtual List<PermissionSetModel> getPermissionSetModels() {
        return this.locatePermissionSetMapper().getPermissionSetModels();
    }

    public virtual PermissionSetModel getModelFromProfileId(Id profileId) {
        return this.locatePermissionSetMapper().getModelFromProfileId(profileId);
    }

    public virtual Map<Id, PermissionSetModel> getModelsFromPermissionSetGroupIdList(List<Id> permissionSetGroupIds) {
        return this.locatePermissionSetMapper().getModelsFromPermissionSetGroupIdList(permissionSetGroupIds);
    }

    public virtual List<Id> getCombinedPermissionSetIdList(
        Id profileId,
        List<Id> permissionSetIdList,
        List<Id> permissionSetGroupIdList
    ) {
        List<Id> permissionSetIdListToReturn = new List<Id>(permissionSetIdList);

        if (String.isBlank(profileId) == false) {
            PermissionSetModel profilePermissionSet = this.getModelFromProfileId(profileId);

            permissionSetIdListToReturn.add(profilePermissionSet.permissionSetId);
        }

        if (permissionSetGroupIdList.isEmpty() == false) {
            Map<Id, PermissionSetModel> permissionSetModelById = this.getModelsFromPermissionSetGroupIdList(
                permissionSetGroupIdList
            );

            permissionSetIdListToReturn.addAll(permissionSetModelById.keySet());
        }

        return permissionSetIdListToReturn;
    }

    @TestVisible
    private PermissionSetMapper locatePermissionSetMapper() {
        return PermissionSetMapper.getInstance();
    }
}
