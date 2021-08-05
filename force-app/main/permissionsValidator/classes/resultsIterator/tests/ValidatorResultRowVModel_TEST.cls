@isTest
private class ValidatorResultRowVModel_TEST {
    @isTest
    private static void constructor() {
        String id = 'Id';
        String metadatatype = 'Apex Class';
        String apiname = 'Api Name';
        String description = 'Description';
        ValidatorRequirementState createState = ValidatorRequirementState.NOT_REQUIRED;
        ValidatorRequirementState readState = ValidatorRequirementState.FOUND;
        ValidatorRequirementState updateState = ValidatorRequirementState.FOUND;
        ValidatorRequirementState deleteState = ValidatorRequirementState.MISSING;

        Test.startTest();
        ValidatorResultRowVModel model = new ValidatorResultRowVModel(
            id,
            metadatatype,
            apiname,
            description,
            createState,
            readState,
            updateState,
            deleteState
        );
        Test.stopTest();

        System.assertEquals(id, model.id, 'Id should match value passed to model.');

        System.assertEquals(metadatatype, model.metadatatype, 'Metadata Type should match value passed to model.');

        System.assertEquals(apiname, model.apiname, 'Api Name should match value passed to model.');

        System.assertEquals(description, model.description, 'Description should match value passed to model.');

        System.assertEquals(false, model.passed, 'Passed should match expected value.');

        System.assertEquals('', model.createClass, 'Create Class should match expected value.');

        System.assertEquals('', model.createAccess, 'Create Access should match expected value.');

        System.assertEquals('slds-text-color_success', model.readClass, 'Read Class should match expected value.');

        System.assertEquals(Label.foundAccess, model.readAccess, 'Read Access should match expected value.');

        System.assertEquals('slds-text-color_success', model.editClass, 'Edit Class should match expected value.');

        System.assertEquals(Label.foundAccess, model.editAccess, 'Edit Access should match expected value.');

        System.assertEquals('slds-text-color_error', model.deleteClass, 'Delete Class should match expected value.');

        System.assertEquals(Label.missingAccess, model.deleteAccess, 'Delete Access should match expected value.');
    }

    @isTest
    private static void getClassFromStatusFromMissing() {
        ValidatorResultRowVModel model = new ValidatorResultRowVModel(
            'Id',
            'Apex Class',
            'Api Name',
            'Description',
            ValidatorRequirementState.MISSING,
            ValidatorRequirementState.MISSING,
            ValidatorRequirementState.MISSING,
            ValidatorRequirementState.MISSING
        );

        String expectedClass = 'slds-text-color_error';

        Test.startTest();
        String classFromStatus = model.getClassFromStatus(ValidatorRequirementState.MISSING);
        Test.stopTest();

        System.assertEquals(expectedClass, classFromStatus, 'Class should match expected value.');
    }

    @isTest
    private static void getClassFromStatusFound() {
        ValidatorResultRowVModel model = new ValidatorResultRowVModel(
            'Id',
            'Apex Class',
            'Api Name',
            'Description',
            ValidatorRequirementState.FOUND,
            ValidatorRequirementState.FOUND,
            ValidatorRequirementState.FOUND,
            ValidatorRequirementState.FOUND
        );

        String expectedClass = 'slds-text-color_success';

        Test.startTest();
        String classFromStatus = model.getClassFromStatus(ValidatorRequirementState.FOUND);
        Test.stopTest();

        System.assertEquals(expectedClass, classFromStatus, 'Class should match expected value.');
    }

    @isTest
    private static void getClassFromStatusNotRequired() {
        ValidatorResultRowVModel model = new ValidatorResultRowVModel(
            'Id',
            'Apex Class',
            'Api Name',
            'Description',
            ValidatorRequirementState.NOT_REQUIRED,
            ValidatorRequirementState.NOT_REQUIRED,
            ValidatorRequirementState.NOT_REQUIRED,
            ValidatorRequirementState.NOT_REQUIRED
        );

        String expectedClass = '';

        Test.startTest();
        String classFromStatus = model.getClassFromStatus(ValidatorRequirementState.NOT_REQUIRED);
        Test.stopTest();

        System.assertEquals(expectedClass, classFromStatus, 'Class should match expected value.');
    }

    @isTest
    private static void getAccessFromStatusMissing() {
        ValidatorResultRowVModel model = new ValidatorResultRowVModel(
            'Id',
            'Apex Class',
            'Api Name',
            'Description',
            ValidatorRequirementState.MISSING,
            ValidatorRequirementState.MISSING,
            ValidatorRequirementState.MISSING,
            ValidatorRequirementState.MISSING
        );

        String expectedAccess = Label.missingAccess;

        Test.startTest();
        String accessFromStatus = model.getAccessFromStatus(ValidatorRequirementState.MISSING);
        Test.stopTest();

        System.assertEquals(expectedAccess, accessFromStatus, 'Class should match expected value.');
    }

    @isTest
    private static void getAccessFromStatusFound() {
        ValidatorResultRowVModel model = new ValidatorResultRowVModel(
            'Id',
            'Apex Class',
            'Api Name',
            'Description',
            ValidatorRequirementState.FOUND,
            ValidatorRequirementState.FOUND,
            ValidatorRequirementState.FOUND,
            ValidatorRequirementState.FOUND
        );

        String expectedAccess = Label.foundAccess;

        Test.startTest();
        String accessFromStatus = model.getAccessFromStatus(ValidatorRequirementState.FOUND);
        Test.stopTest();

        System.assertEquals(expectedAccess, accessFromStatus, 'Class should match expected value.');
    }

    @isTest
    private static void getAccessFromStatusNotRequired() {
        ValidatorResultRowVModel model = new ValidatorResultRowVModel(
            'Id',
            'Apex Class',
            'Api Name',
            'Description',
            ValidatorRequirementState.NOT_REQUIRED,
            ValidatorRequirementState.NOT_REQUIRED,
            ValidatorRequirementState.NOT_REQUIRED,
            ValidatorRequirementState.NOT_REQUIRED
        );

        String expectedAccess = '';

        Test.startTest();
        String accessFromStatus = model.getAccessFromStatus(ValidatorRequirementState.NOT_REQUIRED);
        Test.stopTest();

        System.assertEquals(expectedAccess, accessFromStatus, 'Class should match expected value.');
    }

    @isTest
    private static void compareToDifferentObject() {
        String id = 'Id';
        String metadatatype = 'Apex Class';
        String apiname = 'Api Name';
        String description = 'Description';
        ValidatorRequirementState readState = ValidatorRequirementState.MISSING;
        ValidatorRequirementState createState = ValidatorRequirementState.MISSING;
        ValidatorRequirementState updateState = ValidatorRequirementState.MISSING;
        ValidatorRequirementState deleteState = ValidatorRequirementState.MISSING;

        ValidatorResultRowVModel model1 = new ValidatorResultRowVModel(
            id,
            metadatatype,
            apiname,
            description,
            readState,
            createState,
            updateState,
            deleteState
        );
        Account account = new Account(Name = 'Test');

        Test.startTest();
        Integer compareResult = model1.compareTo(account);
        Test.stopTest();

        System.assertEquals(0, compareResult, 'Models comparing to other types should compare to 0.');
    }

    @isTest
    private static void compareToSame() {
        String id = 'Id';
        String metadatatype = 'Apex Class';
        String apiname = 'Api Name';
        String description = 'Description';
        ValidatorRequirementState readState = ValidatorRequirementState.MISSING;
        ValidatorRequirementState createState = ValidatorRequirementState.MISSING;
        ValidatorRequirementState updateState = ValidatorRequirementState.MISSING;
        ValidatorRequirementState deleteState = ValidatorRequirementState.MISSING;

        ValidatorResultRowVModel model1 = new ValidatorResultRowVModel(
            id,
            metadatatype,
            apiname,
            description,
            readState,
            createState,
            updateState,
            deleteState
        );
        ValidatorResultRowVModel model2 = new ValidatorResultRowVModel(
            id,
            metadatatype,
            apiname,
            description,
            readState,
            createState,
            updateState,
            deleteState
        );

        Test.startTest();
        Integer compareResult = model1.compareTo(model2);
        Test.stopTest();

        System.assertEquals(0, compareResult, 'Models with the same metadata type and api name should compare to 0.');
    }

    @isTest
    private static void compareToMetadatatype() {
        String id = 'Id';
        String metadatatype = 'Apex Class';
        String apiname = 'Api Name';
        String description = 'Description';
        ValidatorRequirementState readState = ValidatorRequirementState.MISSING;
        ValidatorRequirementState createState = ValidatorRequirementState.MISSING;
        ValidatorRequirementState updateState = ValidatorRequirementState.MISSING;
        ValidatorRequirementState deleteState = ValidatorRequirementState.MISSING;

        ValidatorResultRowVModel model1 = new ValidatorResultRowVModel(
            id,
            metadatatype + '1',
            apiname,
            description,
            readState,
            createState,
            updateState,
            deleteState
        );
        ValidatorResultRowVModel model2 = new ValidatorResultRowVModel(
            id,
            metadatatype + '2',
            apiname,
            description,
            readState,
            createState,
            updateState,
            deleteState
        );

        Test.startTest();
        Integer compareResult = model1.compareTo(model2);
        Test.stopTest();

        System.assertEquals(
            model1.metadatatype.compareTo(model2.metadatatype),
            compareResult,
            'Models with different metadata types should compare based on their metadata types.'
        );
    }

    @isTest
    private static void compareToApiname() {
        String id = 'Id';
        String metadatatype = 'Apex Class';
        String apiname = 'Api Name';
        String description = 'Description';
        ValidatorRequirementState readState = ValidatorRequirementState.MISSING;
        ValidatorRequirementState createState = ValidatorRequirementState.MISSING;
        ValidatorRequirementState updateState = ValidatorRequirementState.MISSING;
        ValidatorRequirementState deleteState = ValidatorRequirementState.MISSING;

        ValidatorResultRowVModel model1 = new ValidatorResultRowVModel(
            id,
            metadatatype,
            apiname + '1',
            description,
            readState,
            createState,
            updateState,
            deleteState
        );
        ValidatorResultRowVModel model2 = new ValidatorResultRowVModel(
            id,
            metadatatype,
            apiname + '2',
            description,
            readState,
            createState,
            updateState,
            deleteState
        );

        Test.startTest();
        Integer compareResult = model1.compareTo(model2);
        Test.stopTest();

        System.assertEquals(
            model1.apiname.compareTo(model2.apiname),
            compareResult,
            'Models withthe same metadata types and different api names types should compare based on their api names.'
        );
    }
}
