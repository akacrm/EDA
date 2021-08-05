public virtual with sharing class ApexClassService {
    @TestVisible
    private static ApexClassService instance;

    protected ApexClassService() {
    }

    public static ApexClassService getInstance() {
        if (instance == null) {
            instance = new ApexClassService();
        }

        return instance;
    }

    public virtual Map<Id, ApexClassModel> getApexClassModelMap(
        List<String> apexClassNameList,
        List<String> namespacePrefix
    ) {
        return this.locateApexClassMapper().getApexClassModelMap(apexClassNameList, namespacePrefix);
    }

    @TestVisible
    private ApexClassMapper locateApexClassMapper() {
        return ApexClassMapper.getInstance();
    }
}
