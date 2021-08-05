public virtual with sharing class ApexClassMapper {
    @TestVisible
    private static ApexClassMapper instance;

    protected ApexClassMapper() {
    }

    public static ApexClassMapper getInstance() {
        if (instance == null) {
            instance = new ApexClassMapper();
        }

        return instance;
    }

    public virtual Map<Id, ApexClassModel> getApexClassModelMap(
        List<String> apexClassNameList,
        List<String> namespacePrefix
    ) {
        SecurityService.getInstance().assertViewSetupPermissionForCurrentUser();
        List<ApexClass> apexClassList = [
            SELECT Id, Name, NamespacePrefix
            FROM ApexClass
            WHERE Name IN :apexClassNameList AND namespacePrefix IN :namespacePrefix
        ];

        Map<Id, ApexClassModel> apexClassModelMap = new Map<Id, ApexClassModel>();

        for (ApexClass apexClass : apexClassList) {
            ApexClassModel apexClassModel = new ApexClassModel(apexClass.Id, apexClass.Name, apexClass.NamespacePrefix);

            apexClassModelMap.put(apexClass.Id, apexClassModel);
        }

        return apexClassModelMap;
    }
}
