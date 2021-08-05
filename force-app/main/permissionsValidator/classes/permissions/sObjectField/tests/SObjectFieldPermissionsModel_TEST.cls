@isTest
private class SObjectFieldPermissionsModel_TEST {
    @isTest
    private static void constructor() {
        String expectedSObjectType = 'Account';
        String expectedName = 'Name';
        Boolean expectedCanRead = false;
        Boolean expectedCanUpdate = false;

        Test.startTest();
        SObjectFieldPermissionsModel model = new SObjectFieldPermissionsModel(
            expectedSObjectType,
            expectedName,
            expectedCanRead,
            expectedCanUpdate
        );
        Test.stopTest();

        System.assertEquals(expectedSObjectType, model.sObjectType, 'SObject Type should match value passed to model.');
        System.assertEquals(expectedName, model.name, 'Name should match value passed to model.');
        System.assertEquals(expectedCanRead, model.canRead, 'Can Read should match value passed to model.');
        System.assertEquals(expectedCanUpdate, model.canUpdate, 'Can Update should match value passed to model.');
    }

    @isTest
    private static void combineModels() {
        String expectedSObjectType = 'Account';
        String expectedName = 'Name';
        Boolean expectedCanRead = true;
        Boolean expectedCanUpdate = true;

        SObjectFieldPermissionsModel model = new SObjectFieldPermissionsModel(
            expectedSObjectType,
            expectedName,
            false,
            expectedCanUpdate
        );
        SObjectFieldPermissionsModel model2 = new SObjectFieldPermissionsModel(
            expectedSObjectType,
            expectedName,
            expectedCanRead,
            false
        );

        Test.startTest();
        SObjectFieldPermissionsModel finalModel = model.combineModels(model2);
        Test.stopTest();

        System.assertEquals(expectedCanRead, finalModel.canRead, 'Can Read should match value passed to model.');
        System.assertEquals(expectedCanUpdate, finalModel.canUpdate, 'Can Update should match value passed to model.');
    }

    @isTest
    private static void combineModelsDifferentSObjectAndName() {
        String expectedSObjectType = 'Account';
        String expectedName = 'Name';
        Boolean expectedCanRead = true;
        Boolean expectedCanUpdate = true;

        SObjectFieldPermissionsModel model = new SObjectFieldPermissionsModel(
            expectedSObjectType,
            expectedName,
            expectedCanRead,
            expectedCanUpdate
        );
        SObjectFieldPermissionsModel model2 = new SObjectFieldPermissionsModel('Other', 'otherName', false, false);

        try {
            Test.startTest();
            SObjectFieldPermissionsModel finalModel = model.combineModels(model2);
            Test.stopTest();

            System.assert(false, 'An illegal argument exception should always be thrown.');
        } catch (IllegalArgumentException iae) {
        }
    }
}
