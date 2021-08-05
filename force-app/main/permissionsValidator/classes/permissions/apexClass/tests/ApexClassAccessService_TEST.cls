@isTest
private class ApexClassAccessService_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        ApexClassAccessService apexClassAccessServiceInstance = ApexClassAccessService.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, apexClassAccessServiceinstance, 'Service instance should not be null.');
        System.assertEquals(
            ApexClassAccessService.instance,
            apexClassAccessServiceinstance,
            'Service instance should equal the apex class service instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        ApexClassAccessService apexClassAccessServiceInstance = ApexClassAccessService.getInstance();

        Test.startTest();
        ApexClassAccessService apexClassAccessServiceGetInstance = ApexClassAccessService.instance;
        Test.stopTest();

        System.assertEquals(
            apexClassAccessServiceInstance,
            apexClassAccessServiceGetInstance,
            'Retrieved Service instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getModelMapByPermissionSetIdList() {
        ApexClassAccessMapper.instance = new ApexClassAccessMapperStub();
        List<Id> permissionSetIdList = new List<Id>{ Id.valueOf('000000000000000000') };
        List<Id> apexClassIdList = new List<Id>{ Id.valueOf('000000000000000000') };

        Test.startTest();
        Map<Id, ApexClassAccessModel> apexClassAccessById = ApexClassAccessService.getInstance()
            .getModelMapFromPermissionSetIdListAndClassIdList(permissionSetIdList, apexClassIdList);
        Test.stopTest();

        System.assertEquals(
            apexClassIdList.size(),
            apexClassAccessById.size(),
            'The number of Apex Class Access Models should equal that of the Permission Sets\' Apex Class access.'
        );
    }

    @isTest
    private static void locateApexClassAccessMapper() {
        ApexClassAccessService apexClassAccessService = ApexClassAccessService.getInstance();

        ApexClassAccessMapper expectedApexClassAccessMapper = ApexClassAccessMapper.getInstance();

        Test.startTest();
        ApexClassAccessMapper apexClassAccessMapper = apexClassAccessService.locateApexClassAccessMapper();
        Test.stopTest();

        System.assertEquals(
            expectedApexClassAccessMapper,
            apexClassAccessMapper,
            'The Apex Class Access Mapper located from the service should be that from mapper\'s instance method.'
        );
    }

    public virtual class ApexClassAccessMapperStub extends ApexClassAccessMapper {
        protected ApexClassAccessMapperStub() {
        }

        public override Map<Id, ApexClassAccessModel> getModelMapFromPermissionSetIdListAndClassIdList(
            List<Id> permissionSetIdList,
            List<Id> apexClassIdList
        ) {
            Map<Id, ApexClassAccessModel> apexClassAccessById = new Map<Id, ApexClassAccessModel>();

            ApexClassAccessModel apexClassAccessModel = new ApexClassAccessModel('000000000000000000');

            apexClassAccessById.put(apexClassAccessModel.apexClassId, apexClassAccessModel);

            return apexClassAccessById;
        }
    }
}
