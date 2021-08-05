@isTest
private class ApexClassMapper_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        ApexClassMapper apexClassMapperinstance = ApexClassMapper.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, apexClassMapperinstance, 'Mapper instance should not be null.');
        System.assertEquals(
            ApexClassMapper.instance,
            apexClassMapperinstance,
            'Mapper instance should equal the apex class mapper instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        ApexClassMapper apexClassMapperInstance = ApexClassMapper.getInstance();

        Test.startTest();
        ApexClassMapper apexClassMapperGetInstance = ApexClassMapper.instance;
        Test.stopTest();

        System.assertEquals(
            apexClassMapperInstance,
            apexClassMapperGetInstance,
            'Retrieved Mapper instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void getApexClassModelList() {
        ApexClassMapper apexClassMapper = ApexClassMapper.getInstance();

        List<String> apexClassNameList = new List<String>{ 'ApexClassMapper', 'ApexClassModel' };

        String namespace = NamespaceService.getInstance().handleLocalNamespace('hed');

        List<String> namespaceList = new List<String>();
        namespaceList.add(namespace);

        Map<Id, ApexClass> apexClassMap = new Map<Id, ApexClass>(
            [
                SELECT Id, Name, NamespacePrefix
                FROM ApexClass
                WHERE Name IN :apexClassNameList AND NamespacePrefix IN :namespaceList
            ]
        );

        Test.startTest();
        Map<Id, ApexClassModel> apexClassModelMap = apexClassMapper.getApexClassModelMap(
            apexClassNameList,
            namespaceList
        );
        Test.stopTest();

        System.assertEquals(
            apexClassMap.size(),
            apexClassModelMap.size(),
            'The number of Apex Class Models should not equal the number queried.'
        );

        for (Id apexClassId : apexClassMap.keySet()) {
            ApexClass apexClass = apexClassMap.get(apexClassId);
            ApexClassModel apexClassModel = apexClassModelMap.get(apexClassId);
            System.assertNotEquals(null, apexClassModel, 'Each apex class should have a corresponding model.');

            System.assertEquals(
                apexClass.Id,
                apexClassModel.classId,
                'The apex class model\'s Class Id should match that of the apex class.'
            );
            System.assertEquals(
                apexClass.Name,
                apexClassModel.name,
                'The apex class model\'s Name should match that of the apex class.'
            );
            System.assertEquals(
                apexClass.NamespacePrefix,
                apexClassModel.namespacePrefix,
                'The apex class model\'s NamespacePrefix should match that of the apex class.'
            );
        }
    }
}
