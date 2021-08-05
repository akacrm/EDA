public virtual with sharing class ApexClassAccessService {
    @TestVisible
    private static ApexClassAccessService instance;

    protected ApexClassAccessService() {
    }

    public static ApexClassAccessService getInstance() {
        if (instance == null) {
            instance = new ApexClassAccessService();
        }

        return instance;
    }

    public virtual Map<Id, ApexClassAccessModel> getModelMapFromPermissionSetIdListAndClassIdList(
        List<Id> permissionSetIdList,
        List<Id> apexClassIdList
    ) {
        return this.locateApexClassAccessMapper()
            .getModelMapFromPermissionSetIdListAndClassIdList(permissionSetIdList, apexClassIdList);
    }

    @TestVisible
    private ApexClassAccessMapper locateApexClassAccessMapper() {
        return ApexClassAccessMapper.getInstance();
    }
}
