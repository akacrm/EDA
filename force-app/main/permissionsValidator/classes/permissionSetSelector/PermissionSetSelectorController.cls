public with sharing class PermissionSetSelectorController {
    @AuraEnabled(cacheable=true)
    public static PermissionSetSelectorVModel getViewModel() {
        try {
            return locatePermissionSetSelectorVMapper().getViewModel();
        } catch (NoAccessException nae) {
            throw new AuraHandledException(Label.errorInsufficientAccess);
        }
    }

    @TestVisible
    private static PermissionSetSelectorVMapper locatePermissionSetSelectorVMapper() {
        return PermissionSetSelectorVMapper.getInstance();
    }
}
