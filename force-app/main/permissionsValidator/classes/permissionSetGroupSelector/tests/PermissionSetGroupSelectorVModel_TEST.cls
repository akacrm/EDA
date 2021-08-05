@isTest
private class PermissionSetGroupSelectorVModel_TEST {
    @isTest
    private static void constructor() {
        List<PermissionSetGroupVModel> permissionSetGroupViewModelList = new List<PermissionSetGroupVModel>();

        Test.startTest();
        PermissionSetGroupSelectorVModel model = new PermissionSetGroupSelectorVModel(permissionSetGroupViewModelList);
        Test.stopTest();

        System.assertEquals(
            permissionSetGroupViewModelList,
            model.permissionSetGroupViewModelList,
            'Permission Set Group View Model List should match value passed to model.'
        );
    }
}
