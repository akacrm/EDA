@isTest
private class PermissionSetSelectorController_TEST {
    @isTest
    private static void getViewModel() {
        PermissionSetSelectorVMapper.instance = new PermissionSetSelectorVMapperStub();

        PermissionSetSelectorVModel expectedPermissionSetSelectorVModel = PermissionSetSelectorVMapper.getInstance()
            .getViewModel();

        Test.startTest();
        PermissionSetSelectorVModel permissionSetSelectorVModel = PermissionSetSelectorController.getViewModel();
        Test.stopTest();

        System.assertEquals(
            expectedPermissionSetSelectorVModel.permissionSetViewModelList.size(),
            permissionSetSelectorVModel.permissionSetViewModelList.size(),
            'The Permission Set Selector View Model\'s Permission Set View Model List size should be equal to that of the mapper\'s.'
        );
    }

    @isTest
    private static void getViewModelAuraException() {
        PermissionSetSelectorVMapper.instance = new PermissionSetSelectorVMapperErrorStub();

        try {
            Test.startTest();
            PermissionSetSelectorVModel permissionSetSelectorVModel = PermissionSetSelectorController.getViewModel();
            Test.stopTest();

            System.assert(false, 'An aura handled exception should always be thrown on a caught exception.');
        } catch (AuraHandledException ahe) {
        }
    }

    @isTest
    private static void locatePermissionSetSelectorVMapper() {
        PermissionSetSelectorVMapper expectedPermissionSetSelectorVMapper = PermissionSetSelectorVMapper.getInstance();

        Test.startTest();
        PermissionSetSelectorVMapper permissionSetSelectorVMapper = PermissionSetSelectorController.locatePermissionSetSelectorVMapper();
        Test.stopTest();

        System.assertEquals(
            expectedPermissionSetSelectorVMapper,
            permissionSetSelectorVMapper,
            'The Permission Set Selector View Model Mapper located from the controller should be that from mappers\'s instance method.'
        );
    }

    public virtual class PermissionSetSelectorVMapperStub extends PermissionSetSelectorVMapper {
        protected PermissionSetSelectorVMapperStub() {
        }

        public override PermissionSetSelectorVModel getViewModel() {
            List<PermissionSetVModel> permissionSetVModelList = new List<PermissionSetVModel>();

            PermissionSetSelectorVModel permissionSetSelectorVModel = new PermissionSetSelectorVModel(
                permissionSetVModelList
            );

            return permissionSetSelectorVModel;
        }
    }

    public virtual class PermissionSetSelectorVMapperErrorStub extends PermissionSetSelectorVMapper {
        protected PermissionSetSelectorVMapperErrorStub() {
        }

        public override PermissionSetSelectorVModel getViewModel() {
            throw new NoAccessException();
        }
    }
}
