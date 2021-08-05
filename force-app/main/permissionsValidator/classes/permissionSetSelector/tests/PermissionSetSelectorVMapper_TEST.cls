@isTest
private class PermissionSetSelectorVMapper_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        PermissionSetSelectorVMapper permissionSetSelectorVMapperinstance = PermissionSetSelectorVMapper.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, permissionSetSelectorVMapperinstance, 'Mapper instance should not be null.');
        System.assertEquals(
            PermissionSetSelectorVMapper.instance,
            permissionSetSelectorVMapperinstance,
            'Mapper instance should equal the apex class mapper instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        PermissionSetSelectorVMapper permissionSetSelectorVMapperInstance = PermissionSetSelectorVMapper.getInstance();

        Test.startTest();
        PermissionSetSelectorVMapper permissionSetSelectorVMapperGetInstance = PermissionSetSelectorVMapper.instance;
        Test.stopTest();

        System.assertEquals(
            permissionSetSelectorVMapperInstance,
            permissionSetSelectorVMapperGetInstance,
            'Retrieved Mapper instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getViewModel() {
        PermissionSetSelectorVMapper permissionSetSelectorVMapper = PermissionSetSelectorVMapper.getInstance();

        PermissionSetService.instance = new PermissionSetServiceStub();

        List<PermissionSetModel> permissionSetModelList = PermissionSetService.getInstance().getPermissionSetModels();

        Test.startTest();
        PermissionSetSelectorVModel permissionSetSelectorVModel = permissionSetSelectorVMapper.getViewModel();
        Test.stopTest();

        List<PermissionSetVModel> permissionSetViewModelList = permissionSetSelectorVModel.permissionSetViewModelList;

        System.assertEquals(
            permissionSetModelList.size(),
            permissionSetViewModelList.size(),
            'PermissionSet View Model List size from the mapper should equal the size from the service.'
        );

        for (Integer i = 0; i < permissionSetViewModelList.size(); i++) {
            System.assertEquals(
                permissionSetModelList[i].permissionSetId,
                permissionSetViewModelList[i].value,
                'PermissionSet View Model Value from the mapper should equal the PermissionSet Model Id from the service.'
            );

            System.assertEquals(
                permissionSetModelList[i].name,
                permissionSetViewModelList[i].label,
                'PermissionSet View Model Label from the mapper should equal the PermissionSet Model Name from the service.'
            );
        }
    }

    @isTest
    private static void getPermissionSetVModelListFromModels() {
        PermissionSetSelectorVMapper permissionSetSelectorVMapper = PermissionSetSelectorVMapper.getInstance();

        List<PermissionSetModel> permissionSetModelList = new List<PermissionSetModel>();

        PermissionSetModel permissionSetModel = new PermissionSetModel('000000000000000000', 'test', 'test');

        permissionSetModelList.add(permissionSetModel);

        Test.startTest();
        List<PermissionSetVModel> permissionSetViewModelList = permissionSetSelectorVMapper.getPermissionSetVModelListFromModels(
            permissionSetModelList
        );
        Test.stopTest();

        System.assertEquals(
            permissionSetModelList.size(),
            permissionSetViewModelList.size(),
            'Permission Set View Model List size from the mapper should equal the size of the model list passed to it.'
        );

        for (Integer i = 0; i < permissionSetViewModelList.size(); i++) {
            System.assertEquals(
                permissionSetModelList[i].permissionSetId,
                permissionSetViewModelList[i].value,
                'Permission Set View Model Value from the mapper should equal the Permission Set Model Id from the model passed to it.'
            );

            System.assertEquals(
                permissionSetModelList[i].name,
                permissionSetViewModelList[i].label,
                'Permission Set View Model Label from the mapper should equal the Permission Set Model Name from the model passed to it.'
            );
        }
    }

    @isTest
    private static void locatePermissionSetService() {
        PermissionSetSelectorVMapper permissionSetSelectorVMapper = PermissionSetSelectorVMapper.getInstance();

        PermissionSetService expectedPermissionSetService = PermissionSetService.getInstance();

        Test.startTest();
        PermissionSetService permissionSetService = permissionSetSelectorVMapper.locatePermissionSetService();
        Test.stopTest();

        System.assertEquals(
            expectedPermissionSetService,
            permissionSetService,
            'The Permission Set Service located from the mapper should be that from service\'s instance method.'
        );
    }

    public virtual class PermissionSetServiceStub extends PermissionSetService {
        protected PermissionSetServiceStub() {
        }

        public override List<PermissionSetModel> getPermissionSetModels() {
            List<PermissionSetModel> permissionSetModelList = new List<PermissionSetModel>();

            PermissionSetModel permissionSetModel = new PermissionSetModel('000000000000000000', 'test', 'test');

            permissionSetModelList.add(permissionSetModel);

            return permissionSetModelList;
        }
    }
}
