@isTest
private class SObjectPermissionsModel_TEST {
    @isTest
    private static void constructor() {
        String expectedSObjectType = 'Account';
        Boolean expectedCanCreate = false;
        Boolean expectedCanRead = false;
        Boolean expectedCanUpdate = false;
        Boolean expectedCanDelete = false;

        Test.startTest();
        SObjectPermissionsModel model = new SObjectPermissionsModel(
            expectedSObjectType,
            expectedCanCreate,
            expectedCanRead,
            expectedCanUpdate,
            expectedCanDelete
        );
        Test.stopTest();

        System.assertEquals(expectedSObjectType, model.sObjectType, 'SObject Type should match value passed to model.');
        System.assertEquals(expectedCanCreate, model.canCreate, 'Can Create should match value passed to model.');
        System.assertEquals(expectedCanRead, model.canRead, 'Can Read should match value passed to model.');
        System.assertEquals(expectedCanUpdate, model.canUpdate, 'Can Update should match value passed to model.');
        System.assertEquals(expectedCanDelete, model.canDelete, 'Can Delete should match value passed to model.');
    }

    @isTest
    private static void combineModels() {
        String expectedSObjectType = 'Account';
        Boolean expectedCanCreate = true;
        Boolean expectedCanRead = true;
        Boolean expectedCanUpdate = true;
        Boolean expectedCanDelete = true;

        SObjectPermissionsModel model = new SObjectPermissionsModel(
            expectedSObjectType,
            false,
            expectedCanRead,
            false,
            expectedCanDelete
        );
        SObjectPermissionsModel model2 = new SObjectPermissionsModel(
            expectedSObjectType,
            expectedCanCreate,
            false,
            expectedCanUpdate,
            false
        );

        Test.startTest();
        SObjectPermissionsModel finalModel = model.combineModels(model2);
        Test.stopTest();
        System.assertEquals(expectedCanCreate, finalModel.canCreate, 'Can Create should match value passed to model.');
        System.assertEquals(expectedCanRead, finalModel.canRead, 'Can Read should match value passed to model.');
        System.assertEquals(expectedCanUpdate, finalModel.canUpdate, 'Can Update should match value passed to model.');
        System.assertEquals(expectedCanDelete, finalModel.canDelete, 'Can Delete should match value passed to model.');
    }

    @isTest
    private static void combineModelsDifferentSObject() {
        String expectedSObjectType = 'Account';
        Boolean expectedCanCreate = false;
        Boolean expectedCanRead = false;
        Boolean expectedCanUpdate = false;
        Boolean expectedCanDelete = false;

        SObjectPermissionsModel model = new SObjectPermissionsModel(
            expectedSObjectType,
            expectedCanCreate,
            expectedCanRead,
            expectedCanUpdate,
            expectedCanDelete
        );
        SObjectPermissionsModel model2 = new SObjectPermissionsModel('Contact', true, false, true, true);

        try {
            Test.startTest();
            SObjectPermissionsModel finalModel = model.combineModels(model2);
            Test.stopTest();

            System.assert(false, 'An illegal argument exception should always be thrown.');
        } catch (IllegalArgumentException iae) {
        }
    }
}
