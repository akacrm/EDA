@isTest
private class PermissionSetModel_TEST {
    @isTest
    private static void constructor() {
        Id permissionSetId = '000000000000000000';
        String label = 'label';
        String name = 'name';

        Test.startTest();
        PermissionSetModel model = new PermissionSetModel(permissionSetId, name, label);
        Test.stopTest();

        System.assertEquals(
            permissionSetId,
            model.permissionSetId,
            'Permission Set Id should match value passed to model.'
        );
        System.assertEquals(label, model.label, 'Label should match value passed to model.');
        System.assertEquals(name, model.name, 'Name should match value passed to model.');
    }
}
