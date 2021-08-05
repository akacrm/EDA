@isTest
private class PermissionDefinitionMapper_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        PermissionDefinitionMapper permissionDefinitionMapperinstance = PermissionDefinitionMapper.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, permissionDefinitionMapperinstance, 'Mapper instance should not be null.');
        System.assertEquals(
            PermissionDefinitionMapper.instance,
            permissionDefinitionMapperinstance,
            'Mapper instance should equal the apex class mapper instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        PermissionDefinitionMapper permissionDefinitionMapperInstance = PermissionDefinitionMapper.getInstance();

        Test.startTest();
        PermissionDefinitionMapper permissionDefinitionMapperGetInstance = PermissionDefinitionMapper.instance;
        Test.stopTest();

        System.assertEquals(
            permissionDefinitionMapperInstance,
            permissionDefinitionMapperGetInstance,
            'Retrieved Mapper instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getPermissionDefinitionModelListApexClass() {
        PermissionDefinitionMapperStub permissionDefinitionMapperStub = new PermissionDefinitionMapperStub();
        permissionDefinitionMapperStub.metadataTypeToSet = 'Apex Class';
        PermissionDefinitionMapper.instance = permissionDefinitionMapperStub;

        NamespaceService.getInstance().stripNamespace = false;
        NamespaceService.getInstance().namespaceStripProcessed = true;

        PermissionDefinitionMapper permissionDefinitionMapper = PermissionDefinitionMapper.getInstance();

        Test.startTest();
        List<PermissionDefinitionModel> permissionDefinitionModelList = permissionDefinitionMapper.getPermissionDefinitionModelListByFeatureName(
            '%'
        );
        Test.stopTest();

        System.assertEquals(
            1,
            permissionDefinitionModelList.size(),
            'The number of Permission Definition Models should equal 1.'
        );

        for (PermissionDefinitionModel permissionDefinitionModel : permissionDefinitionModelList) {
            ApexClassPermDefinitionModel apexClassPermDefinitionModel = (ApexClassPermDefinitionModel) permissionDefinitionModel;

            System.assertEquals(
                'testFeatureName',
                apexClassPermDefinitionModel.featureName,
                'Apex Class Permission Definition Model feature name should equal the specified value'
            );
            System.assertEquals(
                'testapiname',
                apexClassPermDefinitionModel.apiName,
                'Apex Class Permission Definition Model API name should equal the specified value'
            );
            System.assertEquals(
                'hed',
                apexClassPermDefinitionModel.namespacePrefix,
                'Apex Class Permission Definition Model namespace prefix should equal the specified value'
            );
            System.assertEquals(
                true,
                apexClassPermDefinitionModel.readAccessRequired,
                'Apex Class Permission Definition Model read access requirement should equal the specified value'
            );
            System.assertEquals(
                'Apex Class',
                apexClassPermDefinitionModel.getMetadataType(),
                'Apex Class Permission Definition Model metadata type should equal the specified value'
            );
        }
    }

    @isTest
    private static void getPermissionDefinitionModelListSObject() {
        PermissionDefinitionMapperStub permissionDefinitionMapperStub = new PermissionDefinitionMapperStub();
        permissionDefinitionMapperStub.metadataTypeToSet = 'SObject';
        NamespaceService.getInstance().stripNamespace = false;
        NamespaceService.getInstance().namespaceStripProcessed = true;

        PermissionDefinitionMapper.instance = permissionDefinitionMapperStub;
        PermissionDefinitionMapper permissionDefinitionMapper = PermissionDefinitionMapper.getInstance();

        Test.startTest();
        List<PermissionDefinitionModel> permissionDefinitionModelList = permissionDefinitionMapper.getPermissionDefinitionModelListByFeatureName(
            '%'
        );
        Test.stopTest();

        System.assertEquals(
            1,
            permissionDefinitionModelList.size(),
            'The number of Permission Definition Models should equal 1.'
        );

        for (PermissionDefinitionModel permissionDefinitionModel : permissionDefinitionModelList) {
            SObjectPermissionsDefinitionModel sObjectPermissionsDefinitionModel = (SObjectPermissionsDefinitionModel) permissionDefinitionModel;

            System.assertEquals(
                'testFeatureName',
                sObjectPermissionsDefinitionModel.featureName,
                'SObject Permission Definition Model feature name should equal the specified value'
            );
            System.assertEquals(
                'hed__testapiname',
                sObjectPermissionsDefinitionModel.apiName,
                'SObject Permission Definition Model API name should equal the specified value'
            );
            System.assertEquals(
                true,
                sObjectPermissionsDefinitionModel.createAccessRequired,
                'SObject Permission Definition Model create access requirement should equal the specified value'
            );
            System.assertEquals(
                true,
                sObjectPermissionsDefinitionModel.readAccessRequired,
                'SObject Permission Definition Model read access requirement should equal the specified value'
            );
            System.assertEquals(
                true,
                sObjectPermissionsDefinitionModel.updateAccessRequired,
                'SObject Permission Definition Model edit access requirement should equal the specified value'
            );
            System.assertEquals(
                true,
                sObjectPermissionsDefinitionModel.deleteAccessRequired,
                'SObject Permission Definition Model delete access requirement should equal the specified value'
            );
            System.assertEquals(
                'SObject',
                sObjectPermissionsDefinitionModel.getMetadataType(),
                'SObject Permission Definition Model metadata type should equal the specified value'
            );
        }
    }

    @isTest
    private static void getPermissionDefinitionModelListSObjectField() {
        PermissionDefinitionMapperStub permissionDefinitionMapperStub = new PermissionDefinitionMapperStub();
        permissionDefinitionMapperStub.metadataTypeToSet = 'SObjectField';
        NamespaceService.getInstance().stripNamespace = false;
        NamespaceService.getInstance().namespaceStripProcessed = true;

        PermissionDefinitionMapper.instance = permissionDefinitionMapperStub;
        PermissionDefinitionMapper permissionDefinitionMapper = PermissionDefinitionMapper.getInstance();

        Test.startTest();
        List<PermissionDefinitionModel> permissionDefinitionModelList = permissionDefinitionMapper.getPermissionDefinitionModelListByFeatureName(
            '%'
        );
        Test.stopTest();

        System.assertEquals(
            1,
            permissionDefinitionModelList.size(),
            'The number of Permission Definition Models should equal 1.'
        );

        for (PermissionDefinitionModel permissionDefinitionModel : permissionDefinitionModelList) {
            SObjectFieldPermissionsDefinitionModel sObjectFieldPermissionsDefinitionModel = (SObjectFieldPermissionsDefinitionModel) permissionDefinitionModel;

            System.assertEquals(
                'testFeatureName',
                sObjectFieldPermissionsDefinitionModel.featureName,
                'SObjectField Permission Definition Model feature name should equal the specified value'
            );
            System.assertEquals(
                'hed__testapiname',
                sObjectFieldPermissionsDefinitionModel.apiName,
                'SObjectField Permission Definition Model API name should equal the specified value'
            );
            System.assertEquals(
                'hed__testapisubname',
                sObjectFieldPermissionsDefinitionModel.apiSubName,
                'SObjectField Permission Definition Model API Subname should equal the specified value'
            );
            System.assertEquals(
                true,
                sObjectFieldPermissionsDefinitionModel.readAccessRequired,
                'SObjectField Permission Definition Model read access requirement should equal the specified value'
            );
            System.assertEquals(
                true,
                sObjectFieldPermissionsDefinitionModel.updateAccessRequired,
                'SObjectField Permission Definition Model edit access requirement should equal the specified value'
            );
            System.assertEquals(
                'SObjectField',
                sObjectFieldPermissionsDefinitionModel.getMetadataType(),
                'SObjectField Permission Definition Model metadata type should equal the specified value'
            );
        }
    }

    @isTest
    private static void getPermissionDefinitionModelListUnknownMetadataType() {
        PermissionDefinitionMapperStub permissionDefinitionMapperStub = new PermissionDefinitionMapperStub();
        permissionDefinitionMapperStub.metadataTypeToSet = 'Bad Metadata Type';

        PermissionDefinitionMapper.instance = permissionDefinitionMapperStub;
        PermissionDefinitionMapper permissionDefinitionMapper = PermissionDefinitionMapper.getInstance();

        try {
            Test.startTest();
            List<PermissionDefinitionModel> permissionDefinitionModelList = permissionDefinitionMapper.getPermissionDefinitionModelListByFeatureName(
                '%'
            );
            Test.stopTest();

            System.assert(false, 'An exception should be thrown for an invalid metadata type');
        } catch (IllegalArgumentException iae) {
        }
    }

    @isTest
    private static void getPermissionDefinitionList() {
        PermissionDefinitionMapper permissionDefinitionMapper = PermissionDefinitionMapper.getInstance();

        Test.startTest();
        List<Permission_Definition__mdt> permissionDefinitionList = permissionDefinitionMapper.getPermissionDefinitionList(
            '%'
        );
        Test.stopTest();

        System.assertNotEquals(null, permissionDefinitionList, 'Queried list of metadata types should not be null.');
    }

    @isTest
    private static void getApexClassPermDefinitionModel() {
        PermissionDefinitionMapperStub permissionDefinitionMapperStub = new PermissionDefinitionMapperStub();
        permissionDefinitionMapperStub.metadataTypeToSet = 'Apex Class';
        PermissionDefinitionMapper.instance = permissionDefinitionMapperStub;

        NamespaceService.getInstance().stripNamespace = false;
        NamespaceService.getInstance().namespaceStripProcessed = true;

        PermissionDefinitionMapper permissionDefinitionMapper = PermissionDefinitionMapper.getInstance();

        Permission_Definition__mdt permissionDefinition = permissionDefinitionMapper.getPermissionDefinitionList(
            '%'
        )[0];

        Test.startTest();
        ApexClassPermDefinitionModel apexClassPermDefinitionModel = permissionDefinitionMapper.getApexClassPermDefinitionModel(
            permissionDefinition
        );
        Test.stopTest();

        System.assertEquals(
            permissionDefinition.Feature_Name__c,
            apexClassPermDefinitionModel.featureName,
            'Feature Name from Model should match that of Permission Definition.'
        );

        List<String> dotPrefixSplit = NamespaceService.getInstance().splitDotFormat(permissionDefinition.Api_Name__c);
        String expectedNamespace = dotPrefixSplit[0];
        String expectedApiName = dotPrefixSplit[1];

        System.assertEquals(
            expectedApiName,
            apexClassPermDefinitionModel.apiName,
            'Api Name from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            expectedNamespace,
            apexClassPermDefinitionModel.namespacePrefix,
            'Namespace from Model should match that of Permission Definition.'
        );
    }

    @isTest
    private static void getApexClassPermDefinitionModelStripNamespace() {
        PermissionDefinitionMapperStub permissionDefinitionMapperStub = new PermissionDefinitionMapperStub();
        permissionDefinitionMapperStub.metadataTypeToSet = 'Apex Class';
        PermissionDefinitionMapper.instance = permissionDefinitionMapperStub;

        NamespaceService.getInstance().stripNamespace = true;
        NamespaceService.getInstance().namespaceStripProcessed = true;

        PermissionDefinitionMapper permissionDefinitionMapper = PermissionDefinitionMapper.getInstance();

        Permission_Definition__mdt permissionDefinition = permissionDefinitionMapper.getPermissionDefinitionList(
            '%'
        )[0];

        Test.startTest();
        ApexClassPermDefinitionModel apexClassPermDefinitionModel = permissionDefinitionMapper.getApexClassPermDefinitionModel(
            permissionDefinition
        );
        Test.stopTest();

        List<String> dotPrefixSplit = NamespaceService.getInstance().splitDotFormat(permissionDefinition.Api_Name__c);
        String expectedApiName = NamespaceService.getInstance().handleLocalNamespace(dotPrefixSplit[1]);

        System.assertEquals(
            permissionDefinition.Feature_Name__c,
            apexClassPermDefinitionModel.featureName,
            'Feature Name from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            expectedApiName,
            apexClassPermDefinitionModel.apiName,
            'Api Name from Model should match that of Permission Definition.'
        );
        System.assertEquals('', apexClassPermDefinitionModel.namespacePrefix, 'Namespace from Model should be blank.');
    }

    @isTest
    private static void getSObjectPermissionsDefinitionModel() {
        PermissionDefinitionMapperStub permissionDefinitionMapperStub = new PermissionDefinitionMapperStub();
        permissionDefinitionMapperStub.metadataTypeToSet = 'SObject';
        PermissionDefinitionMapper.instance = permissionDefinitionMapperStub;

        NamespaceService.getInstance().stripNamespace = false;
        NamespaceService.getInstance().namespaceStripProcessed = true;

        PermissionDefinitionMapper permissionDefinitionMapper = PermissionDefinitionMapper.getInstance();

        Permission_Definition__mdt permissionDefinition = permissionDefinitionMapper.getPermissionDefinitionList(
            '%'
        )[0];

        Test.startTest();
        SObjectPermissionsDefinitionModel sObjectPermissionsDefinitionModel = permissionDefinitionMapper.getSObjectPermissionsDefinitionModel(
            permissionDefinition
        );
        Test.stopTest();

        System.assertEquals(
            permissionDefinition.Feature_Name__c,
            sObjectPermissionsDefinitionModel.featureName,
            'Feature Name from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            permissionDefinition.Api_Name__c,
            sObjectPermissionsDefinitionModel.apiName,
            'Api Name from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            permissionDefinition.Create__c,
            sObjectPermissionsDefinitionModel.createAccessRequired,
            'Create Access Required from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            permissionDefinition.Read__c,
            sObjectPermissionsDefinitionModel.readAccessRequired,
            'Read Access Required from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            permissionDefinition.Update__c,
            sObjectPermissionsDefinitionModel.updateAccessRequired,
            'Update Access Required from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            permissionDefinition.Delete__c,
            sObjectPermissionsDefinitionModel.deleteAccessRequired,
            'Delete Access Required from Model should match that of Permission Definition.'
        );
    }

    @isTest
    private static void getSObjectPermissionsDefinitionModelStripNamespace() {
        PermissionDefinitionMapperStub permissionDefinitionMapperStub = new PermissionDefinitionMapperStub();
        permissionDefinitionMapperStub.metadataTypeToSet = 'SObject';
        PermissionDefinitionMapper.instance = permissionDefinitionMapperStub;

        NamespaceService.getInstance().stripNamespace = true;
        NamespaceService.getInstance().namespaceStripProcessed = true;

        PermissionDefinitionMapper permissionDefinitionMapper = PermissionDefinitionMapper.getInstance();

        Permission_Definition__mdt permissionDefinition = permissionDefinitionMapper.getPermissionDefinitionList(
            '%'
        )[0];

        Test.startTest();
        SObjectPermissionsDefinitionModel sObjectPermissionsDefinitionModel = permissionDefinitionMapper.getSObjectPermissionsDefinitionModel(
            permissionDefinition
        );
        Test.stopTest();

        String expectedApiName = NamespaceService.getInstance().handleLocalNamespace(permissionDefinition.Api_Name__c);

        System.assertEquals(
            permissionDefinition.Feature_Name__c,
            sObjectPermissionsDefinitionModel.featureName,
            'Feature Name from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            expectedApiName,
            sObjectPermissionsDefinitionModel.apiName,
            'Api Name from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            permissionDefinition.Create__c,
            sObjectPermissionsDefinitionModel.createAccessRequired,
            'Create Access Required from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            permissionDefinition.Read__c,
            sObjectPermissionsDefinitionModel.readAccessRequired,
            'Read Access Required from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            permissionDefinition.Update__c,
            sObjectPermissionsDefinitionModel.updateAccessRequired,
            'Update Access Required from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            permissionDefinition.Delete__c,
            sObjectPermissionsDefinitionModel.deleteAccessRequired,
            'Delete Access Required from Model should match that of Permission Definition.'
        );
    }

    @isTest
    private static void getSObjectFieldPermissionsDefinitionModel() {
        PermissionDefinitionMapperStub permissionDefinitionMapperStub = new PermissionDefinitionMapperStub();
        permissionDefinitionMapperStub.metadataTypeToSet = 'SObjectField';
        PermissionDefinitionMapper.instance = permissionDefinitionMapperStub;

        NamespaceService.getInstance().stripNamespace = false;
        NamespaceService.getInstance().namespaceStripProcessed = true;

        PermissionDefinitionMapper permissionDefinitionMapper = PermissionDefinitionMapper.getInstance();

        Permission_Definition__mdt permissionDefinition = permissionDefinitionMapper.getPermissionDefinitionList(
            '%'
        )[0];

        Test.startTest();
        SObjectFieldPermissionsDefinitionModel sObjectFieldPermissionsDefinitionModel = permissionDefinitionMapper.getSObjectFieldPermissionsDefinitionModel(
            permissionDefinition
        );
        Test.stopTest();

        System.assertEquals(
            permissionDefinition.Feature_Name__c,
            sObjectFieldPermissionsDefinitionModel.featureName,
            'Feature Name from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            permissionDefinition.Api_Name__c,
            sObjectFieldPermissionsDefinitionModel.apiName,
            'Api Name from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            permissionDefinition.Api_Subname__c,
            sObjectFieldPermissionsDefinitionModel.apiSubName,
            'Api Subname from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            permissionDefinition.Read__c,
            sObjectFieldPermissionsDefinitionModel.readAccessRequired,
            'Read Access Required from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            permissionDefinition.Update__c,
            sObjectFieldPermissionsDefinitionModel.updateAccessRequired,
            'Update Access Required from Model should match that of Permission Definition.'
        );
    }

    @isTest
    private static void getSObjectFieldPermissionsDefinitionModelStripNamespace() {
        PermissionDefinitionMapperStub permissionDefinitionMapperStub = new PermissionDefinitionMapperStub();
        permissionDefinitionMapperStub.metadataTypeToSet = 'SObjectField';
        PermissionDefinitionMapper.instance = permissionDefinitionMapperStub;

        NamespaceService.getInstance().stripNamespace = true;
        NamespaceService.getInstance().namespaceStripProcessed = true;

        PermissionDefinitionMapper permissionDefinitionMapper = PermissionDefinitionMapper.getInstance();

        Permission_Definition__mdt permissionDefinition = permissionDefinitionMapper.getPermissionDefinitionList(
            '%'
        )[0];

        Test.startTest();
        SObjectFieldPermissionsDefinitionModel sObjectFieldPermissionsDefinitionModel = permissionDefinitionMapper.getSObjectFieldPermissionsDefinitionModel(
            permissionDefinition
        );
        Test.stopTest();

        String expectedApiName = NamespaceService.getInstance().handleLocalNamespace(permissionDefinition.Api_Name__c);

        String expectedApiSubname = NamespaceService.getInstance()
            .handleLocalNamespace(permissionDefinition.Api_Subname__c);

        System.assertEquals(
            permissionDefinition.Feature_Name__c,
            sObjectFieldPermissionsDefinitionModel.featureName,
            'Feature Name from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            expectedApiName,
            sObjectFieldPermissionsDefinitionModel.apiName,
            'Api Name from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            expectedApiSubname,
            sObjectFieldPermissionsDefinitionModel.apiSubName,
            'Api Subname from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            permissionDefinition.Read__c,
            sObjectFieldPermissionsDefinitionModel.readAccessRequired,
            'Read Access Required from Model should match that of Permission Definition.'
        );
        System.assertEquals(
            permissionDefinition.Update__c,
            sObjectFieldPermissionsDefinitionModel.updateAccessRequired,
            'Update Access Required from Model should match that of Permission Definition.'
        );
    }

    public virtual class PermissionDefinitionMapperStub extends PermissionDefinitionMapper {
        protected PermissionDefinitionMapperStub() {
        }

        @TestVisible
        private String metadataTypeToSet;

        protected override List<Permission_Definition__mdt> getPermissionDefinitionList(String featureName) {
            List<Permission_Definition__mdt> permissionDefinitionList = new List<Permission_Definition__mdt>();

            Permission_Definition__mdt permissionDefinition = new Permission_Definition__mdt();

            switch on this.metadataTypeToSet {
                when 'Apex Class' {
                    permissionDefinition.Api_Name__c = 'hed.testapiname';
                }
                when 'SObject' {
                    permissionDefinition.Api_Name__c = 'hed__testapiname';
                }
                when 'SObjectField' {
                    permissionDefinition.Api_Name__c = 'hed__testapiname';
                    permissionDefinition.Api_Subname__c = 'hed__testapisubname';
                }
            }

            permissionDefinition.Feature_Name__c = 'testFeatureName';
            permissionDefinition.Create__c = true;
            permissionDefinition.Read__c = true;
            permissionDefinition.Update__c = true;
            permissionDefinition.Delete__c = true;
            permissionDefinition.Metadata_Type__c = this.metadataTypeToSet;

            permissionDefinitionList.add(permissionDefinition);

            return permissionDefinitionList;
        }
    }
}
