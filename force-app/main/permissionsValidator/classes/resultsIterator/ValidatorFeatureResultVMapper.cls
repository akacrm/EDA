public virtual with sharing class ValidatorFeatureResultVMapper {
    @TestVisible
    private static ValidatorFeatureResultVMapper instance;

    protected ValidatorFeatureResultVMapper() {
    }

    public static ValidatorFeatureResultVMapper getInstance() {
        if (instance == null) {
            instance = new ValidatorFeatureResultVMapper();
        }

        return instance;
    }

    public virtual ValidatorFeatureResultVModel getViewModel(
        String featureName,
        Boolean showAll,
        String profileIdString,
        List<Id> permissionSetIdListFromCaller,
        List<Id> permissionSetGroupIdList
    ) {
        List<Id> permissionSetIdList = this.locatePermissionSetService()
            .getCombinedPermissionSetIdList(
                (String.isBlank(profileIdString) ? null : Id.valueOf(profileIdString)),
                permissionSetIdListFromCaller,
                permissionSetGroupIdList
            );

        List<PermissionDefinitionModel> permissionDefinitionModelList = this.locatePermissionDefinitionService()
            .getPermissionDefinitionModelListByFeatureName(featureName);

        Map<String, PermissionDefinitionService.TypeStringCollection> typeStringCollectionByTypeFromModelList = this.locatePermissionDefinitionService()
            .getTypeStringCollectionByTypeFromModelList(permissionDefinitionModelList);

        Map<String, ApexClassModel> apexClassModelByName = this.getApexClassAccessByName(
            typeStringCollectionByTypeFromModelList.get('Apex Class'),
            permissionSetIdList
        );

        Map<String, SObjectPermissionsModel> sObjectAccessModelMap = this.locateSObjectPermissionsService()
            .getModelMapFromPermissionSetIdListAndSObjectNameList(
                permissionSetIdList,
                typeStringCollectionByTypeFromModelList.get('SObject').apiNameList
            );

        Map<String, SObjectFieldPermissionsModel> sObjectFieldAccessModelMap = this.locateSObjectFieldPermissionsService()
            .getModelMapFromDefinitionLists(
                permissionSetIdList,
                typeStringCollectionByTypeFromModelList.get('SObjectField').apiNameList
            );

        List<ValidatorResultRowVModel> tableData = new List<ValidatorResultRowVModel>();

        Boolean failureDetected = false;

        for (PermissionDefinitionModel permissionDefinitionModel : permissionDefinitionModelList) {
            ValidatorResultRowVModel validatorResultRowVModel = this.getValidatorResultRowVModel(
                permissionDefinitionModel,
                apexClassModelByName,
                sObjectAccessModelMap,
                sObjectFieldAccessModelMap
            );

            if (showAll || !validatorResultRowVModel.passed) {
                tableData.add(validatorResultRowVModel);
            }

            if (!validatorResultRowVModel.passed) {
                failureDetected = true;
            }
        }

        tableData.sort();

        ValidatorFeatureResultVModel validatorFeatureResultVModel = new ValidatorFeatureResultVModel(
            featureName,
            (failureDetected ? 'utility:error' : 'utility:success'),
            (failureDetected ? 'Fail' : 'Pass'),
            (failureDetected ? Label.missingAccessStatus : Label.allAccessMetStatus),
            tableData
        );

        return validatorFeatureResultVModel;
    }

    @TestVisible
    protected virtual Map<String, ApexClassModel> getApexClassAccessByName(
        PermissionDefinitionService.TypeStringCollection apexClassTypeStringCollection,
        List<Id> permissionSetIdList
    ) {
        Map<Id, ApexClassModel> apexClassModelMap = this.locateApexClassService()
            .getApexClassModelMap(
                apexClassTypeStringCollection.apiNameList,
                apexClassTypeStringCollection.namespacePrefixList
            );

        Map<Id, ApexClassAccessModel> apexClassAccessModelById = this.locateApexClassAccessService()
            .getModelMapFromPermissionSetIdListAndClassIdList(
                permissionSetIdList,
                new List<Id>(apexClassModelMap.keySet())
            );

        Map<String, ApexClassModel> apexClassModelByName = new Map<String, ApexClassModel>();

        for (Id apexClassAccessModelId : apexClassAccessModelById.keySet()) {
            apexClassModelByName.put(
                apexClassModelMap.get(apexClassAccessModelId).getQualifiedName(),
                apexClassModelMap.get(apexClassAccessModelId)
            );
        }

        return apexClassModelByName;
    }

    @TestVisible
    protected virtual ValidatorResultRowVModel getValidatorResultRowVModel(
        PermissionDefinitionModel permissionDefinitionModel,
        Map<String, ApexClassModel> apexClassModelByName,
        Map<String, SObjectPermissionsModel> sObjectAccessModelMap,
        Map<String, SObjectFieldPermissionsModel> sObjectFieldAccessModelMap
    ) {
        switch on permissionDefinitionModel.getMetadataType() {
            when 'Apex Class' {
                return this.getValidatorResultRowVModelForApexClass(
                    permissionDefinitionModel,
                    apexClassModelByName.get(permissionDefinitionModel.getQualifiedName())
                );
            }
            when 'SObject' {
                return this.getValidatorResultRowVModelForSObject(
                    permissionDefinitionModel,
                    sObjectAccessModelMap.get(permissionDefinitionModel.getQualifiedFullName())
                );
            }
            when 'SObjectField' {
                return this.getValidatorResultRowVModelForSObjectField(
                    permissionDefinitionModel,
                    sObjectFieldAccessModelMap.get(permissionDefinitionModel.getQualifiedFullName())
                );
            }
        }

        throw new IllegalArgumentException();
    }

    @TestVisible
    protected virtual ValidatorResultRowVModel getValidatorResultRowVModelForApexClass(
        PermissionDefinitionModel permissionDefinitionModel,
        ApexClassModel apexClassModel
    ) {
        ValidatorRequirementState readState = ValidatorRequirementState.FOUND;
        String description = '';

        if (apexClassModel == null) {
            readState = ValidatorRequirementState.MISSING;
            description = permissionDefinitionModel.getRequiredAccess(false, true, false, false);
        }

        return new ValidatorResultRowVModel(
            permissionDefinitionModel.getQualifiedFullName(),
            permissionDefinitionModel.getMetadataType(),
            permissionDefinitionModel.getQualifiedFullName(),
            description,
            ValidatorRequirementState.NOT_REQUIRED,
            readState,
            ValidatorRequirementState.NOT_REQUIRED,
            ValidatorRequirementState.NOT_REQUIRED
        );
    }

    @TestVisible
    protected virtual ValidatorResultRowVModel getValidatorResultRowVModelForSObject(
        PermissionDefinitionModel permissionDefinitionModel,
        SObjectPermissionsModel sObjectPermissionsModel
    ) {
        String description = '';

        Boolean canCreate = false;
        Boolean canRead = false;
        Boolean canUpdate = false;
        Boolean canDelete = false;

        if (sObjectPermissionsModel != null) {
            canCreate = sObjectPermissionsModel.canCreate;
            canRead = sObjectPermissionsModel.canRead;
            canUpdate = sObjectPermissionsModel.canUpdate;
            canDelete = sObjectPermissionsModel.canDelete;
        }

        PermissionDefinitionModel.AccessCheck accessCheck = permissionDefinitionModel.hasRequiredAccess(
            canCreate,
            canRead,
            canUpdate,
            canDelete
        );

        if (!accessCheck.passed) {
            description = permissionDefinitionModel.getRequiredAccess(canCreate, canRead, canUpdate, canDelete);
        }

        return new ValidatorResultRowVModel(
            permissionDefinitionModel.getQualifiedFullName(),
            permissionDefinitionModel.getMetadataType(),
            permissionDefinitionModel.getQualifiedFullName(),
            description,
            accessCheck.createState,
            accessCheck.readState,
            accessCheck.updateState,
            accessCheck.deleteState
        );
    }

    @TestVisible
    protected virtual ValidatorResultRowVModel getValidatorResultRowVModelForSObjectField(
        PermissionDefinitionModel permissionDefinitionModel,
        SObjectFieldPermissionsModel sObjectFieldPermissionsModel
    ) {
        String description = '';

        Boolean canRead = false;
        Boolean canUpdate = false;

        if (sObjectFieldPermissionsModel != null) {
            canRead = sObjectFieldPermissionsModel.canRead;
            canUpdate = sObjectFieldPermissionsModel.canUpdate;
        }

        PermissionDefinitionModel.AccessCheck accessCheck = permissionDefinitionModel.hasRequiredAccess(
            false,
            canRead,
            canUpdate,
            false
        );

        if (!accessCheck.passed) {
            description = permissionDefinitionModel.getRequiredAccess(false, canRead, canUpdate, false);
        }

        return new ValidatorResultRowVModel(
            permissionDefinitionModel.getQualifiedFullName(),
            permissionDefinitionModel.getMetadataType(),
            permissionDefinitionModel.getQualifiedFullName(),
            description,
            accessCheck.createState,
            accessCheck.readState,
            accessCheck.updateState,
            accessCheck.deleteState
        );
    }

    @TestVisible
    private ApexClassService locateApexClassService() {
        return ApexClassService.getInstance();
    }

    @TestVisible
    private ApexClassAccessService locateApexClassAccessService() {
        return ApexClassAccessService.getInstance();
    }

    @TestVisible
    private PermissionDefinitionService locatePermissionDefinitionService() {
        return PermissionDefinitionService.getInstance();
    }

    @TestVisible
    private PermissionSetService locatePermissionSetService() {
        return PermissionSetService.getInstance();
    }

    @TestVisible
    private SObjectFieldPermissionsService locateSObjectFieldPermissionsService() {
        return SObjectFieldPermissionsService.getInstance();
    }

    @TestVisible
    private SObjectPermissionsService locateSObjectPermissionsService() {
        return SObjectPermissionsService.getInstance();
    }
}
