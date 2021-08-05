public virtual with sharing class PermissionSetGroupSelectorVMapper {
    @TestVisible
    private static PermissionSetGroupSelectorVMapper instance;

    protected PermissionSetGroupSelectorVMapper() {
    }

    public static PermissionSetGroupSelectorVMapper getInstance() {
        if (instance == null) {
            instance = new PermissionSetGroupSelectorVMapper();
        }

        return instance;
    }

    public virtual PermissionSetGroupSelectorVModel getViewModel() {
        List<PermissionSetGroupModel> permissionSetGroupModelList = this.locatePermissionSetGroupService()
            .getPermissionSetGroupModels();

        List<PermissionSetGroupVModel> permissionSetGroupVModelList = this.getPermissionSetGroupVModelListFromModels(
            permissionSetGroupModelList
        );

        PermissionSetGroupSelectorVModel PermissionSetGroupSelectorVModel = new PermissionSetGroupSelectorVModel(
            permissionSetGroupVModelList
        );

        return PermissionSetGroupSelectorVModel;
    }

    @TestVisible
    protected virtual List<PermissionSetGroupVModel> getPermissionSetGroupVModelListFromModels(
        List<PermissionSetGroupModel> permissionSetGroupModelList
    ) {
        List<PermissionSetGroupVModel> permissionSetGroupVModelList = new List<PermissionSetGroupVModel>();

        for (PermissionSetGroupModel permissionSetGroupModel : permissionSetGroupModelList) {
            PermissionSetGroupVModel permissionSetGroupVModel = new PermissionSetGroupVModel(
                permissionSetGroupModel.permissionSetGroupId,
                permissionSetGroupModel.label
            );

            permissionSetGroupVModelList.add(permissionSetGroupVModel);
        }

        return permissionSetGroupVModelList;
    }

    @TestVisible
    private PermissionSetGroupService locatePermissionSetGroupService() {
        return PermissionSetGroupService.getInstance();
    }
}
