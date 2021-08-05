@isTest
private class PermissionSetMapper_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        PermissionSetMapper permissionSetMapperinstance = PermissionSetMapper.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, permissionSetMapperinstance, 'Mapper instance should not be null.');
        System.assertEquals(
            PermissionSetMapper.instance,
            permissionSetMapperinstance,
            'Mapper instance should equal the apex class mapper instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        PermissionSetMapper permissionSetMapperInstance = PermissionSetMapper.getInstance();

        Test.startTest();
        PermissionSetMapper permissionSetMapperGetInstance = PermissionSetMapper.instance;
        Test.stopTest();

        System.assertEquals(
            permissionSetMapperInstance,
            permissionSetMapperGetInstance,
            'Retrieved Mapper instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getPermissionSetModels() {
        PermissionSetMapper permissionSetMapper = PermissionSetMapper.getInstance();

        Map<Id, PermissionSet> permissionSetById = new Map<Id, PermissionSet>(
            [SELECT Id, name, label FROM PermissionSet WHERE IsOwnedByProfile = FALSE AND PermissionSetGroupId = NULL]
        );

        Test.startTest();
        List<PermissionSetModel> permissionSetModelList = permissionSetMapper.getPermissionSetModels();
        Test.stopTest();

        Map<Id, PermissionSetModel> permissionSetModelById = new Map<Id, PermissionSetModel>();

        for (PermissionSetModel permissionSetModel : PermissionSetModelList) {
            permissionSetModelById.put(permissionSetModel.permissionSetId, permissionSetModel);
        }

        System.assertEquals(
            permissionSetById.size(),
            permissionSetModelList.size(),
            'The Permission Set Model List\'s size should equal that of the Permission Set List\'s.'
        );

        for (Id permissionSetId : permissionSetById.keySet()) {
            PermissionSet permissionSet = permissionSetById.get(permissionSetId);
            PermissionSetModel permissionSetModel = permissionSetModelById.get(permissionSetId);

            System.assertEquals(
                permissionSet.Id,
                permissionSetModel.permissionSetId,
                'The Permission Set Model\'s Id should match the Permission Set\'s Id'
            );

            System.assertEquals(
                permissionSet.name,
                permissionSetModel.name,
                'The Permission Set Model\'s name should match the Permission Set\'s name'
            );

            System.assertEquals(
                permissionSet.label,
                permissionSetModel.label,
                'The Permission Set Model\'s label should match the Permission Set\'s label'
            );
        }
    }

    @isTest
    private static void getModelFromProfileId() {
        PermissionSetMapper permissionSetMapper = PermissionSetMapper.getInstance();

        Profile arbitraryProfile = [
            SELECT Id, Name, Description
            FROM Profile
            WHERE UserType = 'Standard' AND PermissionsAuthorApex = TRUE
            LIMIT 1
        ];

        PermissionSet profilePermissionSet = [
            SELECT Id, name, label
            FROM PermissionSet
            WHERE IsOwnedByProfile = TRUE AND ProfileId = :arbitraryProfile.Id
            LIMIT 1
        ];

        Test.startTest();
        PermissionSetModel permissionSetModel = permissionSetMapper.getModelFromProfileId(arbitraryProfile.Id);
        Test.stopTest();

        System.assertNotEquals(null, permissionSetModel, 'A profile should always have an associated permission set.');

        System.assertEquals(
            profilePermissionSet.Id,
            permissionSetModel.permissionSetId,
            'The Permission Set Model\'s Id should match the Permission Set\'s Id'
        );

        System.assertEquals(
            profilePermissionSet.name,
            permissionSetModel.name,
            'The Permission Set Model\'s name should match the Permission Set\'s name'
        );

        System.assertEquals(
            profilePermissionSet.label,
            permissionSetModel.label,
            'The Permission Set Model\'s label should match the Permission Set\'s label'
        );
    }

    @isTest
    private static void getModelsFromPermissionSetGroupIdList() {
        PermissionSetMapper.instance = new PermissionSetMapperStub();
        PermissionSetMapper permissionSetMapper = PermissionSetMapper.getInstance();

        List<Id> permissionSetGroupIds = new List<Id>{ Id.valueOf('000000000000000000') };

        Map<Id, PermissionSet> permissionSetById = new Map<Id, PermissionSet>(
            permissionSetMapper.queryPermissionSetFromGroupIdList(permissionSetGroupIds)
        );

        Test.startTest();
        Map<Id, PermissionSetModel> permissionSetModelById = permissionSetMapper.getModelsFromPermissionSetGroupIdList(
            permissionSetGroupIds
        );
        Test.stopTest();

        System.assertEquals(
            permissionSetById.size(),
            permissionSetModelById.size(),
            'The Permission Set Model List\'s size should equal that of the Permission Set List\'s.'
        );

        for (Id permissionSetId : permissionSetById.keySet()) {
            PermissionSet permissionSet = permissionSetById.get(permissionSetId);
            PermissionSetModel permissionSetModel = permissionSetModelById.get(permissionSetId);

            System.assertEquals(
                permissionSet.Id,
                permissionSetModel.permissionSetId,
                'The Permission Set Model\'s Id should match the Permission Set\'s Id'
            );

            System.assertEquals(
                permissionSet.name,
                permissionSetModel.name,
                'The Permission Set Model\'s name should match the Permission Set\'s name'
            );

            System.assertEquals(
                permissionSet.label,
                permissionSetModel.label,
                'The Permission Set Model\'s label should match the Permission Set\'s label'
            );
        }
    }

    @isTest
    private static void queryPermissionSetFromGroupIdList() {
        PermissionSetMapper permissionSetMapper = PermissionSetMapper.getInstance();

        List<Id> permissionSetGroupIdList = new List<Id>{ Id.valueOf('000000000000000000') };

        Test.startTest();
        List<PermissionSet> permissionSetList = permissionSetMapper.queryPermissionSetFromGroupIdList(
            permissionSetGroupIdList
        );
        Test.stopTest();

        System.assertNotEquals(null, permissionSetList, 'The permission set list should not be null.');
    }

    public virtual class PermissionSetMapperStub extends PermissionSetMapper {
        protected PermissionSetMapperStub() {
        }

        @TestVisible
        protected override List<PermissionSet> queryPermissionSetFromGroupIdList(List<Id> permissionSetGroupIds) {
            return [SELECT Id, name, label FROM PermissionSet];
        }
    }

    /**************************************************************************************************************************
     * @description Test method to verify that the checkPermissionSetsWithCustomizeApplicationFromIds method returns true
     * if any provided permission set has access to view setup
     * TODO: Commented out because PermissionsManageTranslation failing beta builds and downstream packages.
     ***************************************************************************************************************************/
    /*@isTest
    private static void checkPermissionSetsWithCustomizeApplicationFromIdsTrue() {
        List<PermissionSet> permissionSets = new List<PermissionSet>();
        for (Integer i = 0; i < 5; i++) {
            PermissionSet permissionSet = new PermissionSet(
                PermissionsCustomizeApplication = false,
                Name = 'testName' + i,
                Label = 'testLabel' + i
            );
            permissionSets.add(permissionSet);
        }
        permissionSets[0].PermissionsViewSetup = true;
        permissionSets[0].PermissionsViewRoles = true;
        permissionSets[0].PermissionsManageCustomPermissions = true;
        permissionSets[0].PermissionsManageTranslation = true;
        permissionSets[0].PermissionsCustomizeApplication = true;
        insert permissionSets;

        Test.startTest();
        Set<Id> permissionSetIdsSet = new Set<Id>();
        for (PermissionSet permissionSet : permissionSets) {
            permissionSetIdsSet.add(permissionSet.Id);
        }
        Boolean permissionSetsWithCustomizeApplication = PermissionSetMapper.getInstance()
            .checkPermissionSetsWithCustomizeApplicationFromIds(permissionSetIdsSet);
        Test.stopTest();

        System.assertEquals(
            true,
            permissionSetsWithCustomizeApplication,
            'Some of the provided permission sets should have access to view setup'
        );
    }*/

    /**************************************************************************************************************************
     * @description Test method to verify that the checkPermissionSetsWithCustomizeApplicationFromIds method returns false
     * if no provided permission set has access to view setup
     ***************************************************************************************************************************/
    @isTest
    private static void checkPermissionSetsWithCustomizeApplicationFromIdsFalse() {
        List<PermissionSet> permissionSets = new List<PermissionSet>();
        for (Integer i = 0; i < 5; i++) {
            PermissionSet permissionSet = new PermissionSet(
                PermissionsCustomizeApplication = false,
                Name = 'testName' + i,
                Label = 'testLabel' + i
            );
            permissionSets.add(permissionSet);
        }
        insert permissionSets;

        Test.startTest();
        Set<Id> permissionSetIdsSet = new Set<Id>();
        for (PermissionSet permissionSet : permissionSets) {
            permissionSetIdsSet.add(permissionSet.Id);
        }
        Boolean permissionSetsWithCustomizeApplication = PermissionSetMapper.getInstance()
            .checkPermissionSetsWithCustomizeApplicationFromIds(permissionSetIdsSet);
        Test.stopTest();

        System.assertEquals(
            false,
            permissionSetsWithCustomizeApplication,
            'None of the provided permission sets should have access to view setup'
        );
    }
}
