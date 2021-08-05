@isTest
private class PermissionSetGroupSelectorVMapper_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        PermissionSetGroupSelectorVMapper permissionSetGroupSelectorVMapperinstance = PermissionSetGroupSelectorVMapper.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, permissionSetGroupSelectorVMapperinstance, 'Mapper instance should not be null.');
        System.assertEquals(
            PermissionSetGroupSelectorVMapper.instance,
            permissionSetGroupSelectorVMapperinstance,
            'Mapper instance should equal the apex class mapper instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        PermissionSetGroupSelectorVMapper permissionSetGroupSelectorVMapperInstance = PermissionSetGroupSelectorVMapper.getInstance();

        Test.startTest();
        PermissionSetGroupSelectorVMapper permissionSetGroupSelectorVMapperGetInstance = PermissionSetGroupSelectorVMapper.instance;
        Test.stopTest();

        System.assertEquals(
            permissionSetGroupSelectorVMapperInstance,
            permissionSetGroupSelectorVMapperGetInstance,
            'Retrieved Mapper instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getViewModel() {
        PermissionSetGroupSelectorVMapper permissionSetGroupSelectorVMapper = PermissionSetGroupSelectorVMapper.getInstance();

        PermissionSetGroupService.instance = new PermissionSetGroupServiceStub();

        List<PermissionSetGroupModel> permissionSetGroupModelList = PermissionSetGroupService.getInstance()
            .getPermissionSetGroupModels();

        Test.startTest();
        PermissionSetGroupSelectorVModel permissionSetGroupSelectorVModel = permissionSetGroupSelectorVMapper.getViewModel();
        Test.stopTest();

        List<PermissionSetGroupVModel> permissionSetGroupViewModelList = permissionSetGroupSelectorVModel.permissionSetGroupViewModelList;

        System.assertEquals(
            permissionSetGroupModelList.size(),
            permissionSetGroupViewModelList.size(),
            'PermissionSetGroup View Model List size from the mapper should equal the size from the service.'
        );

        for (Integer i = 0; i < permissionSetGroupViewModelList.size(); i++) {
            System.assertEquals(
                permissionSetGroupModelList[i].permissionSetGroupId,
                permissionSetGroupViewModelList[i].value,
                'PermissionSetGroup View Model Value from the mapper should equal the PermissionSetGroup Model Id from the service.'
            );

            System.assertEquals(
                permissionSetGroupModelList[i].label,
                permissionSetGroupViewModelList[i].label,
                'PermissionSetGroup View Model Label from the mapper should equal the PermissionSetGroup Model Name from the service.'
            );
        }
    }

    @isTest
    private static void getPermissionSetGroupVModelListFromModels() {
        PermissionSetGroupSelectorVMapper permissionSetGroupSelectorVMapper = PermissionSetGroupSelectorVMapper.getInstance();

        List<PermissionSetGroupModel> permissionSetGroupModelList = new List<PermissionSetGroupModel>();

        PermissionSetGroupModel permissionSetGroupModel = new PermissionSetGroupModel('000000000000000000', 'test');

        permissionSetGroupModelList.add(permissionSetGroupModel);

        Test.startTest();
        List<PermissionSetGroupVModel> permissionSetGroupViewModelList = permissionSetGroupSelectorVMapper.getPermissionSetGroupVModelListFromModels(
            permissionSetGroupModelList
        );
        Test.stopTest();

        System.assertEquals(
            permissionSetGroupModelList.size(),
            permissionSetGroupViewModelList.size(),
            'Permission Set Group View Model List size from the mapper should equal the size of the model list passed to it.'
        );

        for (Integer i = 0; i < permissionSetGroupViewModelList.size(); i++) {
            System.assertEquals(
                permissionSetGroupModelList[i].permissionSetGroupId,
                permissionSetGroupViewModelList[i].value,
                'Permission Set Group View Model Value from the mapper should equal the Permission Set Group Model Id from the model passed to it.'
            );

            System.assertEquals(
                permissionSetGroupModelList[i].label,
                permissionSetGroupViewModelList[i].label,
                'Permission Set Group View Model Label from the mapper should equal the Permission Set Group Model Name from the model passed to it.'
            );
        }
    }

    @isTest
    private static void locatePermissionSetGroupService() {
        PermissionSetGroupSelectorVMapper permissionSetGroupSelectorVMapper = PermissionSetGroupSelectorVMapper.getInstance();

        PermissionSetGroupService expectedPermissionSetGroupService = PermissionSetGroupService.getInstance();

        Test.startTest();
        PermissionSetGroupService permissionSetGroupService = permissionSetGroupSelectorVMapper.locatePermissionSetGroupService();
        Test.stopTest();

        System.assertEquals(
            expectedPermissionSetGroupService,
            permissionSetGroupService,
            'The Permission Set Group Service located from the mapper should be that from service\'s instance method.'
        );
    }

    public virtual class PermissionSetGroupServiceStub extends PermissionSetGroupService {
        protected PermissionSetGroupServiceStub() {
        }

        public override List<PermissionSetGroupModel> getPermissionSetGroupModels() {
            List<PermissionSetGroupModel> permissionSetGroupModelList = new List<PermissionSetGroupModel>();

            PermissionSetGroupModel permissionSetGroupModel = new PermissionSetGroupModel('000000000000000000', 'test');

            permissionSetGroupModelList.add(permissionSetGroupModel);

            return permissionSetGroupModelList;
        }
    }
}
