@isTest
private class ApexClassAccessMapper_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        ApexClassAccessMapper apexClassAccessMapperinstance = ApexClassAccessMapper.getInstance();
        Test.stopTest();

        System.assertNotEquals(
            null,
            apexClassAccessMapperinstance,
            'Apex Class Access Mapper instance should not be null.'
        );
        System.assertEquals(
            ApexClassAccessMapper.instance,
            apexClassAccessMapperinstance,
            'Apex Class Access Mapper instance should equal the apex class mapper instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        ApexClassAccessMapper apexClassAccessMapperInstance = ApexClassAccessMapper.getInstance();

        Test.startTest();
        ApexClassAccessMapper apexClassAccessMapperGetInstance = ApexClassAccessMapper.instance;
        Test.stopTest();

        System.assertEquals(
            apexClassAccessMapperInstance,
            apexClassAccessMapperGetInstance,
            'Retrieved Apex Class Access Mapper instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getModelMapByPermissionSetIdList() {
        ApexClassAccessMapper apexClassAccessMapper = ApexClassAccessMapper.getInstance();

        Profile arbitraryProfile = [
            SELECT Id, Name, Description
            FROM Profile
            WHERE UserType = 'Standard' AND PermissionsAuthorApex = TRUE
            LIMIT 1
        ];

        PermissionSet profilePermissionSet = [
            SELECT Id
            FROM PermissionSet
            WHERE IsOwnedByProfile = TRUE AND ProfileId = :arbitraryProfile.Id
        ];

        List<SetupEntityAccess> apexClassAccessList = [
            SELECT SetupEntityId
            FROM SetupEntityAccess
            WHERE SetupEntityType = 'ApexClass' AND ParentId = :profilePermissionSet.Id
            LIMIT 50
        ];

        List<Id> permissionSetIdList = new List<Id>{ profilePermissionSet.Id };

        List<Id> apexClassIdList = new List<Id>();

        for (SetupEntityAccess setupEntityAccess : apexClassAccessList) {
            apexClassIdList.add(setupEntityAccess.SetupEntityId);
        }

        Test.startTest();
        Map<Id, ApexClassAccessModel> apexClassAccessModelByClassId = apexClassAccessMapper.getModelMapFromPermissionSetIdListAndClassIdList(
            permissionSetIdList,
            apexClassIdList
        );
        Test.stopTest();

        System.assertEquals(
            apexClassAccessList.size(),
            apexClassAccessModelByClassId.size(),
            'The number of Apex Class Access Models should equal that of the Permission Set\'s Apex Class access.'
        );

        for (SetupEntityAccess apexClassAccess : apexClassAccessList) {
            ApexClassAccessModel apexClassAccessModel = apexClassAccessModelByClassId.get(
                apexClassAccess.SetupEntityId
            );

            System.assertNotEquals(
                null,
                apexClassAccessModel,
                'An Apex Class Access Model should be retrieved for every class Apex Class Access for the Profile.'
            );
            System.assertEquals(
                apexClassAccess.SetupEntityId,
                apexClassAccessModel.apexClassId,
                'The Id of the Apex Class Access Model should match the Id of the Apex Class Access.'
            );
        }
    }
}
