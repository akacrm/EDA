@isTest
private class ApexClassAccessModel_TEST {
    @isTest
    private static void constructor() {
        Id apexClassId = '000000000000000000';

        ApexClassAccessModel model = new ApexClassAccessModel(apexClassId);

        System.assertEquals(apexClassId, model.apexClassId, 'Apex Class Id should match value passed to model.');
    }
}
