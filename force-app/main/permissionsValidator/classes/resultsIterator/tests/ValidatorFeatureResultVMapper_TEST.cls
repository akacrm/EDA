@isTest
private class ValidatorFeatureResultVMapper_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        ValidatorFeatureResultVMapper validatorFeatureResultVMapperinstance = ValidatorFeatureResultVMapper.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, validatorFeatureResultVMapperinstance, 'Mapper instance should not be null.');
        System.assertEquals(
            ValidatorFeatureResultVMapper.instance,
            validatorFeatureResultVMapperinstance,
            'Mapper instance should equal the apex class mapper instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapperInstance = ValidatorFeatureResultVMapper.getInstance();

        Test.startTest();
        ValidatorFeatureResultVMapper validatorFeatureResultVMapperGetInstance = ValidatorFeatureResultVMapper.instance;
        Test.stopTest();

        System.assertEquals(
            validatorFeatureResultVMapperInstance,
            validatorFeatureResultVMapperGetInstance,
            'Retrieved Mapper instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getViewModelMeetsAccess() {
        ValidatorFeatureResultVMapper.instance = new ValidatorFeatureResultVMapperStub(ValidatorRequirementState.FOUND);
        ApexClassAccessService.instance = new ApexClassAccessServiceStub();
        ApexClassService.instance = new ApexClassServiceStub();
        PermissionSetService.instance = new PermissionSetServiceStub();
        PermissionDefinitionService.instance = new PermissionDefinitionServiceStub();
        SObjectPermissionsService.instance = new SObjectPermissionsServiceStub();
        SObjectFieldPermissionsService.instance = new SObjectFieldPermissionsServiceStub();

        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        String expectedFeatureName = 'featureName';

        Test.startTest();
        ValidatorFeatureResultVModel validatorFeatureResultVModel = validatorFeatureResultVMapper.getViewModel(
            expectedFeatureName,
            false,
            Id.valueOf('000000000000000000'),
            new List<Id>(),
            new List<Id>()
        );
        Test.stopTest();

        System.assertEquals(
            expectedFeatureName,
            validatorFeatureResultVModel.name,
            'Name should match expected feature name.'
        );
        System.assertEquals('utility:success', validatorFeatureResultVModel.icon, 'Icon should match success icon.');
        System.assertEquals('Pass', validatorFeatureResultVModel.status, 'Status should match passing status.');
        System.assertEquals(
            Label.allAccessMetStatus,
            validatorFeatureResultVModel.statusLabel,
            'Status label should match access met status label.'
        );
        System.assertEquals(
            0,
            validatorFeatureResultVModel.tableData.size(),
            'No data should be displayed in the table if all access is met.'
        );
    }

    @isTest
    private static void getViewModelMeetsAccessShowAll() {
        ValidatorFeatureResultVMapper.instance = new ValidatorFeatureResultVMapperStub(ValidatorRequirementState.FOUND);
        ApexClassAccessService.instance = new ApexClassAccessServiceStub();
        ApexClassService.instance = new ApexClassServiceStub();
        PermissionSetService.instance = new PermissionSetServiceStub();
        PermissionDefinitionService.instance = new PermissionDefinitionServiceStub();
        SObjectPermissionsService.instance = new SObjectPermissionsServiceStub();
        SObjectFieldPermissionsService.instance = new SObjectFieldPermissionsServiceStub();

        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        String expectedFeatureName = 'featureName';

        Test.startTest();
        ValidatorFeatureResultVModel validatorFeatureResultVModel = validatorFeatureResultVMapper.getViewModel(
            expectedFeatureName,
            true,
            Id.valueOf('000000000000000000'),
            new List<Id>(),
            new List<Id>()
        );
        Test.stopTest();

        System.assertEquals(
            expectedFeatureName,
            validatorFeatureResultVModel.name,
            'Name should match expected feature name.'
        );
        System.assertEquals('utility:success', validatorFeatureResultVModel.icon, 'Icon should match success icon.');
        System.assertEquals('Pass', validatorFeatureResultVModel.status, 'Status should match passing status.');
        System.assertEquals(
            Label.allAccessMetStatus,
            validatorFeatureResultVModel.statusLabel,
            'Status label should match access met status label.'
        );
        System.assertNotEquals(
            0,
            validatorFeatureResultVModel.tableData.size(),
            'Data should be displayed in the table if all access is met.'
        );
    }

    @isTest
    private static void getViewModelMissingAccess() {
        ValidatorFeatureResultVMapper.instance = new ValidatorFeatureResultVMapperStub(
            ValidatorRequirementState.MISSING
        );
        ApexClassAccessService.instance = new ApexClassAccessServiceStub();
        ApexClassService.instance = new ApexClassServiceStub();
        PermissionSetService.instance = new PermissionSetServiceStub();
        PermissionDefinitionService.instance = new PermissionDefinitionServiceStub();
        SObjectPermissionsService.instance = new SObjectPermissionsServiceStub();
        SObjectFieldPermissionsService.instance = new SObjectFieldPermissionsServiceStub();

        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        String expectedFeatureName = 'featureName';

        Test.startTest();
        ValidatorFeatureResultVModel validatorFeatureResultVModel = validatorFeatureResultVMapper.getViewModel(
            expectedFeatureName,
            false,
            Id.valueOf('000000000000000000'),
            new List<Id>(),
            new List<Id>()
        );
        Test.stopTest();

        System.assertEquals(
            expectedFeatureName,
            validatorFeatureResultVModel.name,
            'Name should match expected feature name.'
        );
        System.assertEquals('utility:error', validatorFeatureResultVModel.icon, 'Icon should match error icon.');
        System.assertEquals('Fail', validatorFeatureResultVModel.status, 'Status should match failing status.');
        System.assertEquals(
            Label.missingAccessStatus,
            validatorFeatureResultVModel.statusLabel,
            'Status label should match missing access status label.'
        );
        System.assertNotEquals(
            0,
            validatorFeatureResultVModel.tableData.size(),
            'Data should be displayed in the table if access is missing.'
        );
    }

    @isTest
    private static void getApexClassAccessByName() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        ApexClassService.instance = new ApexClassServiceStub();
        ApexClassAccessService.instance = new ApexClassAccessServiceStub();

        PermissionDefinitionService.TypeStringCollection apexClassTypeStringCollection = new PermissionDefinitionService.TypeStringCollection();

        ApexClassPermDefinitionModel apexClassPermissionDefinitionModel = new ApexClassPermDefinitionModel(
            'featureName',
            'className',
            ''
        );

        apexClassTypeStringCollection.namespacePrefixList.add(apexClassPermissionDefinitionModel.namespacePrefix);
        apexClassTypeStringCollection.apiNameList.add(apexClassPermissionDefinitionModel.apiName);

        List<Id> permissionSetIdList = new List<Id>{ Id.valueOf('000000000000000000') };

        Test.startTest();
        Map<String, ApexClassModel> apexClassAccessByName = validatorFeatureResultVMapper.getApexClassAccessByName(
            apexClassTypeStringCollection,
            permissionSetIdList
        );
        Test.stopTest();

        System.assertEquals(1, apexClassAccessByName.size(), 'Apex Class Access By Name map should have a size of 1.');

        ApexClassModel retrievedApexClassModel = apexClassAccessByName.get('className');

        System.assertEquals(
            Id.valueOf('000000000000000000'),
            retrievedApexClassModel.classId,
            'Class Id of retrieved Apex Class Model should be the expected value.'
        );
        System.assertEquals(
            'className',
            retrievedApexClassModel.name,
            'Name of retrieved Apex Class Model should be the expected value.'
        );
        System.assertEquals(
            '',
            retrievedApexClassModel.namespacePrefix,
            'Namespace Prefix of retrieved Apex Class Model should be the expected value.'
        );
    }

    @isTest
    private static void getValidatorResultRowVModelApexClass() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        PermissionDefinitionModel permissionDefinitionModel = new ApexClassPermDefinitionModel(
            'featureName',
            'className',
            ''
        );

        ApexClassModel apexClassModel = new ApexClassModel(Id.valueOf('000000000000000000'), 'className', '');

        Map<String, ApexClassModel> apexClassModelByName = new Map<String, ApexClassModel>{
            ApexClassModel.name => apexClassModel
        };

        Map<String, SObjectPermissionsModel> sObjectAccessModelMap = new Map<String, SObjectPermissionsModel>();

        Map<String, SObjectFieldPermissionsModel> sObjectFieldAccessModelMap = new Map<String, SObjectFieldPermissionsModel>();

        Test.startTest();
        ValidatorResultRowVModel validatorResultRowVModel = validatorFeatureResultVMapper.getValidatorResultRowVModel(
            permissionDefinitionModel,
            apexClassModelByName,
            sObjectAccessModelMap,
            sObjectFieldAccessModelMap
        );
        Test.stopTest();

        System.assertNotEquals(
            null,
            validatorResultRowVModel,
            'A validator result row view model should be returned for a valid apex class model.'
        );
    }

    @isTest
    private static void getValidatorResultRowVModelSObject() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        PermissionDefinitionModel permissionDefinitionModel = new SObjectPermissionsDefinitionModel(
            'featureName',
            'sObjectType',
            true,
            true,
            true,
            true
        );

        SObjectPermissionsModel sObjectPermissionsModel = new SObjectPermissionsModel(
            'sObjectType',
            false,
            false,
            false,
            false
        );

        Map<String, ApexClassModel> apexClassModelByName = new Map<String, ApexClassModel>();

        Map<String, SObjectPermissionsModel> sObjectAccessModelMap = new Map<String, SObjectPermissionsModel>{
            sObjectPermissionsModel.sObjectType => sObjectPermissionsModel
        };

        Map<String, SObjectFieldPermissionsModel> sObjectFieldAccessModelMap = new Map<String, SObjectFieldPermissionsModel>();

        Test.startTest();
        ValidatorResultRowVModel validatorResultRowVModel = validatorFeatureResultVMapper.getValidatorResultRowVModel(
            permissionDefinitionModel,
            apexClassModelByName,
            sObjectAccessModelMap,
            sObjectFieldAccessModelMap
        );
        Test.stopTest();

        System.assertNotEquals(
            null,
            validatorResultRowVModel,
            'A validator result row view model should be returned for a valid sObject Permissions model.'
        );
    }

    @isTest
    private static void getValidatorResultRowVModelSObjectField() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        PermissionDefinitionModel permissionDefinitionModel = new SObjectFieldPermissionsDefinitionModel(
            'featureName',
            'sObjectType',
            'sObjectFieldApiName',
            true,
            true
        );

        SObjectFieldPermissionsModel sObjectFieldPermissionsModel = new sObjectFieldPermissionsModel(
            'sObjectType',
            'sObjectType.sObjectFieldApiName',
            true,
            true
        );

        Map<String, ApexClassModel> apexClassModelByName = new Map<String, ApexClassModel>();

        Map<String, SObjectPermissionsModel> sObjectAccessModelMap = new Map<String, SObjectPermissionsModel>();

        Map<String, SObjectFieldPermissionsModel> sObjectFieldAccessModelMap = new Map<String, SObjectFieldPermissionsModel>{
            sObjectFieldPermissionsModel.name => sObjectFieldPermissionsModel
        };

        Test.startTest();
        ValidatorResultRowVModel validatorResultRowVModel = validatorFeatureResultVMapper.getValidatorResultRowVModel(
            permissionDefinitionModel,
            apexClassModelByName,
            sObjectAccessModelMap,
            sObjectFieldAccessModelMap
        );
        Test.stopTest();

        System.assertNotEquals(
            null,
            validatorResultRowVModel,
            'A validator result row view model should be returned for a valid sObject Field Permission model.'
        );
    }

    @isTest
    private static void getValidatorResultRowVModelNull() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        PermissionDefinitionModel permissionDefinitionModel = new UnknownPermDefinitionModelMock();

        Map<String, ApexClassModel> apexClassModelByName = new Map<String, ApexClassModel>();

        Map<String, SObjectPermissionsModel> sObjectAccessModelMap = new Map<String, SObjectPermissionsModel>();

        Map<String, SObjectFieldPermissionsModel> sObjectFieldAccessModelMap = new Map<String, SObjectFieldPermissionsModel>();

        try {
            Test.startTest();
            ValidatorResultRowVModel validatorResultRowVModel = validatorFeatureResultVMapper.getValidatorResultRowVModel(
                permissionDefinitionModel,
                apexClassModelByName,
                sObjectAccessModelMap,
                sObjectFieldAccessModelMap
            );
            Test.stopTest();

            System.assert(false, 'An illegal argument exception should always be thrown.');
        } catch (IllegalArgumentException iae) {
        }
    }

    @isTest
    private static void getValidatorResultRowVModelForApexClassNull() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        PermissionDefinitionModel permissionDefinitionModel = new ApexClassPermDefinitionModel(
            'featureName',
            'className',
            ''
        );

        Test.startTest();
        ValidatorResultRowVModel validatorResultRowVModel = validatorFeatureResultVMapper.getValidatorResultRowVModelForApexClass(
            permissionDefinitionModel,
            null
        );
        Test.stopTest();

        System.assertEquals(
            permissionDefinitionModel.getQualifiedFullName(),
            validatorResultRowVModel.id,
            'Model Id should match expected value.'
        );
        System.assertEquals(
            permissionDefinitionModel.getMetadataType(),
            validatorResultRowVModel.metadatatype,
            'Model metadata type should match expected value.'
        );
        System.assertEquals(
            permissionDefinitionModel.getQualifiedFullName(),
            validatorResultRowVModel.apiname,
            'Model api name should match expected value.'
        );
        System.assertEquals(false, validatorResultRowVModel.passed, 'Model status should match expected value.');
    }

    @isTest
    private static void getValidatorResultRowVModelForApexClassPass() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        PermissionDefinitionModel permissionDefinitionModel = new ApexClassPermDefinitionModel(
            'featureName',
            'className',
            ''
        );

        ApexClassModel apexClassModel = new ApexClassModel(Id.valueOf('000000000000000000'), 'className', '');

        Test.startTest();
        ValidatorResultRowVModel validatorResultRowVModel = validatorFeatureResultVMapper.getValidatorResultRowVModelForApexClass(
            permissionDefinitionModel,
            apexClassModel
        );
        Test.stopTest();

        System.assertEquals(
            permissionDefinitionModel.getQualifiedFullName(),
            validatorResultRowVModel.id,
            'Model Id should match expected value.'
        );
        System.assertEquals(
            permissionDefinitionModel.getMetadataType(),
            validatorResultRowVModel.metadatatype,
            'Model metadata type should match expected value.'
        );
        System.assertEquals(
            permissionDefinitionModel.getQualifiedFullName(),
            validatorResultRowVModel.apiname,
            'Model api name should match expected value.'
        );
        System.assertEquals(true, validatorResultRowVModel.passed, 'Model status should match expected value.');
    }

    @isTest
    private static void getValidatorResultRowVModelForSObjectNull() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        PermissionDefinitionModel permissionDefinitionModel = new SObjectPermissionsDefinitionModel(
            'featureName',
            'sObjectType',
            true,
            true,
            true,
            true
        );

        Test.startTest();
        ValidatorResultRowVModel validatorResultRowVModel = validatorFeatureResultVMapper.getValidatorResultRowVModelForSObject(
            permissionDefinitionModel,
            null
        );
        Test.stopTest();

        System.assertEquals(
            permissionDefinitionModel.getQualifiedFullName(),
            validatorResultRowVModel.id,
            'Model Id should match expected value.'
        );
        System.assertEquals(
            permissionDefinitionModel.getMetadataType(),
            validatorResultRowVModel.metadatatype,
            'Model metadata type should match expected value.'
        );
        System.assertEquals(
            permissionDefinitionModel.getQualifiedFullName(),
            validatorResultRowVModel.apiname,
            'Model api name should match expected value.'
        );
        System.assertEquals(false, validatorResultRowVModel.passed, 'Model status should match expected value.');
    }

    @isTest
    private static void getValidatorResultRowVModelForSObjectFail() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        PermissionDefinitionModel permissionDefinitionModel = new SObjectPermissionsDefinitionModel(
            'featureName',
            'sObjectType',
            true,
            true,
            true,
            true
        );

        SObjectPermissionsModel sObjectPermissionsModel = new SObjectPermissionsModel(
            'sObjectType',
            false,
            false,
            false,
            false
        );

        Test.startTest();
        ValidatorResultRowVModel validatorResultRowVModel = validatorFeatureResultVMapper.getValidatorResultRowVModelForSObject(
            permissionDefinitionModel,
            sObjectPermissionsModel
        );
        Test.stopTest();

        System.assertEquals(
            permissionDefinitionModel.getQualifiedFullName(),
            validatorResultRowVModel.id,
            'Model Id should match expected value.'
        );
        System.assertEquals(
            permissionDefinitionModel.getMetadataType(),
            validatorResultRowVModel.metadatatype,
            'Model metadata type should match expected value.'
        );
        System.assertEquals(
            permissionDefinitionModel.getQualifiedFullName(),
            validatorResultRowVModel.apiname,
            'Model api name should match expected value.'
        );
        System.assertEquals(false, validatorResultRowVModel.passed, 'Model status should match expected value.');
    }

    @isTest
    private static void getValidatorResultRowVModelForSObjectPass() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        PermissionDefinitionModel permissionDefinitionModel = new SObjectPermissionsDefinitionModel(
            'featureName',
            'sObjectType',
            true,
            true,
            true,
            true
        );

        SObjectPermissionsModel sObjectPermissionsModel = new SObjectPermissionsModel(
            'sObjectType',
            true,
            true,
            true,
            true
        );

        Test.startTest();
        ValidatorResultRowVModel validatorResultRowVModel = validatorFeatureResultVMapper.getValidatorResultRowVModelForSObject(
            permissionDefinitionModel,
            sObjectPermissionsModel
        );
        Test.stopTest();

        System.assertEquals(
            permissionDefinitionModel.getQualifiedFullName(),
            validatorResultRowVModel.id,
            'Model Id should match expected value.'
        );
        System.assertEquals(
            permissionDefinitionModel.getMetadataType(),
            validatorResultRowVModel.metadatatype,
            'Model metadata type should match expected value.'
        );
        System.assertEquals(
            permissionDefinitionModel.getQualifiedFullName(),
            validatorResultRowVModel.apiname,
            'Model api name should match expected value.'
        );
        System.assertEquals(true, validatorResultRowVModel.passed, 'Model status should match expected value.');
    }

    @isTest
    private static void getValidatorResultRowVModelForSObjectFieldNull() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        PermissionDefinitionModel permissionDefinitionModel = new SObjectFieldPermissionsDefinitionModel(
            'featureName',
            'sObjectType',
            'sObjectFieldApiName',
            true,
            true
        );

        Test.startTest();
        ValidatorResultRowVModel validatorResultRowVModel = validatorFeatureResultVMapper.getValidatorResultRowVModelForSObjectField(
            permissionDefinitionModel,
            null
        );
        Test.stopTest();

        System.assertEquals(
            permissionDefinitionModel.getQualifiedFullName(),
            validatorResultRowVModel.id,
            'Model Id should match expected value.'
        );
        System.assertEquals(
            permissionDefinitionModel.getMetadataType(),
            validatorResultRowVModel.metadatatype,
            'Model metadata type should match expected value.'
        );
        System.assertEquals(
            permissionDefinitionModel.getQualifiedFullName(),
            validatorResultRowVModel.apiname,
            'Model api name should match expected value.'
        );
        System.assertEquals(false, validatorResultRowVModel.passed, 'Model status should match expected value.');
    }

    @isTest
    private static void getValidatorResultRowVModelForSObjectFieldFail() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        PermissionDefinitionModel permissionDefinitionModel = new SObjectFieldPermissionsDefinitionModel(
            'featureName',
            'sObjectType',
            'sObjectFieldApiName',
            true,
            true
        );

        SObjectFieldPermissionsModel sObjectFieldPermissionsModel = new sObjectFieldPermissionsModel(
            'sObjectType',
            'sObjectType.sObjectFieldApiName',
            false,
            false
        );

        Test.startTest();
        ValidatorResultRowVModel validatorResultRowVModel = validatorFeatureResultVMapper.getValidatorResultRowVModelForSObjectField(
            permissionDefinitionModel,
            sObjectFieldPermissionsModel
        );
        Test.stopTest();

        System.assertEquals(
            permissionDefinitionModel.getQualifiedFullName(),
            validatorResultRowVModel.id,
            'Model Id should match expected value.'
        );
        System.assertEquals(
            permissionDefinitionModel.getMetadataType(),
            validatorResultRowVModel.metadatatype,
            'Model metadata type should match expected value.'
        );
        System.assertEquals(
            permissionDefinitionModel.getQualifiedFullName(),
            validatorResultRowVModel.apiname,
            'Model api name should match expected value.'
        );
        System.assertEquals(false, validatorResultRowVModel.passed, 'Model status should match expected value.');
    }

    @isTest
    private static void getValidatorResultRowVModelForSObjectFieldPass() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        PermissionDefinitionModel permissionDefinitionModel = new SObjectFieldPermissionsDefinitionModel(
            'featureName',
            'sObjectType',
            'sObjectFieldApiName',
            true,
            true
        );

        SObjectFieldPermissionsModel sObjectFieldPermissionsModel = new sObjectFieldPermissionsModel(
            'sObjectType',
            'sObjectType.sObjectFieldApiName',
            true,
            true
        );

        Test.startTest();
        ValidatorResultRowVModel validatorResultRowVModel = validatorFeatureResultVMapper.getValidatorResultRowVModelForSObjectField(
            permissionDefinitionModel,
            sObjectFieldPermissionsModel
        );
        Test.stopTest();

        System.assertEquals(
            permissionDefinitionModel.getQualifiedFullName(),
            validatorResultRowVModel.id,
            'Model Id should match expected value.'
        );
        System.assertEquals(
            permissionDefinitionModel.getMetadataType(),
            validatorResultRowVModel.metadatatype,
            'Model metadata type should match expected value.'
        );
        System.assertEquals(
            permissionDefinitionModel.getQualifiedFullName(),
            validatorResultRowVModel.apiname,
            'Model api name should match expected value.'
        );
        System.assertEquals(true, validatorResultRowVModel.passed, 'Model status should match expected value.');
    }

    @isTest
    private static void locateApexClassService() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        ApexClassService expectedApexClassService = ApexClassService.getInstance();

        Test.startTest();
        ApexClassService apexClassService = validatorFeatureResultVMapper.locateApexClassService();
        Test.stopTest();

        System.assertEquals(
            expectedApexClassService,
            apexClassService,
            'The Service located from the mapper should be that from service\'s instance method.'
        );
    }

    @isTest
    private static void locateApexClassAccessService() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        ApexClassAccessService expectedApexClassAccessService = ApexClassAccessService.getInstance();

        Test.startTest();
        ApexClassAccessService apexClassAccessService = validatorFeatureResultVMapper.locateApexClassAccessService();
        Test.stopTest();

        System.assertEquals(
            expectedApexClassAccessService,
            apexClassAccessService,
            'The Service located from the mapper should be that from service\'s instance method.'
        );
    }

    @isTest
    private static void locatePermissionDefinitionService() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        PermissionDefinitionService expectedPermissionDefinitionService = PermissionDefinitionService.getInstance();

        Test.startTest();
        PermissionDefinitionService permissionDefinitionService = validatorFeatureResultVMapper.locatePermissionDefinitionService();
        Test.stopTest();

        System.assertEquals(
            expectedPermissionDefinitionService,
            permissionDefinitionService,
            'The Service located from the mapper should be that from service\'s instance method.'
        );
    }

    @isTest
    private static void locatePermissionSetService() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        PermissionSetService expectedPermissionSetService = PermissionSetService.getInstance();

        Test.startTest();
        PermissionSetService permissionSetService = validatorFeatureResultVMapper.locatePermissionSetService();
        Test.stopTest();

        System.assertEquals(
            expectedPermissionSetService,
            permissionSetService,
            'The Service located from the mapper should be that from service\'s instance method.'
        );
    }

    @isTest
    private static void locateSObjectFieldPermissionsService() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        SObjectFieldPermissionsService expectedSObjectFieldPermissionsService = SObjectFieldPermissionsService.getInstance();

        Test.startTest();
        SObjectFieldPermissionsService sObjectFieldPermissionsService = validatorFeatureResultVMapper.locateSObjectFieldPermissionsService();
        Test.stopTest();

        System.assertEquals(
            expectedSObjectFieldPermissionsService,
            sObjectFieldPermissionsService,
            'The Service located from the mapper should be that from service\'s instance method.'
        );
    }

    @isTest
    private static void locateSObjectPermissionsService() {
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        SObjectPermissionsService expectedSObjectPermissionsService = SObjectPermissionsService.getInstance();

        Test.startTest();
        SObjectPermissionsService sObjectPermissionsService = validatorFeatureResultVMapper.locateSObjectPermissionsService();
        Test.stopTest();

        System.assertEquals(
            expectedSObjectPermissionsService,
            sObjectPermissionsService,
            'The Service located from the mapper should be that from service\'s instance method.'
        );
    }

    public virtual class ValidatorFeatureResultVMapperStub extends ValidatorFeatureResultVMapper {
        protected ValidatorFeatureResultVMapperStub() {
        }
        protected ValidatorFeatureResultVMapperStub(ValidatorRequirementState requirementState) {
            this.requirementState = requirementState;
        }

        private ValidatorRequirementState requirementState = ValidatorRequirementState.FOUND;

        @TestVisible
        protected override ValidatorResultRowVModel getValidatorResultRowVModelForApexClass(
            PermissionDefinitionModel permissionDefinitionModel,
            ApexClassModel apexClassModel
        ) {
            return new ValidatorResultRowVModel(
                permissionDefinitionModel.getQualifiedFullName(),
                permissionDefinitionModel.getMetadataType(),
                permissionDefinitionModel.getQualifiedFullName(),
                '',
                this.requirementState,
                this.requirementState,
                this.requirementState,
                this.requirementState
            );
        }

        @TestVisible
        protected override ValidatorResultRowVModel getValidatorResultRowVModelForSObject(
            PermissionDefinitionModel permissionDefinitionModel,
            SObjectPermissionsModel sObjectPermissionsModel
        ) {
            return new ValidatorResultRowVModel(
                permissionDefinitionModel.getQualifiedFullName(),
                permissionDefinitionModel.getMetadataType(),
                permissionDefinitionModel.getQualifiedFullName(),
                '',
                this.requirementState,
                this.requirementState,
                this.requirementState,
                this.requirementState
            );
        }

        @TestVisible
        protected override ValidatorResultRowVModel getValidatorResultRowVModelForSObjectField(
            PermissionDefinitionModel permissionDefinitionModel,
            SObjectFieldPermissionsModel sObjectFieldPermissionsModel
        ) {
            return new ValidatorResultRowVModel(
                permissionDefinitionModel.getQualifiedFullName(),
                permissionDefinitionModel.getMetadataType(),
                permissionDefinitionModel.getQualifiedFullName(),
                '',
                this.requirementState,
                this.requirementState,
                this.requirementState,
                this.requirementState
            );
        }
    }

    public virtual class ApexClassAccessServiceStub extends ApexClassAccessService {
        protected ApexClassAccessServiceStub() {
        }

        public override Map<Id, ApexClassAccessModel> getModelMapFromPermissionSetIdListAndClassIdList(
            List<Id> permissionSetIdList,
            List<Id> apexClassIdList
        ) {
            Map<Id, ApexClassAccessModel> apexClassAccessModelMap = new Map<Id, ApexClassAccessModel>();

            ApexClassAccessModel apexClassAccessModel = new ApexClassAccessModel(Id.valueOf('000000000000000000'));

            apexClassAccessModelMap.put(apexClassAccessModel.apexClassId, apexClassAccessModel);

            return apexClassAccessModelMap;
        }
    }

    public virtual class ApexClassServiceStub extends ApexClassService {
        protected ApexClassServiceStub() {
        }

        public override Map<Id, ApexClassModel> getApexClassModelMap(
            List<String> apexClassNameList,
            List<String> namespacePrefix
        ) {
            Map<Id, ApexClassModel> apexClassModelMap = new Map<Id, ApexClassModel>();

            ApexClassModel apexClassModel = new ApexClassModel(Id.valueOf('000000000000000000'), 'className', '');

            apexClassModelMap.put(apexClassModel.classId, apexClassModel);

            return apexClassModelMap;
        }
    }

    public virtual class PermissionDefinitionServiceStub extends PermissionDefinitionService {
        protected PermissionDefinitionServiceStub() {
        }

        public override List<PermissionDefinitionModel> getPermissionDefinitionModelListByFeatureName(
            String featureName
        ) {
            List<PermissionDefinitionModel> permissionDefinitionModelList = new List<PermissionDefinitionModel>();

            permissionDefinitionModelList.add(new ApexClassPermDefinitionModel('featureName', 'className', ''));

            permissionDefinitionModelList.add(
                new SObjectPermissionsDefinitionModel('featureName', 'sObjectType', true, true, true, true)
            );

            permissionDefinitionModelList.add(
                new SObjectFieldPermissionsDefinitionModel(
                    'featureName',
                    'sObjectType',
                    'sObjectFieldApiName',
                    true,
                    true
                )
            );

            return permissionDefinitionModelList;
        }
    }

    public virtual class PermissionSetServiceStub extends PermissionSetService {
        protected PermissionSetServiceStub() {
        }

        public override PermissionSetModel getModelFromProfileId(Id profileId) {
            PermissionSetModel permissionSetModel = new PermissionSetModel(
                Id.valueOf('000000000000000000'),
                'testlabel',
                'testname'
            );

            return permissionSetModel;
        }

        public override Map<Id, PermissionSetModel> getModelsFromPermissionSetGroupIdList(
            List<Id> permissionSetGroupIds
        ) {
            PermissionSetModel permissionSetModel = new PermissionSetModel(
                Id.valueOf('000000000000000000'),
                'testlabel',
                'testname'
            );
            return new Map<Id, PermissionSetModel>{ Id.valueOf('000000000000000000') => permissionSetModel };
        }
    }

    public virtual class SObjectPermissionsServiceStub extends SObjectPermissionsService {
        protected SObjectPermissionsServiceStub() {
        }

        public override Map<String, SObjectPermissionsModel> getModelMapFromPermissionSetIdListAndSObjectNameList(
            List<Id> permissionSetIdList,
            List<String> sObjectTypeList
        ) {
            Map<String, SObjectPermissionsModel> sObjectPermissionsModelMap = new Map<String, SObjectPermissionsModel>();

            SObjectPermissionsModel sObjectPermissionsModel = new SObjectPermissionsModel(
                'sObjectType',
                true,
                true,
                true,
                true
            );

            sObjectPermissionsModelMap.put(sObjectPermissionsModel.SObjectType, SObjectPermissionsModel);

            return sObjectPermissionsModelMap;
        }
    }

    public virtual class SObjectFieldPermissionsServiceStub extends SObjectFieldPermissionsService {
        protected SObjectFieldPermissionsServiceStub() {
        }

        public override Map<String, SObjectFieldPermissionsModel> getModelMapFromDefinitionLists(
            List<Id> permissionSetIdList,
            List<String> nameList
        ) {
            Map<String, SObjectFieldPermissionsModel> sObjectFieldPermissionsModelMap = new Map<String, SObjectFieldPermissionsModel>();

            SObjectFieldPermissionsModel sObjectFieldPermissionsModel = new SObjectFieldPermissionsModel(
                'sObjectType',
                'sObjectType.sObjectFieldApiName',
                false,
                false
            );

            sObjectFieldPermissionsModelMap.put(sObjectFieldPermissionsModel.name, sObjectFieldPermissionsModel);

            return sObjectFieldPermissionsModelMap;
        }
    }

    public class UnknownPermDefinitionModelMock extends PermissionDefinitionModel {
        public UnknownPermDefinitionModelMock() {
            super();
        }

        public override String getRequiredAccess(
            Boolean createAccess,
            Boolean readAccess,
            Boolean updateAccess,
            Boolean deleteAccess
        ) {
            return '';
        }

        public override String getMetadataType() {
            return 'Unknown';
        }
    }
}
