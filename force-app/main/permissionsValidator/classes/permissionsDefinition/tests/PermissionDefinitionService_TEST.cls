@isTest
private class PermissionDefinitionService_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        PermissionDefinitionService permissionDefinitionServiceInstance = PermissionDefinitionService.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, permissionDefinitionServiceinstance, 'Service instance should not be null.');
        System.assertEquals(
            PermissionDefinitionService.instance,
            permissionDefinitionServiceinstance,
            'Service instance should equal the apex class service instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        PermissionDefinitionService permissionDefinitionServiceInstance = PermissionDefinitionService.getInstance();

        Test.startTest();
        PermissionDefinitionService permissionDefinitionServiceGetInstance = PermissionDefinitionService.instance;
        Test.stopTest();

        System.assertEquals(
            permissionDefinitionServiceInstance,
            permissionDefinitionServiceGetInstance,
            'Retrieved Service instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getPermissionDefinitionModelListByFeatureName() {
        PermissionDefinitionService permissionDefinitionService = PermissionDefinitionService.getInstance();

        PermissionDefinitionMapper.instance = new PermissionDefinitionMapperApexClassStub();

        List<PermissionDefinitionModel> expectedPermissionDefinitionModelList = PermissionDefinitionMapper.getInstance()
            .getPermissionDefinitionModelListByFeatureName('%');

        Test.startTest();
        List<PermissionDefinitionModel> permissionDefinitionModelList = permissionDefinitionService.getPermissionDefinitionModelListByFeatureName(
            '%'
        );
        Test.stopTest();

        System.assertEquals(
            expectedPermissionDefinitionModelList.size(),
            permissionDefinitionModelList.size(),
            'Size of list from the service should equal the size of the list from the mapper.'
        );

        for (Integer i = 0; i < expectedPermissionDefinitionModelList.size(); i++) {
            PermissionDefinitionModel expectedpermissionDefinitionModel = expectedPermissionDefinitionModelList[i];
            PermissionDefinitionModel permissionDefinitionModel = permissionDefinitionModelList[i];

            System.assertEquals(
                expectedpermissionDefinitionModel.featureName,
                permissionDefinitionModel.featureName,
                'Feature Name of the model from the service should equal that of the model from the mapper.'
            );
            System.assertEquals(
                expectedpermissionDefinitionModel.apiName,
                permissionDefinitionModel.apiName,
                'API Name of the model from the service should equal that of the model from the mapper.'
            );
            System.assertEquals(
                expectedpermissionDefinitionModel.readAccessRequired,
                permissionDefinitionModel.readAccessRequired,
                'Read Access Required of the model from the service should equal that of the model from the mapper.'
            );
        }
    }

    @isTest
    private static void getFeatureNamesFromModelList() {
        Integer numberOfModels = 3;

        PermissionDefinitionService.instance = new PermissionDefinitionServiceSObjectStub(numberOfModels);
        PermissionDefinitionService permissionDefinitionService = PermissionDefinitionService.getInstance();

        List<PermissionDefinitionModel> permissionDefinitionModelList = permissionDefinitionService.getPermissionDefinitionModelListByFeatureName(
            '%'
        );
        permissionDefinitionModelList.addAll(
            permissionDefinitionService.getPermissionDefinitionModelListByFeatureName('%')
        );

        Integer uniqueFeatureNames = numberOfModels;

        Test.startTest();
        List<String> featureNames = permissionDefinitionService.getFeatureNamesFromModelList(
            permissionDefinitionModelList
        );
        Test.stopTest();

        System.assertEquals(
            uniqueFeatureNames,
            featureNames.size(),
            'Size of feature names list should equal the expected number of unique feature names'
        );

        for (PermissionDefinitionModel permissionDefinitionModel : permissionDefinitionModelList) {
            System.assertEquals(
                true,
                featureNames.contains(permissionDefinitionModel.featureName),
                'Each feature name should be contained within the list.'
            );
        }
    }

    @isTest
    private static void getTypeStringCollectionByTypeFromModelListApexClass() {
        NamespaceService.getInstance().stripNamespace = false;
        NamespaceService.getInstance().namespaceStripProcessed = true;

        PermissionDefinitionService.instance = new PermissionDefinitionServiceApexClassStub();
        PermissionDefinitionService permissionDefinitionService = PermissionDefinitionService.getInstance();

        PermissionDefinitionMapper.instance = new PermissionDefinitionMapperApexClassStub();

        List<PermissionDefinitionModel> permissionDefinitionModelList = permissionDefinitionService.getPermissionDefinitionModelListByFeatureName(
            '%'
        );

        Test.startTest();
        Map<String, PermissionDefinitionService.TypeStringCollection> typeStringCollectionByType = permissionDefinitionService.getTypeStringCollectionByTypeFromModelList(
            permissionDefinitionModelList
        );
        Test.stopTest();

        PermissionDefinitionService.TypeStringCollection typeStringCollection = typeStringCollectionByType.get(
            'Apex Class'
        );

        System.assertNotEquals(
            null,
            typeStringCollection,
            'A type string collection should be retrieved for apex classes.'
        );
        System.assertEquals(
            1,
            typeStringCollection.namespacePrefixList.size(),
            'The size of the namespace prefix list should be 1.'
        );
        System.assertEquals(1, typeStringCollection.apiNameList.size(), 'The size of the api name list should be 1.');
        System.assertEquals(
            0,
            typeStringCollection.apiSubnameList.size(),
            'The size of the api subname list should be 0.'
        );
        System.assertEquals(
            'testNamespacePrefix',
            typeStringCollection.namespacePrefixList[0],
            'The first item in the namespace prefix list should match the specified value.'
        );
        System.assertEquals(
            'testApiName',
            typeStringCollection.apiNameList[0],
            'The first item in the api name list should match the specified value.'
        );
    }

    @isTest
    private static void getTypeStringCollectionByTypeFromModelListSObject() {
        NamespaceService.getInstance().stripNamespace = false;
        NamespaceService.getInstance().namespaceStripProcessed = true;

        PermissionDefinitionService.instance = new PermissionDefinitionServiceSObjectStub();
        PermissionDefinitionService permissionDefinitionService = PermissionDefinitionService.getInstance();

        PermissionDefinitionMapper.instance = new PermissionDefinitionMapperSObjectStub();

        List<PermissionDefinitionModel> permissionDefinitionModelList = permissionDefinitionService.getPermissionDefinitionModelListByFeatureName(
            '%'
        );

        Test.startTest();
        Map<String, PermissionDefinitionService.TypeStringCollection> typeStringCollectionByType = permissionDefinitionService.getTypeStringCollectionByTypeFromModelList(
            permissionDefinitionModelList
        );
        Test.stopTest();

        PermissionDefinitionService.TypeStringCollection typeStringCollection = typeStringCollectionByType.get(
            'SObject'
        );

        System.assertNotEquals(
            null,
            typeStringCollection,
            'A type string collection should be retrieved for SObjects.'
        );
        System.assertEquals(
            0,
            typeStringCollection.namespacePrefixList.size(),
            'The size of the namespace prefix list should be 0.'
        );
        System.assertEquals(1, typeStringCollection.apiNameList.size(), 'The size of the api name list should be 1.');
        System.assertEquals(
            0,
            typeStringCollection.apiSubnameList.size(),
            'The size of the api subname list should be 0.'
        );
        System.assertEquals(
            'testNamespacePrefix0__testApiName0',
            typeStringCollection.apiNameList[0],
            'The first item in the api name list should match the specified value.'
        );
    }

    @isTest
    private static void getTypeStringCollectionByTypeFromModelListSObjectField() {
        NamespaceService.getInstance().stripNamespace = false;
        NamespaceService.getInstance().namespaceStripProcessed = true;

        PermissionDefinitionService.instance = new PermissionDefinitionServSObjectFieldStub();
        PermissionDefinitionService permissionDefinitionService = PermissionDefinitionService.getInstance();

        PermissionDefinitionMapper.instance = new PermissionDefinitionMappSObjectFieldStub();

        List<PermissionDefinitionModel> permissionDefinitionModelList = permissionDefinitionService.getPermissionDefinitionModelListByFeatureName(
            '%'
        );

        Test.startTest();
        Map<String, PermissionDefinitionService.TypeStringCollection> typeStringCollectionByType = permissionDefinitionService.getTypeStringCollectionByTypeFromModelList(
            permissionDefinitionModelList
        );
        Test.stopTest();

        PermissionDefinitionService.TypeStringCollection typeStringCollection = typeStringCollectionByType.get(
            'SObjectField'
        );

        System.assertNotEquals(
            null,
            typeStringCollection,
            'A type string collection should be retrieved for SObject Fields.'
        );
        System.assertEquals(
            0,
            typeStringCollection.namespacePrefixList.size(),
            'The size of the namespace prefix list should be 0.'
        );
        System.assertEquals(1, typeStringCollection.apiNameList.size(), 'The size of the api name list should be 1.');
        System.assertEquals(
            0,
            typeStringCollection.apiSubnameList.size(),
            'The size of the api subname list should be 0.'
        );
        System.assertEquals(
            'testNamespacePrefix__testApiName.testNamespacePrefix__testApiSubName',
            typeStringCollection.apiNameList[0],
            'The first item in the api name list should match the specified value.'
        );
    }

    @isTest
    private static void locatePermissionDefinitionMapper() {
        PermissionDefinitionService permissionDefinitionService = PermissionDefinitionService.getInstance();

        PermissionDefinitionMapper expectedPermissionDefinitionMapper = PermissionDefinitionMapper.getInstance();

        Test.startTest();
        PermissionDefinitionMapper permissionDefinitionMapper = permissionDefinitionService.locatePermissionDefinitionMapper();
        Test.stopTest();

        System.assertEquals(
            expectedPermissionDefinitionMapper,
            permissionDefinitionMapper,
            'The Permission Definition Mapper located from the service should be that from mapper\'s instance method.'
        );
    }

    public virtual class PermissionDefinitionMapperApexClassStub extends PermissionDefinitionMapper {
        protected PermissionDefinitionMapperApexClassStub() {
        }

        public override List<PermissionDefinitionModel> getPermissionDefinitionModelListByFeatureName(
            String featureName
        ) {
            List<PermissionDefinitionModel> permissionDefinitionModelList = new List<PermissionDefinitionModel>();

            ApexClassPermDefinitionModel apexClassPermDefinitionModel = new ApexClassPermDefinitionModel(
                'testFeatureName',
                'testApiName',
                'testNamespacePrefix'
            );

            permissionDefinitionModelList.add(apexClassPermDefinitionModel);
            return permissionDefinitionModelList;
        }
    }

    public virtual class PermissionDefinitionServiceApexClassStub extends PermissionDefinitionService {
        protected PermissionDefinitionServiceApexClassStub() {
        }

        public override List<PermissionDefinitionModel> getPermissionDefinitionModelListByFeatureName(
            String featureName
        ) {
            List<PermissionDefinitionModel> permissionDefinitionModelList = new List<PermissionDefinitionModel>();

            ApexClassPermDefinitionModel apexClassPermDefinitionModel = new ApexClassPermDefinitionModel(
                'testFeatureName',
                'testApiName',
                'testNamespacePrefix'
            );

            permissionDefinitionModelList.add(apexClassPermDefinitionModel);
            return permissionDefinitionModelList;
        }
    }

    public virtual class PermissionDefinitionMapperSObjectStub extends PermissionDefinitionMapper {
        protected PermissionDefinitionMapperSObjectStub() {
        }

        public override List<PermissionDefinitionModel> getPermissionDefinitionModelListByFeatureName(
            String featureName
        ) {
            List<PermissionDefinitionModel> permissionDefinitionModelList = new List<PermissionDefinitionModel>();

            SObjectPermissionsDefinitionModel sObjectPermissionsDefinitionModel = new SObjectPermissionsDefinitionModel(
                'testNamespacePrefix__testFeatureName',
                'testNamespacePrefix__testApiName',
                true,
                true,
                true,
                true
            );

            permissionDefinitionModelList.add(sObjectPermissionsDefinitionModel);
            return permissionDefinitionModelList;
        }
    }

    public virtual class PermissionDefinitionServiceSObjectStub extends PermissionDefinitionService {
        protected PermissionDefinitionServiceSObjectStub() {
        }

        public PermissionDefinitionServiceSObjectStub(Integer numberOfModels) {
            this.numberOfModels = numberOfModels;
        }

        @TestVisible
        private Integer numberOfModels = 1;

        public override List<PermissionDefinitionModel> getPermissionDefinitionModelListByFeatureName(
            String featureName
        ) {
            List<PermissionDefinitionModel> permissionDefinitionModelList = new List<PermissionDefinitionModel>();

            for (Integer i = 0; i < this.numberOfModels; i++) {
                SObjectPermissionsDefinitionModel sObjectPermissionsDefinitionModel = new SObjectPermissionsDefinitionModel(
                    'testNamespacePrefix' +
                    i +
                    '__testFeatureName' +
                    i,
                    'testNamespacePrefix' +
                    i +
                    '__testApiName' +
                    i,
                    true,
                    true,
                    true,
                    true
                );

                permissionDefinitionModelList.add(sObjectPermissionsDefinitionModel);
            }

            return permissionDefinitionModelList;
        }
    }

    public virtual class PermissionDefinitionMappSObjectFieldStub extends PermissionDefinitionMapper {
        protected PermissionDefinitionMappSObjectFieldStub() {
        }

        public override List<PermissionDefinitionModel> getPermissionDefinitionModelListByFeatureName(
            String featureName
        ) {
            List<PermissionDefinitionModel> permissionDefinitionModelList = new List<PermissionDefinitionModel>();

            SObjectFieldPermissionsDefinitionModel sObjectFieldPermissionsDefinitionModel = new SObjectFieldPermissionsDefinitionModel(
                'testFeatureName',
                'testNamespacePrefix__testApiName',
                'testNamespacePrefix__testApiSubName',
                true,
                true
            );

            permissionDefinitionModelList.add(sObjectFieldPermissionsDefinitionModel);
            return permissionDefinitionModelList;
        }
    }

    public virtual class PermissionDefinitionServSObjectFieldStub extends PermissionDefinitionService {
        protected PermissionDefinitionServSObjectFieldStub() {
        }

        public override List<PermissionDefinitionModel> getPermissionDefinitionModelListByFeatureName(
            String featureName
        ) {
            List<PermissionDefinitionModel> permissionDefinitionModelList = new List<PermissionDefinitionModel>();

            SObjectFieldPermissionsDefinitionModel sObjectFieldPermissionsDefinitionModel = new SObjectFieldPermissionsDefinitionModel(
                'testFeatureName',
                'testNamespacePrefix__testApiName',
                'testNamespacePrefix__testApiSubName',
                true,
                true
            );

            permissionDefinitionModelList.add(sObjectFieldPermissionsDefinitionModel);
            return permissionDefinitionModelList;
        }
    }
}
