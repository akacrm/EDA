@isTest
private class ApexClassService_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        ApexClassService apexClassServiceInstance = ApexClassService.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, apexClassServiceinstance, 'Service instance should not be null.');
        System.assertEquals(
            ApexClassService.instance,
            apexClassServiceinstance,
            'Service instance should equal the apex class service instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        ApexClassService apexClassServiceInstance = ApexClassService.getInstance();

        Test.startTest();
        ApexClassService apexClassServiceGetInstance = ApexClassService.instance;
        Test.stopTest();

        System.assertEquals(
            apexClassServiceInstance,
            apexClassServiceGetInstance,
            'Retrieved Service instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getApexClassModelMap() {
        ApexClassService apexClassService = ApexClassService.getInstance();

        ApexClassMapper.instance = new ApexClassMapperStub();

        List<String> apexClassNameList = new List<String>{ 'ApexClassMapper', 'ApexClassModel' };

        Test.startTest();
        Map<Id, ApexClassModel> apexClassModelMap = apexClassService.getApexClassModelMap(
            apexClassNameList,
            new List<String>()
        );
        Test.stopTest();

        System.assertEquals(
            apexClassNameList.size(),
            apexClassModelMap.size(),
            'The number of Apex Class Models should not equal the number requested.'
        );

        for (ApexClassModel apexClassModel : apexClassModelMap.values()) {
            System.assert(
                apexClassNameList.contains(apexClassModel.name),
                'The apex class model\'s Name should be in the list of requested class name.'
            );
        }
    }

    @isTest
    private static void locateApexClassMapper() {
        ApexClassService apexClassService = ApexClassService.getInstance();

        ApexClassMapper expectedApexClassMapper = ApexClassMapper.getInstance();

        Test.startTest();
        ApexClassMapper apexClassMapper = apexClassService.locateApexClassMapper();
        Test.stopTest();

        System.assertEquals(
            expectedApexClassMapper,
            apexClassMapper,
            'The Apex Class Mapper located from the service should be that from mapper\'s instance method.'
        );
    }

    public virtual class ApexClassMapperStub extends ApexClassMapper {
        protected ApexClassMapperStub() {
        }

        public override Map<Id, ApexClassModel> getApexClassModelMap(
            List<String> apexClassNameList,
            List<String> namespacePrefix
        ) {
            Map<Id, ApexClassModel> apexClassModelMap = new Map<Id, ApexClassModel>();

            for (Integer i = 0; i < apexClassNameList.size(); i++) {
                ApexClassModel apexClassModel = new ApexClassModel(
                    Id.valueOf(String.valueOf(i).leftPad(18, '0')),
                    apexClassNameList[i],
                    String.valueOf(i)
                );

                apexClassModelMap.put(apexClassModel.classId, apexClassModel);
            }

            return apexClassModelMap;
        }
    }
}
