@isTest
private class ProfileService_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        ProfileService profileServiceInstance = ProfileService.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, profileServiceinstance, 'Service instance should not be null.');
        System.assertEquals(
            ProfileService.instance,
            profileServiceinstance,
            'Service instance should equal the apex class service instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        ProfileService profileServiceInstance = ProfileService.getInstance();

        Test.startTest();
        ProfileService profileServiceGetInstance = ProfileService.instance;
        Test.stopTest();

        System.assertEquals(
            profileServiceInstance,
            profileServiceGetInstance,
            'Retrieved Service instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getProfileModels() {
        ProfileService profileService = ProfileService.getInstance();

        ProfileMapper.instance = new ProfileMapperStub();

        List<ProfileModel> expectedProfileModelList = ProfileMapper.getInstance().getProfileModels();

        Test.startTest();
        List<ProfileModel> profileModelList = profileService.getProfileModels();
        Test.stopTest();

        System.assertEquals(
            expectedProfileModelList.size(),
            profileModelList.size(),
            'Profile Model List size from the service should equal the size from the mapper.'
        );

        for (Integer i = 0; i < expectedProfileModelList.size(); i++) {
            System.assertEquals(
                expectedProfileModelList[i].profileId,
                profileModelList[i].profileId,
                'Profile Id from the service should equal the Profile Id from the mapper.'
            );

            System.assertEquals(
                expectedProfileModelList[i].name,
                profileModelList[i].name,
                'Profile Name from the service should equal the Profile Name from the mapper.'
            );
        }
    }

    @isTest
    private static void locateProfileMapper() {
        ProfileService profileService = ProfileService.getInstance();

        ProfileMapper expectedProfileMapper = ProfileMapper.getInstance();

        Test.startTest();
        ProfileMapper profileMapper = profileService.locateProfileMapper();
        Test.stopTest();

        System.assertEquals(
            expectedProfileMapper,
            profileMapper,
            'The Profile Mapper located from the service should be that from mapper\'s instance method.'
        );
    }

    public virtual class ProfileMapperStub extends ProfileMapper {
        protected ProfileMapperStub() {
        }

        public override List<ProfileModel> getProfileModels() {
            List<ProfileModel> profileModelList = new List<ProfileModel>();

            ProfileModel profileModel = new ProfileModel('000000000000000000', 'test');

            profileModelList.add(profileModel);

            return profileModelList;
        }
    }
}
