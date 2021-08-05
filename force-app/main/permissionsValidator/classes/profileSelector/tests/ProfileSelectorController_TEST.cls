@isTest
private class ProfileSelectorController_TEST {
    @isTest
    private static void getViewModel() {
        ProfileSelectorVMapper.instance = new ProfileSelectorVMapperStub();

        ProfileSelectorVModel expectedProfileSelectorVModel = ProfileSelectorVMapper.getInstance().getViewModel();

        Test.startTest();
        ProfileSelectorVModel profileSelectorVModel = ProfileSelectorController.getViewModel();
        Test.stopTest();

        System.assertEquals(
            expectedProfileSelectorVModel.profileViewModelList.size(),
            profileSelectorVModel.profileViewModelList.size(),
            'The Profile Selector View Model\'s Profile View Model List size should be equal to that of the mapper\'s.'
        );
    }

    @isTest
    private static void getViewModelAuraException() {
        ProfileSelectorVMapper.instance = new ProfileSelectorVMapperErrorStub();

        try {
            Test.startTest();
            ProfileSelectorVModel profileSelectorVModel = ProfileSelectorController.getViewModel();
            Test.stopTest();

            System.assert(false, 'An aura handled exception should always be thrown on a caught exception.');
        } catch (AuraHandledException ahe) {
        }
    }

    @isTest
    private static void locateProfileSelectorVMapper() {
        ProfileSelectorVMapper expectedProfileSelectorVMapper = ProfileSelectorVMapper.getInstance();

        Test.startTest();
        ProfileSelectorVMapper profileSelectorVMapper = ProfileSelectorController.locateProfileSelectorVMapper();
        Test.stopTest();

        System.assertEquals(
            expectedProfileSelectorVMapper,
            profileSelectorVMapper,
            'The Profile Selector View Model Mapper located from the controller should be that from mappers\'s instance method.'
        );
    }

    public virtual class ProfileSelectorVMapperStub extends ProfileSelectorVMapper {
        protected ProfileSelectorVMapperStub() {
        }

        public override ProfileSelectorVModel getViewModel() {
            List<ProfileVModel> profileVModelList = new List<ProfileVModel>();

            ProfileSelectorVModel profileSelectorVModel = new ProfileSelectorVModel(profileVModelList);

            return profileSelectorVModel;
        }
    }

    public virtual class ProfileSelectorVMapperErrorStub extends ProfileSelectorVMapper {
        protected ProfileSelectorVMapperErrorStub() {
        }

        public override ProfileSelectorVModel getViewModel() {
            throw new NoAccessException();
        }
    }
}
