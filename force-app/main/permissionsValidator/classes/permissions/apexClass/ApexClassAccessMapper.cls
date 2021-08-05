public virtual with sharing class ApexClassAccessMapper {
    @TestVisible
    private static ApexClassAccessMapper instance;

    protected ApexClassAccessMapper() {
    }

    public static ApexClassAccessMapper getInstance() {
        if (instance == null) {
            instance = new ApexClassAccessMapper();
        }

        return instance;
    }

    public virtual Map<Id, ApexClassAccessModel> getModelMapFromPermissionSetIdListAndClassIdList(
        List<Id> permissionSetIdList,
        List<Id> apexClassIdList
    ) {
        SecurityService.getInstance().assertViewSetupPermissionForCurrentUser();
        List<AggregateResult> apexClassAccessList = [
            SELECT SetupEntityId, COUNT(Id) IdCount
            FROM SetupEntityAccess
            WHERE
                SetupEntityType = 'ApexClass'
                AND ParentId IN :permissionSetIdList
                AND SetupEntityId IN :apexClassIdList
            GROUP BY SetupEntityId
        ];

        Map<Id, ApexClassAccessModel> apexClassAccessModelByEntityId = new Map<Id, ApexClassAccessModel>();

        for (AggregateResult aggregateResult : apexClassAccessList) {
            ApexClassAccessModel apexClassAccessModel = new ApexClassAccessModel(
                (Id) aggregateResult.get('SetupEntityId')
            );

            apexClassAccessModelByEntityId.put(apexClassAccessModel.apexClassId, apexClassAccessModel);
        }

        return apexClassAccessModelByEntityId;
    }
}
