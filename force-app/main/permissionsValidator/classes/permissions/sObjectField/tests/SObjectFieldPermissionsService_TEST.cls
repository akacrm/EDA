@isTest
private class SObjectFieldPermissionsService_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        SObjectFieldPermissionsService sObjectFieldPermissionsServiceInstance = SObjectFieldPermissionsService.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, sObjectFieldPermissionsServiceinstance, 'Service instance should not be null.');
        System.assertEquals(
            SObjectFieldPermissionsService.instance,
            sObjectFieldPermissionsServiceinstance,
            'Service instance should equal the apex class service instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        SObjectFieldPermissionsService sObjectFieldPermissionsServiceInstance = SObjectFieldPermissionsService.getInstance();

        Test.startTest();
        SObjectFieldPermissionsService sObjectFieldPermissionsServiceGetInstance = SObjectFieldPermissionsService.instance;
        Test.stopTest();

        System.assertEquals(
            sObjectFieldPermissionsServiceInstance,
            sObjectFieldPermissionsServiceGetInstance,
            'Retrieved Service instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getModelMapFromDefinitionLists() {
        SObjectFieldPermissionsService sObjectFieldPermissionsService = SObjectFieldPermissionsService.getInstance();
        SObjectFieldPermissionsMapper.instance = new SObjectFieldPermissionsMapperStub();

        Map<String, SObjectFieldPermissionsModel> expectedSObjectFieldPermissionsModelMap = SObjectFieldPermissionsMapper.getInstance()
            .getModelMapFromDefinitionLists(
                new List<Id>{ Id.valueOf('000000000000000000') },
                new List<String>{ 'Account.AccountNumber' }
            );

        Test.startTest();
        Map<String, SObjectFieldPermissionsModel> sObjectFieldPermissionsModelMap = sObjectFieldPermissionsService.getModelMapFromDefinitionLists(
            new List<Id>{ Id.valueOf('000000000000000000') },
            new List<String>{ 'Account.AccountNumber' }
        );
        Test.stopTest();

        System.assertEquals(
            expectedSObjectFieldPermissionsModelMap.size(),
            sObjectFieldPermissionsModelMap.size(),
            'SObjectFieldPermissions Model Map size from the service should equal the size from the mapper.'
        );

        for (String name : expectedSObjectFieldPermissionsModelMap.keySet()) {
            SObjectFieldPermissionsModel expectedModel = expectedSObjectFieldPermissionsModelMap.get(name);
            SObjectFieldPermissionsModel model = sObjectFieldPermissionsModelMap.get(name);

            System.assertEquals(
                expectedModel.sObjectType,
                model.sObjectType,
                'Model\'s SObject Type from the service should equal Model\'s SObject Type from the mapper.'
            );
            System.assertEquals(
                expectedModel.name,
                model.name,
                'Model\'s SObject Type from the service should equal Model\'s SObject Type from the mapper.'
            );
            System.assertEquals(
                expectedModel.canRead,
                model.canRead,
                'Model\'s Can Read from the service should equal Model\'s Can Read from the mapper.'
            );
            System.assertEquals(
                expectedModel.canUpdate,
                model.canUpdate,
                'Model\'s Can Update from the service should equal Model\'s Can Update from the mapper.'
            );
        }
    }

    @isTest
    private static void locateSObjectFieldPermissionsMapper() {
        SObjectFieldPermissionsService sObjectFieldPermissionsService = SObjectFieldPermissionsService.getInstance();

        SObjectFieldPermissionsMapper expectedSObjectFieldPermissionsMapper = SObjectFieldPermissionsMapper.getInstance();

        Test.startTest();
        SObjectFieldPermissionsMapper sObjectFieldPermissionsMapper = sObjectFieldPermissionsService.locateSObjectFieldPermissionsMapper();
        Test.stopTest();

        System.assertEquals(
            expectedSObjectFieldPermissionsMapper,
            sObjectFieldPermissionsMapper,
            'The SObjectFieldPermissions Mapper located from the service should be that from mapper\'s instance method.'
        );
    }

    public virtual class SObjectFieldPermissionsMapperStub extends SObjectFieldPermissionsMapper {
        protected SObjectFieldPermissionsMapperStub() {
        }

        public override Map<String, SObjectFieldPermissionsModel> getModelMapFromDefinitionLists(
            List<Id> permissionSetIdList,
            List<String> nameList
        ) {
            Map<String, SObjectFieldPermissionsModel> sObjectFieldPermissionsModelMap = new Map<String, SObjectFieldPermissionsModel>();

            SObjectFieldPermissionsModel sObjectFieldPermissionsModel = new SObjectFieldPermissionsModel(
                'Account',
                'Account.AccountNumber',
                false,
                false
            );

            sObjectFieldPermissionsModelMap.put(sObjectFieldPermissionsModel.name, sObjectFieldPermissionsModel);

            return sObjectFieldPermissionsModelMap;
        }
    }
}
