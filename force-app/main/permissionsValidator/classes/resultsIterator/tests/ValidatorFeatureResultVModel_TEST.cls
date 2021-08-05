@isTest
private class ValidatorFeatureResultVModel_TEST {
    @isTest
    private static void constructor() {
        String name = 'name';
        String icon = 'icon';
        String status = 'Pass';
        String statusLabel = Label.allAccessMetStatus;
        List<ValidatorResultRowVModel> tableData = new List<ValidatorResultRowVModel>();

        Test.startTest();
        ValidatorFeatureResultVModel model = new ValidatorFeatureResultVModel(
            name,
            icon,
            status,
            statusLabel,
            tableData
        );
        Test.stopTest();

        System.assertEquals(name, model.name, 'Name should match value passed to model.');

        System.assertEquals(icon, model.icon, 'Icon should match value passed to model.');

        System.assertEquals(statusLabel, model.statusLabel, 'Status label should match value passed to model.');

        System.assertEquals(tableData, model.tableData, 'Table Data should match value passed to model.');
    }

    @isTest
    private static void compareToDifferentObject() {
        String name = 'name';
        String icon = 'icon';
        String status = 'Pass';
        String statusLabel = Label.allAccessMetStatus;
        List<ValidatorResultRowVModel> tableData = new List<ValidatorResultRowVModel>();

        ValidatorFeatureResultVModel model1 = new ValidatorFeatureResultVModel(
            name,
            icon,
            status,
            statusLabel,
            tableData
        );
        Account account = new Account(Name = 'Test');

        Test.startTest();
        Integer compareResult = model1.compareTo(account);
        Test.stopTest();

        System.assertEquals(0, compareResult, 'Models comparing to other types should compare to 0.');
    }

    @isTest
    private static void compareToSame() {
        String name = 'name';
        String icon = 'icon';
        String status = 'Pass';
        String statusLabel = Label.allAccessMetStatus;
        List<ValidatorResultRowVModel> tableData = new List<ValidatorResultRowVModel>();

        ValidatorFeatureResultVModel model1 = new ValidatorFeatureResultVModel(
            name,
            icon,
            status,
            statusLabel,
            tableData
        );
        ValidatorFeatureResultVModel model2 = new ValidatorFeatureResultVModel(
            name,
            icon,
            status,
            statusLabel,
            tableData
        );

        Test.startTest();
        Integer compareResult = model1.compareTo(model2);
        Test.stopTest();

        System.assertEquals(0, compareResult, 'Models with the same name should compare to 0.');
    }

    @isTest
    private static void compareToMetadatatype() {
        String name = 'name';
        String icon = 'icon';
        String status = 'Pass';
        String statusLabel = Label.allAccessMetStatus;
        List<ValidatorResultRowVModel> tableData = new List<ValidatorResultRowVModel>();

        ValidatorFeatureResultVModel model1 = new ValidatorFeatureResultVModel(
            name + '1',
            icon,
            status,
            statusLabel,
            tableData
        );
        ValidatorFeatureResultVModel model2 = new ValidatorFeatureResultVModel(
            name + '2',
            icon,
            status,
            statusLabel,
            tableData
        );

        Test.startTest();
        Integer compareResult = model1.compareTo(model2);
        Test.stopTest();

        System.assertEquals(
            model1.name.compareTo(model2.name),
            compareResult,
            'Models with different names should compare based on their names.'
        );
    }
}
