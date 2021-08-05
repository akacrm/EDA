@isTest
private class PermissionsValidatorController_TEST {
    @isTest
    private static void getFeatureNames() {
        PermissionDefinitionService.instance = new PermissionDefinitionServiceStub();

        List<PermissionDefinitionModel> permissionDefinitionModelList = PermissionsValidatorController.locatePermissionDefinitionService()
            .getPermissionDefinitionModelListByFeatureName('%');
        List<String> expectedFeatureNameList = PermissionsValidatorController.locatePermissionDefinitionService()
            .getFeatureNamesFromModelList(permissionDefinitionModelList);

        Test.startTest();
        List<String> featureNameList = PermissionsValidatorController.getFeatureNames();
        Test.stopTest();

        System.assertEquals(
            expectedFeatureNameList.size(),
            featureNameList.size(),
            'Size of feature name list from service should equal that of the controller\'s.'
        );

        for (Integer i = 0; i < expectedFeatureNameList.size(); i++) {
            System.assertEquals(
                expectedFeatureNameList[i],
                featureNameList[i],
                'Feature name from controller should match the feature name in the same position from the service\'s list.'
            );
        }
    }

    @isTest
    private static void getFeatureNamesNoAccessException() {
        PermissionDefinitionService.instance = new PermissionDefinitionServiceNoAccessStub();

        try {
            Test.startTest();
            List<String> featureNameList = PermissionsValidatorController.getFeatureNames();
            Test.stopTest();

            System.assert(false, 'An aura handled exception should always be thrown on a caught exception.');
        } catch (AuraHandledException ahe) {
        }
    }

    @isTest
    private static void getFeatureNamesIllegalArgumentException() {
        PermissionDefinitionService.instance = new PermissionDefinitionServiceIlleglArgStub();

        try {
            Test.startTest();
            List<String> featureNameList = PermissionsValidatorController.getFeatureNames();
            Test.stopTest();

            System.assert(false, 'An aura handled exception should always be thrown on a caught exception.');
        } catch (AuraHandledException ahe) {
        }
    }

    @isTest
    private static void locatePermissionDefinitionService() {
        PermissionDefinitionService expectedPermissionDefinitionService = PermissionDefinitionService.getInstance();

        Test.startTest();
        PermissionDefinitionService permissionDefinitionService = PermissionsValidatorController.locatePermissionDefinitionService();
        Test.stopTest();

        System.assertEquals(
            expectedPermissionDefinitionService,
            permissionDefinitionService,
            'The Permission Definition Service located from the controller should be that from service\'s instance method.'
        );
    }

    public virtual class PermissionDefinitionServiceStub extends PermissionDefinitionService {
        protected PermissionDefinitionServiceStub() {
        }

        public override List<PermissionDefinitionModel> getPermissionDefinitionModelListByFeatureName(
            String featureName
        ) {
            List<PermissionDefinitionModel> permissionDefinitionModelList = new List<PermissionDefinitionModel>();

            SObjectPermissionsDefinitionModel sObjectPermissionsDefinitionModel = new SObjectPermissionsDefinitionModel(
                'testFeatureName',
                'testApiName',
                true,
                true,
                true,
                true
            );

            permissionDefinitionModelList.add(sObjectPermissionsDefinitionModel);

            return permissionDefinitionModelList;
        }
    }

    public virtual class PermissionDefinitionServiceNoAccessStub extends PermissionDefinitionService {
        protected PermissionDefinitionServiceNoAccessStub() {
        }

        public override List<PermissionDefinitionModel> getPermissionDefinitionModelListByFeatureName(
            String featureName
        ) {
            throw new NoAccessException();
        }
    }

    public virtual class PermissionDefinitionServiceIlleglArgStub extends PermissionDefinitionService {
        protected PermissionDefinitionServiceIlleglArgStub() {
        }

        public override List<PermissionDefinitionModel> getPermissionDefinitionModelListByFeatureName(
            String featureName
        ) {
            throw new IllegalArgumentException();
        }
    }
}
