@isTest
private class ApexClassPermDefinitionModel_TEST {
    @isTest
    private static void emptyConstructor() {
        ApexClassPermDefinitionModel model = new ApexClassPermDefinitionModel();

        System.assertEquals(null, model.featureName, 'Feature Name should match default value for model.');
        System.assertEquals(null, model.apiName, 'API Name should match default value for model.');
        System.assertEquals(null, model.namespacePrefix, 'Namespace Prefix should match default value for model.');
        System.assertEquals(
            true,
            model.readAccessRequired,
            'Read Access Required should match default value for model.'
        );
    }

    @isTest
    private static void constructor() {
        String featureName = 'Test Feature';
        String apiName = 'apiname';
        String namespacePrefix = 'namespacePrefix';

        ApexClassPermDefinitionModel model = new ApexClassPermDefinitionModel(featureName, apiName, namespacePrefix);

        System.assertEquals(featureName, model.featureName, 'Feature Name should match value passed to model.');
        System.assertEquals(apiName, model.apiName, 'API Name should match value passed to model.');
        System.assertEquals(
            namespacePrefix,
            model.namespacePrefix,
            'Namespace Prefix should match value passed to model.'
        );
        System.assertEquals(true, model.readAccessRequired, 'Read Access Required should default value for model.');
    }

    @isTest
    private static void getRequiredAccessPass() {
        ApexClassPermDefinitionModel model = new ApexClassPermDefinitionModel();
        String expectedRequiredAccessString = '';

        Test.startTest();
        String requiredAccessString = model.getRequiredAccess(false, true, false, false);
        Test.stopTest();

        System.assertEquals(
            expectedRequiredAccessString,
            requiredAccessString,
            'Get Required Access should equal a blank string.'
        );
    }

    @isTest
    private static void getRequiredAccessFail() {
        ApexClassPermDefinitionModel model = new ApexClassPermDefinitionModel();
        String expectedRequiredAccessString = Label.apexClassAccessRequired;

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
    private static void getMetadataType() {
        ApexClassPermDefinitionModel model = new ApexClassPermDefinitionModel();

        String expectedMetadataType = 'Apex Class';

        Test.startTest();
        String metadataType = model.getMetadataType();
        Test.stopTest();

        System.assertEquals(
            expectedMetadataType,
            metadataType,
            'Get Metadata Type should return the expected static value.'
        );
    }

    @isTest
    private static void getQualifiedNameWithNamespace() {
        ApexClassPermDefinitionModel model = new ApexClassPermDefinitionModel();
        model.apiName = 'apiName';
        model.namespacePrefix = 'namespace';

        String expectedQualifiedName = model.namespacePrefix + '.' + model.apiName;

        Test.startTest();
        String qualifiedName = model.getQualifiedName();
        Test.stopTest();

        System.assertEquals(
            expectedQualifiedName,
            qualifiedName,
            'Get Qualified Type should return the expected value.'
        );
    }

    @isTest
    private static void getQualifiedNameNoNamespace() {
        ApexClassPermDefinitionModel model = new ApexClassPermDefinitionModel();
        model.apiName = 'apiName';

        String expectedQualifiedName = model.apiName;

        Test.startTest();
        String qualifiedName = model.getQualifiedName();
        Test.stopTest();

        System.assertEquals(
            expectedQualifiedName,
            qualifiedName,
            'Get Qualified Type should return the expected value.'
        );
    }
}
