@isTest
private class SObjectPermissionsMapper_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        SObjectPermissionsMapper sObjectPermissionsMapperinstance = SObjectPermissionsMapper.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, sObjectPermissionsMapperinstance, 'Mapper instance should not be null.');
        System.assertEquals(
            SObjectPermissionsMapper.instance,
            sObjectPermissionsMapperinstance,
            'Mapper instance should equal the apex class mapper instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        SObjectPermissionsMapper sObjectPermissionsMapperInstance = SObjectPermissionsMapper.getInstance();

        Test.startTest();
        SObjectPermissionsMapper sObjectPermissionsMapperGetInstance = SObjectPermissionsMapper.instance;
        Test.stopTest();

        System.assertEquals(
            sObjectPermissionsMapperInstance,
            sObjectPermissionsMapperGetInstance,
            'Retrieved Mapper instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getModelMapFromPermissionSetIdListAndSObjectNameList() {
        SObjectPermissionsMapper sObjectPermissionsMapper = SObjectPermissionsMapper.getInstance();

        List<ObjectPermissions> objectPermissionsList = [
            SELECT ParentId, SObjectType, PermissionsCreate, PermissionsDelete, PermissionsEdit, PermissionsRead
            FROM ObjectPermissions
            WHERE SObjectType = 'Account'
            LIMIT 2
        ];

        List<Id> permissionSetIdList = new List<Id>();

        for (ObjectPermissions objectPermissions : objectPermissionsList) {
            permissionSetIdList.add(objectPermissions.ParentId);
        }

        List<String> sObjectTypeList = new List<String>{ 'Account' };

        Test.startTest();
        Map<String, SObjectPermissionsModel> modelMapFromPermissionSetIdListAndSObjectNameList = sObjectPermissionsMapper.getModelMapFromPermissionSetIdListAndSObjectNameList(
            permissionSetIdList,
            sObjectTypeList
        );
        Test.stopTest();

        System.assertEquals(1, modelMapFromPermissionSetIdListAndSObjectNameList.size());

        SObjectPermissionsModel sObjectPermissionsModel = modelMapFromPermissionSetIdListAndSObjectNameList.get(
            'Account'
        );

        System.assertNotEquals(null, sObjectPermissionsModel);
    }
}
