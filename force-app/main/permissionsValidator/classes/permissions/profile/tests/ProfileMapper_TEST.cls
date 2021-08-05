@isTest
private class ProfileMapper_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        ProfileMapper profileMapperinstance = ProfileMapper.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, profileMapperinstance, 'Mapper instance should not be null.');
        System.assertEquals(
            ProfileMapper.instance,
            profileMapperinstance,
            'Mapper instance should equal the apex class mapper instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        ProfileMapper profileMapperInstance = ProfileMapper.getInstance();

        Test.startTest();
        ProfileMapper profileMapperGetInstance = ProfileMapper.instance;
        Test.stopTest();

        System.assertEquals(
            profileMapperInstance,
            profileMapperGetInstance,
            'Retrieved Mapper instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getProfileModels() {
        ProfileMapper profileMapper = ProfileMapper.getInstance();

        Profile arbitraryProfile = [
            SELECT Id, Name, Description
            FROM Profile
            WHERE UserType = 'Standard' AND PermissionsAuthorApex = TRUE
            LIMIT 1
        ];

        Test.startTest();
        List<ProfileModel> profileModelList = profileMapper.getProfileModels();
        Test.stopTest();

        System.assertNotEquals(0, profileModelList.size(), 'The number of Profile Models should not equal 0.');

        Boolean profileFound = false;

        for (ProfileModel profileModel : profileModelList) {
            if (profileModel.profileId == arbitraryProfile.Id) {
                profileFound = true;
            }
        }

        System.assertEquals(
            true,
            profileFound,
            arbitraryProfile.Name + ' should be among those cast into a profile model.'
        );
    }
}
