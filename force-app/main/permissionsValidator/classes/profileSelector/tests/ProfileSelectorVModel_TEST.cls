@isTest
private class ProfileSelectorVModel_TEST {
    @isTest
    private static void constructor() {
        List<ProfileVModel> profileViewModelList = new List<ProfileVModel>();

        Test.startTest();
        ProfileSelectorVModel model = new ProfileSelectorVModel(profileViewModelList);
        Test.stopTest();

        System.assertEquals(
            profileViewModelList,
            model.profileViewModelList,
            'Profile View Model List should match value passed to model.'
        );
    }
}
