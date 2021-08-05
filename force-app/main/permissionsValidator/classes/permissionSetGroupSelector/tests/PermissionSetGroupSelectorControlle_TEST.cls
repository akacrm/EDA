@isTest
private class PermissionSetGroupSelectorControlle_TEST {
    @isTest
    private static void getViewModel() {
        PermissionSetGroupSelectorVMapper.instance = new PermissionSetGroupSelectorVMapperStub();

        PermissionSetGroupSelectorVModel expectedPermissionSetGroupSelectorVModel = PermissionSetGroupSelectorVMapper.getInstance()
            .getViewModel();

        Test.startTest();
        PermissionSetGroupSelectorVModel permissionSetGroupSelectorVModel = PermissionSetGroupSelectorController.getViewModel();
        Test.stopTest();

        System.assertEquals(
            expectedPermissionSetGroupSelectorVModel.permissionSetGroupViewModelList.size(),
            permissionSetGroupSelectorVModel.permissionSetGroupViewModelList.size(),
            'The Permission Set Group Selector View Model\'s Permission Set Group View Model List size should be equal to that of the mapper\'s.'
        );
    }

    @isTest
    private static void getViewModelAuraException() {
        PermissionSetGroupSelectorVMapper.instance = new PermissionSetGroupSelectorVMapperErrorStub();

        try {
            Test.startTest();
            PermissionSetGroupSelectorVModel permissionSetGroupSelectorVModel = PermissionSetGroupSelectorController.getViewModel();
            Test.stopTest();

            System.assert(false, 'An aura handled exception should always be thrown on a caught exception.');
        } catch (AuraHandledException ahe) {
        }
    }

    @isTest
    private static void locatePermissionSetGroupSelectorVMapper() {
        PermissionSetGroupSelectorVMapper expectedPermissionSetGroupSelectorVMapper = PermissionSetGroupSelectorVMapper.getInstance();

        Test.startTest();
        PermissionSetGroupSelectorVMapper permissionSetGroupSelectorVMapper = PermissionSetGroupSelectorController.locatePermissionSetGroupSelectorVMapper();
        Test.stopTest();

        System.assertEquals(
            expectedPermissionSetGroupSelectorVMapper,
            permissionSetGroupSelectorVMapper,
            'The Permission Set Group Selector View Model Mapper located from the controller should be that from mappers\'s instance method.'
        );
    }

    public virtual class PermissionSetGroupSelectorVMapperStub extends PermissionSetGroupSelectorVMapper {
        protected PermissionSetGroupSelectorVMapperStub() {
        }

        public override PermissionSetGroupSelectorVModel getViewModel() {
            List<PermissionSetGroupVModel> permissionSetGroupVModelList = new List<PermissionSetGroupVModel>();

            PermissionSetGroupSelectorVModel permissionSetGroupSelectorVModel = new PermissionSetGroupSelectorVModel(
                permissionSetGroupVModelList
            );

            return permissionSetGroupSelectorVModel;
        }
    }

    public virtual class PermissionSetGroupSelectorVMapperErrorStub extends PermissionSetGroupSelectorVMapper {
        protected PermissionSetGroupSelectorVMapperErrorStub() {
        }

        public override PermissionSetGroupSelectorVModel getViewModel() {
            throw new NoAccessException();
        }
    }
}
