@isTest
private class SObjectPermissionsDefinitionModel_TEST {
    @isTest
    private static void emptyConstructor() {
        SObjectFieldPermissionsDefinitionModel model = new SObjectFieldPermissionsDefinitionModel();

        System.assertEquals(null, model.featureName, 'Feature Name should match default value for model.');
        System.assertEquals(null, model.apiName, 'API Name should match default value for model.');
        System.assertEquals(null, model.apiSubName, 'API Subname should match default value for model.');
    }

    @isTest
    private static void constructor() {
        String featureName = 'Test Feature';
        String apiName = 'apiname';
        String apiSubName = 'apiSubName';

        SObjectFieldPermissionsDefinitionModel model = new SObjectFieldPermissionsDefinitionModel(
            featureName,
            apiName,
            apiSubname,
            true,
            true
        );

        System.assertEquals(featureName, model.featureName, 'Feature Name should match value passed to model.');
        System.assertEquals(apiName, model.apiName, 'API Name should match value passed to model.');
        System.assertEquals(true, model.readAccessRequired, 'Read Access Required should default value for model.');
        System.assertEquals(true, model.updateAccessRequired, 'Update Access Required should default value for model.');
    }

    @isTest
    private static void getRequiredAccessPass() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.createAccessRequired = true;
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        model.deleteAccessRequired = true;
        String expectedRequiredAccessString = '';

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(true, true, true, true);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal a blank string.'
        );
    }

    @isTest
    private static void getRequiredAccessNeedsCreate() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.createAccessRequired = true;
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        model.deleteAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessCreate;

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(false, true, true, true);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal the expected custom label.'
        );
    }

    @isTest
    private static void getRequiredAccessNeedsCreateRead() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.createAccessRequired = true;
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        model.deleteAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessReadCreate;

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(false, false, true, true);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal the expected custom label.'
        );
    }

    @isTest
    private static void getRequiredAccessNeedsCreateReadEdit() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.createAccessRequired = true;
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        model.deleteAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessReadCreateEdit;

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(false, false, false, true);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal the expected custom label.'
        );
    }

    @isTest
    private static void getRequiredAccessNeedsCreateReadEditDelete() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.createAccessRequired = true;
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        model.deleteAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessReadCreateEditDelete;

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(false, false, false, false);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal the expected custom label.'
        );
    }

    @isTest
    private static void getRequiredAccessNeedsCreateReadDelete() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.createAccessRequired = true;
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        model.deleteAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessReadCreateDelete;

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(false, false, true, false);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal the expected custom label.'
        );
    }

    @isTest
    private static void getRequiredAccessNeedsCreateEdit() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.createAccessRequired = true;
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        model.deleteAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessCreateEdit;

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(false, true, false, true);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal the expected custom label.'
        );
    }

    @isTest
    private static void getRequiredAccessNeedsCreateEditDelete() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.createAccessRequired = true;
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        model.deleteAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessCreateEditDelete;

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(false, true, false, false);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal the expected custom label.'
        );
    }

    @isTest
    private static void getRequiredAccessNeedsCreateDelete() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.createAccessRequired = true;
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        model.deleteAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessCreateDelete;

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(false, true, true, false);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal the expected custom label.'
        );
    }

    @isTest
    private static void getRequiredAccessNeedsRead() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.createAccessRequired = true;
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        model.deleteAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessRead;

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(true, false, true, true);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal the expected custom label.'
        );
    }

    @isTest
    private static void getRequiredAccessNeedsReadUpdate() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.createAccessRequired = true;
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        model.deleteAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessReadEdit;

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(true, false, false, true);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal the expected custom label.'
        );
    }

    @isTest
    private static void getRequiredAccessNeedsReadUpdateDelete() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.createAccessRequired = true;
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        model.deleteAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessReadEditDelete;

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(true, false, false, false);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal the expected custom label.'
        );
    }

    @isTest
    private static void getRequiredAccessNeedsReadDelete() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.createAccessRequired = true;
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        model.deleteAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessReadEdit;

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(true, false, false, true);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal the expected custom label.'
        );
    }

    @isTest
    private static void getRequiredAccessNeedsUpdate() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessEdit;

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(true, true, false, true);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal the expected custom label.'
        );
    }

    @isTest
    private static void getRequiredAccessNeedsUpdateDelete() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessEditDelete;

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(true, true, false, false);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal the expected custom label.'
        );
    }

    @isTest
    private static void getRequiredAccessNeedsDelete() {
        SObjectPermissionsDefinitionModel model = new SObjectPermissionsDefinitionModel();
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessDelete;

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(true, true, true, false);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal the expected custom label.'
        );
    }

    @isTest
    private static void getMetadataType() {
        SObjectFieldPermissionsDefinitionModel model = new SObjectFieldPermissionsDefinitionModel();

        String expectedMetadataType = 'SObjectField';

        Test.startTest();
        String metadataType = model.getMetadataType();
        Test.stopTest();

        System.assertEquals(
            expectedMetadataType,
            metadataType,
            'Get Metadata Type should return the expected static value.'
        );
    }
}
