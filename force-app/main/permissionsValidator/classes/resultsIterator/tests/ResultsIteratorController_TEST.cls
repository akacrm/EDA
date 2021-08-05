@isTest
private class ResultsIteratorController_TEST {
    @isTest
    private static void getViewModel() {
        ValidatorFeatureResultVMapper.instance = new ValidatorFeatureResultVMapperStub();

        Id profileId = Id.valueOf('000000000000000000');

        ValidatorFeatureResultVModel expectedViewModel = ValidatorFeatureResultVMapper.getInstance()
            .getViewModel('Test1', true, profileId, new List<Id>(), new List<Id>());

        Test.startTest();
        ValidatorFeatureResultVModel viewModel = ResultsIteratorController.getViewModel(
            'Test1',
            true,
            profileId,
            new List<Id>(),
            new List<Id>()
        );
        Test.stopTest();

        System.assertEquals(
            expectedViewModel.name,
            viewModel.name,
            'View Model\'s name from the controller should be equal to that of the mapper\'s.'
        );
        System.assertEquals(
            expectedViewModel.icon,
            viewModel.icon,
            'View Model\'s icon from the controller should be equal to that of the mapper\'s.'
        );
        System.assertEquals(
            expectedViewModel.status,
            viewModel.status,
            'View Model\'s status from the controller should be equal to that of the mapper\'s.'
        );
        System.assertEquals(
            expectedViewModel.tableData.size(),
            viewModel.tableData.size(),
            'View Model\'s table data size from the controller should be equal to that of the mapper\'s.'
        );
    }

    @isTest
    private static void getViewModelNoAccess() {
        ValidatorFeatureResultVMapper.instance = new ValidatorFeatureResultVMapperNoAccesStub();
        Id profileId = Id.valueOf('000000000000000000');

        try {
            Test.startTest();
            ValidatorFeatureResultVModel viewModel = ResultsIteratorController.getViewModel(
                'Test1',
                true,
                profileId,
                new List<Id>(),
                new List<Id>()
            );
            Test.stopTest();

            System.assert(false, 'An aura handled exception should always be thrown on a caught exception.');
        } catch (AuraHandledException ahe) {
        }
    }

    @isTest
    private static void getViewModelIllegalArgument() {
        ValidatorFeatureResultVMapper.instance = new ValidatorFeatureResultVMapperIlglArgStub();
        Id profileId = Id.valueOf('000000000000000000');

        try {
            Test.startTest();
            ValidatorFeatureResultVModel viewModel = ResultsIteratorController.getViewModel(
                'Test1',
                true,
                profileId,
                new List<Id>(),
                new List<Id>()
            );
            Test.stopTest();

            System.assert(false, 'An aura handled exception should always be thrown on a caught exception.');
        } catch (AuraHandledException ahe) {
        }
    }

    @isTest
    private static void locateValidatorFeatureResultVMapper() {
        ValidatorFeatureResultVMapper expectedValidatorFeatureResultVMapper = ValidatorFeatureResultVMapper.getInstance();

        Test.startTest();
        ValidatorFeatureResultVMapper validatorFeatureResultVMapper = ResultsIteratorController.locateValidatorFeatureResultVMapper();
        Test.stopTest();

        System.assertEquals(
            expectedValidatorFeatureResultVMapper,
            validatorFeatureResultVMapper,
            'The Validator Feature Result View Model Mapper located from the controller should be that from mappers\'s instance method.'
        );
    }

    public virtual class ValidatorFeatureResultVMapperStub extends ValidatorFeatureResultVMapper {
        protected ValidatorFeatureResultVMapperStub() {
        }

        public override ValidatorFeatureResultVModel getViewModel(
            String featureName,
            Boolean showAll,
            String profileIdString,
            List<Id> permissionSetIdListFromCaller,
            List<Id> permissionSetGroupIdList
        ) {
            List<ValidatorResultRowVModel> tableDataTest1 = new List<ValidatorResultRowVModel>();

            tableDataTest1.add(
                new ValidatorResultRowVModel(
                    'Apex Class.testclass',
                    'Apex Class',
                    'testclass',
                    'Description',
                    ValidatorRequirementState.FOUND,
                    ValidatorRequirementState.FOUND,
                    ValidatorRequirementState.FOUND,
                    ValidatorRequirementState.FOUND
                )
            );

            return new ValidatorFeatureResultVModel(
                'Test1',
                'utility:success',
                'Pass',
                Label.allAccessMetStatus,
                tableDataTest1
            );
        }
    }

    public virtual class ValidatorFeatureResultVMapperNoAccesStub extends ValidatorFeatureResultVMapper {
        protected ValidatorFeatureResultVMapperNoAccesStub() {
        }

        public override ValidatorFeatureResultVModel getViewModel(
            String featureName,
            Boolean showAll,
            String profileIdString,
            List<Id> permissionSetIdListFromCaller,
            List<Id> permissionSetGroupIdList
        ) {
            throw new NoAccessException();
        }
    }

    public virtual class ValidatorFeatureResultVMapperIlglArgStub extends ValidatorFeatureResultVMapper {
        protected ValidatorFeatureResultVMapperIlglArgStub() {
        }

        public override ValidatorFeatureResultVModel getViewModel(
            String featureName,
            Boolean showAll,
            String profileIdString,
            List<Id> permissionSetIdListFromCaller,
            List<Id> permissionSetGroupIdList
        ) {
            throw new IllegalArgumentException();
        }
    }
}
