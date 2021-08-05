@isTest
private class ProfileModel_TEST {
    @isTest
    private static void constructor() {
        Id profileId = '000000000000000000';
        String name = 'profile';

        Test.startTest();
        ProfileModel model = new ProfileModel(profileId, name);
        Test.stopTest();

        System.assertEquals(profileId, model.profileId, 'Profile Id should match value passed to model.');
        System.assertEquals(name, model.name, 'Name should match value passed to model.');
    }
}
