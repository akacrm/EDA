public virtual with sharing class SObjectFieldPermissionsService {
    @TestVisible
    private static SObjectFieldPermissionsService instance;

    protected SObjectFieldPermissionsService() {
    }

    public static SObjectFieldPermissionsService getInstance() {
        if (instance == null) {
            instance = new SObjectFieldPermissionsService();
        }

        return instance;
    }

    public virtual Map<String, SObjectFieldPermissionsModel> getModelMapFromDefinitionLists(
        List<Id> permissionSetIdList,
        List<String> nameList
    ) {
        return this.locateSObjectFieldPermissionsMapper().getModelMapFromDefinitionLists(permissionSetIdList, nameList);
    }

    @TestVisible
    private SObjectFieldPermissionsMapper locateSObjectFieldPermissionsMapper() {
        return SObjectFieldPermissionsMapper.getInstance();
    }
}
