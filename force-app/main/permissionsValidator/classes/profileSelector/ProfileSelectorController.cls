public with sharing class ProfileSelectorController {
    @AuraEnabled(cacheable=true)
    public static ProfileSelectorVModel getViewModel() {
        try {
            return locateProfileSelectorVMapper().getViewModel();
        } catch (NoAccessException nae) {
            throw new AuraHandledException(Label.errorInsufficientAccess);
        }
    }

    @TestVisible
    private static ProfileSelectorVMapper locateProfileSelectorVMapper() {
        return ProfileSelectorVMapper.getInstance();
    }
}
