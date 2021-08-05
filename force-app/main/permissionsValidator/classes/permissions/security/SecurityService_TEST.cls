@isTest
private class SecurityService_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        SecurityService securityServiceInstance = SecurityService.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, securityServiceinstance, 'Service instance should not be null.');
        System.assertEquals(
            SecurityService.instance,
            securityServiceinstance,
            'Service instance should equal the apex class service instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        SecurityService securityServiceInstance = SecurityService.getInstance();

        Test.startTest();
        SecurityService securityServiceGetInstance = SecurityService.instance;
        Test.stopTest();

        System.assertEquals(
            securityServiceInstance,
            securityServiceGetInstance,
            'Retrieved Service instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void assertViewSetupPermissionForCurrentUser() {
        SecurityService.instance = new SecurityServiceStub();
        SecurityService securityService = SecurityService.getInstance();

        Test.startTest();
        Boolean checkPassed = securityService.assertViewSetupPermissionForCurrentUser();
        Test.stopTest();

        System.assertEquals(true, checkPassed, 'The test for setup permissions should pass for the current user.');
    }

    @isTest
    private static void assertViewSetupPermissionForCurrentUserCached() {
        SecurityService.instance = new SecurityServiceStub();
        SecurityService securityService = SecurityService.getInstance();

        Boolean expectedCheckPassed = securityService.assertViewSetupPermissionForCurrentUser();

        Test.startTest();
        Boolean checkPassed = securityService.assertViewSetupPermissionForCurrentUser();
        Integer soqlQueries = System.Limits.getQueries();
        Test.stopTest();

        System.assertEquals(
            expectedCheckPassed,
            checkPassed,
            'The test for setup permissions should pass for the current user.'
        );

        System.assertEquals(0, soqlQueries, 'No additional SOQL queries should be run.');
    }

    @isTest
    private static void assertViewSetupPermissionForCurrentUserFail() {
        SecurityService.instance = new SecurityServiceStubFail();
        SecurityService securityService = SecurityService.getInstance();

        try {
            Test.startTest();
            Boolean checkPassed = securityService.assertViewSetupPermissionForCurrentUser();
            Test.stopTest();

            System.assert(false, 'An exception should always be thrown for a failed check.');
        } catch (NoAccessException nae) {
        }
    }

    @isTest
    private static void getPermissionSetWithViewSetup() {
        SecurityService securityService = SecurityService.getInstance();

        Profile arbitraryProfile = [
            SELECT Id, Name, Description
            FROM Profile
            WHERE UserType = 'Standard' AND PermissionsAuthorApex = TRUE
            LIMIT 1
        ];

        PermissionSet permissionSetWithAccess = [SELECT Id FROM PermissionSet WHERE ProfileId = :arbitraryProfile.Id];

        Test.startTest();
        PermissionSet permissionSet = securityService.getPermissionSetWithViewSetup(
            new List<Id>{ permissionSetWithAccess.Id }
        );
        Test.stopTest();

        System.assertNotEquals(null, permissionSet, 'A permission set with view setup access should be retrieved.');
    }

    public virtual class SecurityServiceStub extends SecurityService {
        protected SecurityServiceStub() {
        }

        @TestVisible
        protected override PermissionSet getPermissionSetWithViewSetup(List<Id> permissionSetIdList) {
            return new PermissionSet();
        }
    }

    public virtual class SecurityServiceStubFail extends SecurityService {
        protected SecurityServiceStubFail() {
        }

        @TestVisible
        protected override PermissionSet getPermissionSetWithViewSetup(List<Id> permissionSetIdList) {
            return null;
        }
    }
}
