public with sharing class PermissionSetGroupSelectorController {
    @AuraEnabled(cacheable=true)
    public static PermissionSetGroupSelectorVModel getViewModel() {
        try {
            return locatePermissionSetGroupSelectorVMapper().getViewModel();
        } catch (NoAccessException nae) {
            throw new AuraHandledException(Label.errorInsufficientAccess);
        }
    }

    @TestVisible
    private static PermissionSetGroupSelectorVMapper locatePermissionSetGroupSelectorVMapper() {
        return PermissionSetGroupSelectorVMapper.getInstance();
    }
}
