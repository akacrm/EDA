@isTest
private class PermissionSetSelectorVModel_TEST {
    @isTest
    private static void constructor() {
        List<PermissionSetVModel> permissionSetViewModelList = new List<PermissionSetVModel>();

        Test.startTest();
        PermissionSetSelectorVModel model = new PermissionSetSelectorVModel(permissionSetViewModelList);
        Test.stopTest();

        System.assertEquals(
            permissionSetViewModelList,
            model.permissionSetViewModelList,
            'Permission Set View Model List should match value passed to model.'
        );
    }
}
