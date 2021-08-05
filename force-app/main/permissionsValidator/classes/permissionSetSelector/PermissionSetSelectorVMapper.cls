public virtual with sharing class PermissionSetSelectorVMapper {
    @TestVisible
    private static PermissionSetSelectorVMapper instance;

    protected PermissionSetSelectorVMapper() {
    }

    public static PermissionSetSelectorVMapper getInstance() {
        if (instance == null) {
            instance = new PermissionSetSelectorVMapper();
        }

        return instance;
    }

    public virtual PermissionSetSelectorVModel getViewModel() {
        List<PermissionSetModel> permissionSetModelList = this.locatePermissionSetService().getPermissionSetModels();

        List<PermissionSetVModel> permissionSetVModelList = this.getPermissionSetVModelListFromModels(
            permissionSetModelList
        );

        PermissionSetSelectorVModel PermissionSetSelectorVModel = new PermissionSetSelectorVModel(
            permissionSetVModelList
        );

        return PermissionSetSelectorVModel;
    }

    @TestVisible
    protected virtual List<PermissionSetVModel> getPermissionSetVModelListFromModels(
        List<PermissionSetModel> permissionSetModelList
    ) {
        List<PermissionSetVModel> permissionSetVModelList = new List<PermissionSetVModel>();

        for (PermissionSetModel permissionSetModel : permissionSetModelList) {
            PermissionSetVModel permissionSetVModel = new PermissionSetVModel(
                permissionSetModel.permissionSetId,
                permissionSetModel.label
            );

            permissionSetVModelList.add(permissionSetVModel);
        }

        return permissionSetVModelList;
    }

    @TestVisible
    private PermissionSetService locatePermissionSetService() {
        return PermissionSetService.getInstance();
    }
}
