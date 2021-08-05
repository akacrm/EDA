public virtual with sharing class SObjectPermissionsService {
    @TestVisible
    private static SObjectPermissionsService instance;

    protected SObjectPermissionsService() {
    }

    public static SObjectPermissionsService getInstance() {
        if (instance == null) {
            instance = new SObjectPermissionsService();
        }

        return instance;
    }

    public virtual Map<String, SObjectPermissionsModel> getModelMapFromPermissionSetIdListAndSObjectNameList(
        List<Id> permissionSetIdList,
        List<String> sObjectTypeList
    ) {
        return this.locateSObjectPermissionsMapper()
            .getModelMapFromPermissionSetIdListAndSObjectNameList(permissionSetIdList, sObjectTypeList);
    }

    @TestVisible
    private SObjectPermissionsMapper locateSObjectPermissionsMapper() {
        return SObjectPermissionsMapper.getInstance();
    }
}
