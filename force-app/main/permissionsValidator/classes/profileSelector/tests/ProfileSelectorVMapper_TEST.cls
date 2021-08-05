@isTest
private class ProfileSelectorVMapper_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        ProfileSelectorVMapper profileSelectorVMapperinstance = ProfileSelectorVMapper.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, profileSelectorVMapperinstance, 'Mapper instance should not be null.');
        System.assertEquals(
            ProfileSelectorVMapper.instance,
            profileSelectorVMapperinstance,
            'Mapper instance should equal the apex class mapper instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        ProfileSelectorVMapper profileSelectorVMapperInstance = ProfileSelectorVMapper.getInstance();

        Test.startTest();
        ProfileSelectorVMapper profileSelectorVMapperGetInstance = ProfileSelectorVMapper.instance;
        Test.stopTest();

        System.assertEquals(
            profileSelectorVMapperInstance,
            profileSelectorVMapperGetInstance,
            'Retrieved Mapper instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getViewModel() {
        ProfileSelectorVMapper profileSelectorVMapper = ProfileSelectorVMapper.getInstance();

        ProfileService.instance = new ProfileServiceStub();

        List<ProfileModel> profileModelList = ProfileService.getInstance().getProfileModels();

        Test.startTest();
        ProfileSelectorVModel profileSelectorVModel = profileSelectorVMapper.getViewModel();
        Test.stopTest();

        List<ProfileVModel> profileViewModelList = profileSelectorVModel.profileViewModelList;

        System.assertEquals(
            profileModelList.size(),
            profileViewModelList.size(),
            'Profile View Model List size from the mapper should equal the size from the service.'
        );

        for (Integer i = 0; i < profileViewModelList.size(); i++) {
            System.assertEquals(
                profileModelList[i].profileId,
                profileViewModelList[i].value,
                'Profile View Model Value from the mapper should equal the Profile Model Id from the service.'
            );

            System.assertEquals(
                profileModelList[i].name,
                profileViewModelList[i].label,
                'Profile View Model Label from the mapper should equal the Profile Model Name from the service.'
            );
        }
    }

    @isTest
    private static void getProfileVModelListFromModels() {
        ProfileSelectorVMapper profileSelectorVMapper = ProfileSelectorVMapper.getInstance();

        List<ProfileModel> profileModelList = new List<ProfileModel>();

        ProfileModel profileModel = new ProfileModel('000000000000000000', 'test');

        profileModelList.add(profileModel);

        Test.startTest();
        List<ProfileVModel> profileViewModelList = profileSelectorVMapper.getProfileVModelListFromModels(
            profileModelList
        );
        Test.stopTest();

        System.assertEquals(
            profileModelList.size(),
            profileViewModelList.size(),
            'Profile View Model List size from the mapper should equal the size of the model list passed to it.'
        );

        for (Integer i = 0; i < profileViewModelList.size(); i++) {
            System.assertEquals(
                profileModelList[i].profileId,
                profileViewModelList[i].value,
                'Profile View Model Value from the mapper should equal the Profile Model Id from the model passed to it.'
            );

            System.assertEquals(
                profileModelList[i].name,
                profileViewModelList[i].label,
                'Profile View Model Label from the mapper should equal the Profile Model Name from the model passed to it.'
            );
        }
    }

    @isTest
    private static void locateProfileService() {
        ProfileSelectorVMapper profileSelectorVMapper = ProfileSelectorVMapper.getInstance();

        ProfileService expectedProfileService = ProfileService.getInstance();

        Test.startTest();
        ProfileService profileService = profileSelectorVMapper.locateProfileService();
        Test.stopTest();

        System.assertEquals(
            expectedProfileService,
            profileService,
            'The Profile Service located from the mapper should be that from service\'s instance method.'
        );
    }

    public virtual class ProfileServiceStub extends ProfileService {
        protected ProfileServiceStub() {
        }

        public override List<ProfileModel> getProfileModels() {
            List<ProfileModel> profileModelList = new List<ProfileModel>();

            ProfileModel profileModel = new ProfileModel('000000000000000000', 'test');

            profileModelList.add(profileModel);

            return profileModelList;
        }
    }
}
