@isTest
private class PermissionSetGroupModel_TEST {
    @isTest
    private static void constructor() {
        Id expectedPermissionSetGroupId = '000000000000000000';
        String expectedLabel = 'permissionSet';

        Test.startTest();
        PermissionSetGroupModel model = new PermissionSetGroupModel(expectedPermissionSetGroupId, expectedLabel);
        Test.stopTest();

        System.assertEquals(
            expectedPermissionSetGroupId,
            model.permissionSetGroupId,
            'Permission Set Id should match value passed to model.'
        );
        System.assertEquals(expectedLabel, model.label, 'Label should match value passed to model.');
    }
}
