public with sharing class ResultsIteratorController {
    @AuraEnabled(cacheable=true)
    public static ValidatorFeatureResultVModel getViewModel(
        String featureName,
        Boolean showAll,
        String profileId,
        List<Id> permissionSetIdList,
        List<Id> permissionSetGroupIdList
    ) {
        try {
            return ResultsIteratorController.locateValidatorFeatureResultVMapper()
                .getViewModel(featureName, showAll, profileId, permissionSetIdList, permissionSetGroupIdList);
        } catch (IllegalArgumentException iae) {
            throw new AuraHandledException(Label.errorInvalidPermissionDefinition);
        } catch (NoAccessException nae) {
            throw new AuraHandledException(Label.errorInsufficientAccess);
        }
    }

    @TestVisible
    private static ValidatorFeatureResultVMapper locateValidatorFeatureResultVMapper() {
        return ValidatorFeatureResultVMapper.getInstance();
    }
}
