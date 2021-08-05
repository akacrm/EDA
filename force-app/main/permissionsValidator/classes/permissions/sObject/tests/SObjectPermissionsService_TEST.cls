@isTest
private class SObjectPermissionsService_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        SObjectPermissionsService sObjectPermissionsServiceInstance = SObjectPermissionsService.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, sObjectPermissionsServiceinstance, 'Service instance should not be null.');
        System.assertEquals(
            SObjectPermissionsService.instance,
            sObjectPermissionsServiceinstance,
            'Service instance should equal the apex class service instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        SObjectPermissionsService sObjectPermissionsServiceInstance = SObjectPermissionsService.getInstance();

        Test.startTest();
        SObjectPermissionsService sObjectPermissionsServiceGetInstance = SObjectPermissionsService.instance;
        Test.stopTest();

        System.assertEquals(
            sObjectPermissionsServiceInstance,
            sObjectPermissionsServiceGetInstance,
            'Retrieved Service instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getModelMapFromPermissionSetIdListAndSObjectNameList() {
        SObjectPermissionsService sObjectPermissionsService = SObjectPermissionsService.getInstance();
        SObjectPermissionsMapper.instance = new SObjectPermissionsMapperStub();

        Map<String, SObjectPermissionsModel> expectedSObjectPermissionsModelMap = SObjectPermissionsMapper.getInstance()
            .getModelMapFromPermissionSetIdListAndSObjectNameList(
                new List<Id>{ Id.valueOf('000000000000000000') },
                new List<String>{ 'Account' }
            );

        Test.startTest();
        Map<String, SObjectPermissionsModel> sObjectPermissionsModelMap = sObjectPermissionsService.getModelMapFromPermissionSetIdListAndSObjectNameList(
            new List<Id>{ Id.valueOf('000000000000000000') },
            new List<String>{ 'Account' }
        );
        Test.stopTest();

        System.assertEquals(
            expectedSObjectPermissionsModelMap.size(),
            sObjectPermissionsModelMap.size(),
            'SObjectPermissions Model Map size from the service should equal the size from the mapper.'
        );

        for (String sObjectType : expectedSObjectPermissionsModelMap.keySet()) {
            SObjectPermissionsModel expectedModel = expectedSObjectPermissionsModelMap.get(sObjectType);
            SObjectPermissionsModel model = sObjectPermissionsModelMap.get(sObjectType);

            System.assertEquals(
                expectedModel.sObjectType,
                model.sObjectType,
                'Model\'s SObject Type from the service should equal Model\'s SObject Type from the mapper.'
            );
            System.assertEquals(
                expectedModel.canCreate,
                model.canCreate,
                'Model\'s Can Create from the service should equal Model\'s Can Create from the mapper.'
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
            System.assertEquals(
                expectedModel.canDelete,
                model.canDelete,
                'Model\'s Can Delete from the service should equal Model\'s Can Delete from the mapper.'
            );
        }
    }

    @isTest
    private static void locateSObjectPermissionsMapper() {
        SObjectPermissionsService sObjectPermissionsService = SObjectPermissionsService.getInstance();

        SObjectPermissionsMapper expectedSObjectPermissionsMapper = SObjectPermissionsMapper.getInstance();

        Test.startTest();
        SObjectPermissionsMapper sObjectPermissionsMapper = sObjectPermissionsService.locateSObjectPermissionsMapper();
        Test.stopTest();

        System.assertEquals(
            expectedSObjectPermissionsMapper,
            sObjectPermissionsMapper,
            'The SObjectPermissions Mapper located from the service should be that from mapper\'s instance method.'
        );
    }

    public virtual class SObjectPermissionsMapperStub extends SObjectPermissionsMapper {
        protected SObjectPermissionsMapperStub() {
        }

        public override Map<String, SObjectPermissionsModel> getModelMapFromPermissionSetIdListAndSObjectNameList(
            List<Id> permissionSetIdList,
            List<String> sObjectTypeList
        ) {
            Map<String, SObjectPermissionsModel> sObjectPermissionsModelMap = new Map<String, SObjectPermissionsModel>();

            SObjectPermissionsModel sObjectPermissionsModel = new SObjectPermissionsModel(
                'Account',
                false,
                false,
                false,
                false
            );

            sObjectPermissionsModelMap.put(sObjectPermissionsModel.sObjectType, sObjectPermissionsModel);

            return sObjectPermissionsModelMap;
        }
    }
}
