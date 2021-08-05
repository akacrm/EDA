@isTest
private class SObjectFieldPermissionsMapper_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        SObjectFieldPermissionsMapper sObjectFieldPermissionsMapperinstance = SObjectFieldPermissionsMapper.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, sObjectFieldPermissionsMapperinstance, 'Mapper instance should not be null.');
        System.assertEquals(
            SObjectFieldPermissionsMapper.instance,
            sObjectFieldPermissionsMapperinstance,
            'Mapper instance should equal the apex class mapper instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        SObjectFieldPermissionsMapper sObjectFieldPermissionsMapperInstance = SObjectFieldPermissionsMapper.getInstance();

        Test.startTest();
        SObjectFieldPermissionsMapper sObjectFieldPermissionsMapperGetInstance = SObjectFieldPermissionsMapper.instance;
        Test.stopTest();

        System.assertEquals(
            sObjectFieldPermissionsMapperInstance,
            sObjectFieldPermissionsMapperGetInstance,
            'Retrieved Mapper instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getModelMapFromDefinitionLists() {
        SObjectFieldPermissionsMapper sObjectFieldPermissionsMapper = SObjectFieldPermissionsMapper.getInstance();

        List<FieldPermissions> fieldPermissionsList = [
            SELECT ParentId, SObjectType, Field, PermissionsEdit, PermissionsRead
            FROM FieldPermissions
            WHERE SObjectType = 'Account' AND Field = 'Account.AccountNumber'
            ORDER BY SObjectType, Field
            LIMIT 2
        ];

        List<Id> permissionSetIdList = new List<Id>();

        for (FieldPermissions fieldPermissions : fieldPermissionsList) {
            permissionSetIdList.add(fieldPermissions.ParentId);
        }

        List<String> nameList = new List<String>{ 'Account.AccountNumber' };

        Test.startTest();
        Map<String, SObjectFieldPermissionsModel> modelMapFromDefinitionLists = sObjectFieldPermissionsMapper.getModelMapFromDefinitionLists(
            permissionSetIdList,
            nameList
        );
        Test.stopTest();

        System.assertEquals(1, modelMapFromDefinitionLists.size());

        SObjectFieldPermissionsModel sObjectFieldPermissionsModel = modelMapFromDefinitionLists.get(
            'Account.AccountNumber'
        );

        System.assertNotEquals(null, sObjectFieldPermissionsModel);
    }
}
