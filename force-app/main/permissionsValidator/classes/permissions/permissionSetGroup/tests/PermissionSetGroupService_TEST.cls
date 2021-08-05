@isTest
private class PermissionSetGroupService_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        PermissionSetGroupService permissionSetGroupServiceInstance = PermissionSetGroupService.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, permissionSetGroupServiceinstance, 'Service instance should not be null.');
        System.assertEquals(
            PermissionSetGroupService.instance,
            permissionSetGroupServiceinstance,
            'Service instance should equal the apex class service instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        PermissionSetGroupService permissionSetGroupServiceInstance = PermissionSetGroupService.getInstance();

        Test.startTest();
        PermissionSetGroupService permissionSetGroupServiceGetInstance = PermissionSetGroupService.instance;
        Test.stopTest();

        System.assertEquals(
            permissionSetGroupServiceInstance,
            permissionSetGroupServiceGetInstance,
            'Retrieved Service instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getModelFromProfileId() {
        PermissionSetGroupService permissionSetGroupService = PermissionSetGroupService.getInstance();
        PermissionSetGroupMapper.instance = new PermissionSetGroupMapperStub();

        List<PermissionSetGroupModel> expectedPermissionSetGroupModelList = PermissionSetGroupMapper.getInstance()
            .getPermissionSetGroupModels();

        Test.startTest();
        List<PermissionSetGroupModel> permissionSetGroupModelList = permissionSetGroupService.getPermissionSetGroupModels();
        Test.stopTest();

        System.assertEquals(
            expectedPermissionSetGroupModelList.size(),
            permissionSetGroupModelList.size(),
            'Permission Set Group Model List size from the service should equal the size from the mapper.'
        );

        for (Integer i = 0; i < expectedPermissionSetGroupModelList.size(); i++) {
            PermissionSetGroupModel expectedPermissionSetGroupModel = expectedPermissionSetGroupModelList[i];
            PermissionSetGroupModel permissionSetGroupModel = permissionSetGroupModelList[i];

            System.assertEquals(
                expectedPermissionSetGroupModel.permissionSetGroupId,
                permissionSetGroupModel.permissionSetGroupId,
                'Permission Set Group Model Id from the service should equal the Permission Set Group Model Id from the mapper.'
            );

            System.assertEquals(
                expectedPermissionSetGroupModel.label,
                permissionSetGroupModel.label,
                'Permission Set Group Model Label from the service should equal the Permission Set Group Model Label from the mapper.'
            );
        }
    }

    @isTest
    private static void locatePermissionSetGroupMapper() {
        PermissionSetGroupService permissionSetGroupService = PermissionSetGroupService.getInstance();

        PermissionSetGroupMapper expectedPermissionSetGroupMapper = PermissionSetGroupMapper.getInstance();

        Test.startTest();
        PermissionSetGroupMapper permissionSetGroupMapper = permissionSetGroupService.locatePermissionSetGroupMapper();
        Test.stopTest();

        System.assertEquals(
            expectedPermissionSetGroupMapper,
            permissionSetGroupMapper,
            'The Permission Set Group Mapper located from the service should be that from mapper\'s instance method.'
        );
    }

    public virtual class PermissionSetGroupMapperStub extends PermissionSetGroupMapper {
        protected PermissionSetGroupMapperStub() {
        }

        public override List<PermissionSetGroupModel> getPermissionSetGroupModels() {
            List<PermissionSetGroupModel> permissionSetGroupModelList = new List<PermissionSetGroupModel>();

            PermissionSetGroupModel permissionSetGroupModel = new PermissionSetGroupModel(
                '000000000000000000',
                'masterLabel'
            );

            permissionSetGroupModelList.add(permissionSetGroupModel);

            return permissionSetGroupModelList;
        }
    }
}
