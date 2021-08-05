@isTest
private class PermissionSetGroupMapper_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        PermissionSetGroupMapper permissionSetGroupMapperinstance = PermissionSetGroupMapper.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, permissionSetGroupMapperinstance, 'Mapper instance should not be null.');
        System.assertEquals(
            PermissionSetGroupMapper.instance,
            permissionSetGroupMapperinstance,
            'Mapper instance should equal the apex class mapper instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        PermissionSetGroupMapper permissionSetGroupMapperInstance = PermissionSetGroupMapper.getInstance();

        Test.startTest();
        PermissionSetGroupMapper permissionSetGroupMapperGetInstance = PermissionSetGroupMapper.instance;
        Test.stopTest();

        System.assertEquals(
            permissionSetGroupMapperInstance,
            permissionSetGroupMapperGetInstance,
            'Retrieved Mapper instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getPermissionSetGroupModels() {
        PermissionSetGroupMapper.instance = new PermissionSetGroupMapperStub();

        PermissionSetGroupMapper permissionSetGroupMapper = PermissionSetGroupMapper.getInstance();

        List<PermissionSetGroup> permissionSetGroupList = permissionSetGroupMapper.queryPermissionSetGroups();

        Test.startTest();
        List<PermissionSetGroupModel> permissionSetGroupModelList = permissionSetGroupMapper.getPermissionSetGroupModels();
        Test.stopTest();

        System.assertNotEquals(
            null,
            permissionSetGroupModelList,
            'The permission set group model list should not be null.'
        );

        PermissionSetGroup permissionSetGroup = permissionSetGroupList[0];
        PermissionSetGroupModel permissionSetGroupModel = permissionSetGroupModelList[0];

        System.assertEquals(
            permissionSetGroup.Id,
            permissionSetGroupModel.permissionSetGroupId,
            'The Permission Set Group Model\'s Id should match the Permission Set Group\'s Id'
        );

        System.assertEquals(
            permissionSetGroup.MasterLabel,
            permissionSetGroupModel.label,
            'The Permission Set Group Model\'s master label should match the Permission Set Group\'s master label'
        );
    }

    @isTest
    private static void queryPermissionSetGroups() {
        PermissionSetGroupMapper permissionSetGroupMapper = PermissionSetGroupMapper.getInstance();

        Test.startTest();
        List<PermissionSetGroup> permissionSetGroupList = permissionSetGroupMapper.queryPermissionSetGroups();
        Test.stopTest();

        System.assertNotEquals(null, permissionSetGroupList, 'The permission set group list should not be null.');
    }

    public virtual class PermissionSetGroupMapperStub extends PermissionSetGroupMapper {
        protected PermissionSetGroupMapperStub() {
        }

        @TestVisible
        protected override List<PermissionSetGroup> queryPermissionSetGroups() {
            List<PermissionSetGroup> permissionSetGroupList = new List<PermissionSetGroup>();

            PermissionSetGroup permissionSetGroup = new PermissionSetGroup(
                Id = Id.valueOf('0PG000000000000000'),
                MasterLabel = 'masterLabel'
            );

            permissionSetGroupList.add(permissionSetGroup);

            return permissionSetGroupList;
        }
    }
}
