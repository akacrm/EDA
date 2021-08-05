@isTest
private class ProfileVModel_TEST {
    @isTest
    private static void constructor() {
        Id value = '000000000000000000';
        String label = 'profile';

        Test.startTest();
        ProfileVModel model = new ProfileVModel(value, label);
        Test.stopTest();

        System.assertEquals(value, model.value, 'Value should match value passed to model.');
        System.assertEquals(label, model.label, 'Label should match value passed to model.');
    }
}
