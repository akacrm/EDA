public with sharing class PermissionsValidatorController {
    @AuraEnabled
    public static List<String> getFeatureNames() {
        try {
            List<PermissionDefinitionModel> permissionDefinitionModelList = PermissionsValidatorController.locatePermissionDefinitionService()
                .getPermissionDefinitionModelListByFeatureName('%');

            return PermissionsValidatorController.locatePermissionDefinitionService()
                .getFeatureNamesFromModelList(permissionDefinitionModelList);
        } catch (IllegalArgumentException iae) {
            throw new AuraHandledException(Label.errorInvalidPermissionDefinition);
        } catch (NoAccessException nae) {
            throw new AuraHandledException(Label.errorInsufficientAccess);
        }
    }

    @TestVisible
    private static PermissionDefinitionService locatePermissionDefinitionService() {
        return PermissionDefinitionService.getInstance();
    }
}
