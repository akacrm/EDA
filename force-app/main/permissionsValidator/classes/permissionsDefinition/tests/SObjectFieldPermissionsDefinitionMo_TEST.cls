@isTest
private class SObjectFieldPermissionsDefinitionMo_TEST {
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
        SObjectFieldPermissionsDefinitionModel model = new SObjectFieldPermissionsDefinitionModel();
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        String expectedRequiredAccessString = '';

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(false, true, true, false);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal a blank string.'
        );
    }

    @isTest
    private static void getRequiredAccessNeedsRead() {
        SObjectFieldPermissionsDefinitionModel model = new SObjectFieldPermissionsDefinitionModel();
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessRead;

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
    private static void getRequiredAccessNeedsReadUpdate() {
        SObjectFieldPermissionsDefinitionModel model = new SObjectFieldPermissionsDefinitionModel();
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessReadEdit;

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
    private static void getRequiredAccessNeedsUpdate() {
        SObjectFieldPermissionsDefinitionModel model = new SObjectFieldPermissionsDefinitionModel();
        model.readAccessRequired = true;
        model.updateAccessRequired = true;
        String expectedRequiredAccessString = Label.missingAccessEdit;

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
