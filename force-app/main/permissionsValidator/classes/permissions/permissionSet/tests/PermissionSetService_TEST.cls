@isTest
private class PermissionSetService_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        PermissionSetService permissionSetServiceInstance = PermissionSetService.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, permissionSetServiceinstance, 'Service instance should not be null.');
        System.assertEquals(
            PermissionSetService.instance,
            permissionSetServiceinstance,
            'Service instance should equal the apex class service instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        PermissionSetService permissionSetServiceInstance = PermissionSetService.getInstance();

        Test.startTest();
        PermissionSetService permissionSetServiceGetInstance = PermissionSetService.instance;
        Test.stopTest();

        System.assertEquals(
            permissionSetServiceInstance,
            permissionSetServiceGetInstance,
            'Retrieved Service instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getPermissionSetModels() {
        PermissionSetMapper.instance = new PermissionSetMapperStub();
        PermissionSetService permissionSetService = PermissionSetService.getInstance();

        List<PermissionSetModel> expectedPermissionSetModelList = PermissionSetMapper.getInstance()
            .getPermissionSetModels();

        Test.startTest();
        List<PermissionSetModel> permissionSetModelList = permissionSetService.getPermissionSetModels();
        Test.stopTest();

        Map<Id, PermissionSetModel> permissionSetModelById = new Map<Id, PermissionSetModel>();

        for (PermissionSetModel permissionSetModel : PermissionSetModelList) {
            permissionSetModelById.put(permissionSetModel.permissionSetId, permissionSetModel);
        }

        System.assertEquals(
            expectedPermissionSetModelList.size(),
            permissionSetModelList.size(),
            'The Permission Set Model List\'s size from the service should equal that of the Permission Set List\'s from the mapper.'
        );

        for (PermissionSetModel expectedPermissionSetModel : expectedPermissionSetModelList) {
            PermissionSetModel permissionSetModel = permissionSetModelById.get(
                expectedPermissionSetModel.permissionSetId
            );

            System.assertEquals(
                expectedPermissionSetModel.permissionSetId,
                permissionSetModel.permissionSetId,
                'The Permission Set Model\'s Id from the service should match the Permission Set Model\'s Id from the mapper.'
            );

            System.assertEquals(
                expectedPermissionSetModel.name,
                permissionSetModel.name,
                'The Permission Set Model\'s name from the service should match the Permission Set Model\'s name from the mapper.'
            );

            System.assertEquals(
                expectedPermissionSetModel.label,
                permissionSetModel.label,
                'The Permission Set Model\'s label from the service should match the Permission Set Model\'s label from the mapper.'
            );
        }
    }

    @isTest
    private static void getModelFromProfileId() {
        PermissionSetService permissionSetService = PermissionSetService.getInstance();

        PermissionSetMapper.instance = new PermissionSetMapperStub();

        PermissionSetModel expectedPermissionSetModel = PermissionSetMapper.getInstance()
            .getModelFromProfileId(Id.valueOf('000000000000000000'));

        Test.startTest();
        PermissionSetModel permissionSetModel = permissionSetService.getModelFromProfileId(
            Id.valueOf('000000000000000000')
        );
        Test.stopTest();

        System.assertEquals(
            expectedPermissionSetModel.permissionSetId,
            permissionSetModel.permissionSetId,
            'Permission Set Id from the service should equal the Permission Set Id from the mapper.'
        );

        System.assertEquals(
            expectedPermissionSetModel.name,
            permissionSetModel.name,
            'Permission Set Name from the service should equal the Permission Set Name from the mapper.'
        );

        System.assertEquals(
            expectedPermissionSetModel.label,
            permissionSetModel.label,
            'Permission Set Label from the service should equal the Permission Set Label from the mapper.'
        );
    }

    @isTest
    private static void getModelsFromPermissionSetGroupIdList() {
        PermissionSetMapper.instance = new PermissionSetMapperStub();
        PermissionSetService permissionSetService = PermissionSetService.getInstance();

        List<Id> permissionSetGroupIds = new List<Id>{ Id.valueOf('000000000000000000') };

        Map<Id, PermissionSetModel> expectedPermissionSetModelById = PermissionSetMapper.getInstance()
            .getModelsFromPermissionSetGroupIdList(permissionSetGroupIds);

        Test.startTest();
        Map<Id, PermissionSetModel> permissionSetModelById = permissionSetService.getModelsFromPermissionSetGroupIdList(
            permissionSetGroupIds
        );
        Test.stopTest();

        System.assertEquals(
            expectedPermissionSetModelById.size(),
            permissionSetModelById.size(),
            'The Permission Set Model Map\'s size from the service should equal that of the Permission Set Map\'s from the mapper.'
        );

        for (Id permissionSetModelId : expectedPermissionSetModelById.keySet()) {
            PermissionSetModel expectedPermissionSetModel = expectedPermissionSetModelById.get(permissionSetModelId);
            PermissionSetModel permissionSetModel = permissionSetModelById.get(permissionSetModelId);

            System.assertEquals(
                expectedPermissionSetModel.permissionSetId,
                permissionSetModel.permissionSetId,
                'The Permission Set Model\'s Id from the service should match the Permission Set Model\'s Id from the mapper.'
            );

            System.assertEquals(
                expectedPermissionSetModel.name,
                permissionSetModel.name,
                'The Permission Set Model\'s name from the service should match the Permission Set Model\'s name from the mapper.'
            );

            System.assertEquals(
                expectedPermissionSetModel.label,
                permissionSetModel.label,
                'The Permission Set Model\'s label from the service should match the Permission Set Model\'s label from the mapper.'
            );
        }
    }

    @isTest
    private static void getCombinedPermissionSetIdList() {
        PermissionSetMapper.instance = new PermissionSetMapperStub();
        PermissionSetService permissionSetService = PermissionSetService.getInstance();

        Id profileId = Id.valueOf('000000000000000000');
        List<Id> permissionSetGroupIdList = new List<Id>{ Id.valueOf('000000000000000001') };

        Test.startTest();
        List<Id> permissionSetIdList = permissionSetService.getCombinedPermissionSetIdList(
            profileId,
            new List<Id>(),
            permissionSetGroupIdList
        );
        Test.stopTest();

        System.assertEquals(
            2,
            permissionSetIdList.size(),
            'Permission Set Id List from combined sources should equal the expected value.'
        );
        System.assertEquals(
            true,
            permissionSetIdList.contains(profileId),
            'Permission Set Id List should contain expected Permission Set Id for the profile.'
        );
        System.assertEquals(
            true,
            permissionSetIdList.contains(permissionSetGroupIdList[0]),
            'Permission Set Id List should contain expected Permission Set Id for the Permission Set Groups.'
        );
    }

    @isTest
    private static void locatePermissionSetMapper() {
        PermissionSetService permissionSetService = PermissionSetService.getInstance();

        PermissionSetMapper expectedPermissionSetMapper = PermissionSetMapper.getInstance();

        Test.startTest();
        PermissionSetMapper permissionSetMapper = permissionSetService.locatePermissionSetMapper();
        Test.stopTest();

        System.assertEquals(
            expectedPermissionSetMapper,
            permissionSetMapper,
            'The Permission Set Mapper located from the service should be that from mapper\'s instance method.'
        );
    }

    public virtual class PermissionSetMapperStub extends PermissionSetMapper {
        protected PermissionSetMapperStub() {
        }

        public override List<PermissionSetModel> getPermissionSetModels() {
            List<PermissionSetModel> permissionSetModelList = new List<PermissionSetModel>();

            PermissionSetModel permissionSetModel = new PermissionSetModel(
                '000000000000000000',
                'testlabel',
                'testname'
            );

            permissionSetModelList.add(permissionSetModel);

            return permissionSetModelList;
        }

        public override PermissionSetModel getModelFromProfileId(Id profileId) {
            PermissionSetModel permissionSetModel = new PermissionSetModel(profileId, 'testlabel', 'testname');

            return permissionSetModel;
        }

        public override Map<Id, PermissionSetModel> getModelsFromPermissionSetGroupIdList(
            List<Id> permissionSetGroupIds
        ) {
            Map<Id, PermissionSetModel> permissionSetModelById = new Map<Id, PermissionSetModel>();

            for (Id permissionSetGroupId : permissionSetGroupIds) {
                PermissionSetModel permissionSetModel = new PermissionSetModel(
                    permissionSetGroupId,
                    'testlabel' + permissionSetGroupId,
                    'testname' + permissionSetGroupId
                );

                permissionSetModelById.put(permissionSetModel.permissionSetId, permissionSetModel);
            }

            return permissionSetModelById;
        }
    }
}
