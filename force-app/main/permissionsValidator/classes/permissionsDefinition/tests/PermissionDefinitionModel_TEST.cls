@isTest
private class PermissionDefinitionModel_TEST {
    @isTest
    private static void hasRequiredAccessPositive() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.createAccessRequired = true;
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        model.deleteAccessRequired = true;

        Boolean expectedHasRequiredAccess = true;

        Test.startTest();
        PermissionDefinitionModel.AccessCheck accessCheck = model.hasRequiredAccess(true, true, true, true);
        Test.stopTest();

        System.assertEquals(
            expectedHasRequiredAccess,
            accessCheck.passed,
            'Access check should equal the expected value.'
        );
    }

    @isTest
    private static void hasRequiredAccessNegative() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.createAccessRequired = true;
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        model.deleteAccessRequired = true;

        Boolean expectedHasRequiredAccess = false;

        Test.startTest();
        PermissionDefinitionModel.AccessCheck accessCheck = model.hasRequiredAccess(true, false, true, true);
        Test.stopTest();

        System.assertEquals(
            expectedHasRequiredAccess,
            accessCheck.passed,
            'Access Check pass should equal the expected value.'
        );
    }

    @isTest
    private static void getQualifiedName() {
        String featureName = 'Test Feature';
        String apiName = 'apiname';

        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.featureName = featureName;
        model.apiName = apiName;

        String expectedQualifiedName = apiName;

        Test.startTest();
        String qualifiedName = model.getQualifiedName();
        Test.stopTest();

        System.assertEquals(expectedQualifiedName, qualifiedName, 'Qualified name should equal the expected value.');
    }

    @isTest
    private static void getQualifiedSubName() {
        String featureName = 'Test Feature';
        String apiName = 'apiname';
        String apiSubName = 'apisubname';

        SObjectFieldPermissionsDefinitionModel model = new SObjectFieldPermissionsDefinitionModel();
        model.featureName = featureName;
        model.apiName = apiName;
        model.apiSubName = apiSubName;

        String expectedQualifiedSubName = apiSubName;

        Test.startTest();
        String qualifiedSubName = model.getQualifiedSubName();
        Test.stopTest();

        System.assertEquals(
            expectedQualifiedSubName,
            qualifiedSubName,
            'Qualified subname should equal the expected value.'
        );
    }

    @isTest
    private static void getQualifiedFullNameWithSubname() {
        String featureName = 'Test Feature';
        String apiName = 'apiname';
        String apiSubName = 'apisubname';

        SObjectFieldPermissionsDefinitionModel model = new SObjectFieldPermissionsDefinitionModel();
        model.featureName = featureName;
        model.apiName = apiName;
        model.apiSubName = apiSubName;

        String expectedQualifiedFullName = apiName + '.' + apiSubName;

        Test.startTest();
        String qualifiedFullName = model.getQualifiedFullName();
        Test.stopTest();

        System.assertEquals(
            expectedQualifiedFullName,
            qualifiedFullName,
            'Qualified full name should equal the expected value.'
        );
    }

    @isTest
    private static void getQualifiedFullNameWithoutSubname() {
        String featureName = 'Test Feature';
        String apiName = 'apiname';

        SObjectFieldPermissionsDefinitionModel model = new SObjectFieldPermissionsDefinitionModel();
        model.featureName = featureName;
        model.apiName = apiName;

        String expectedQualifiedFullName = apiName;

        Test.startTest();
        String qualifiedFullName = model.getQualifiedFullName();
        Test.stopTest();

        System.assertEquals(
            expectedQualifiedFullName,
            qualifiedFullName,
            'Qualified full name should equal the expected value.'
        );
    }
}
