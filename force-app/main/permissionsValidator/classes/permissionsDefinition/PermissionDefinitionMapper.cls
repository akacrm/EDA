public virtual with sharing class PermissionDefinitionMapper {
    @TestVisible
    private static PermissionDefinitionMapper instance;

    protected PermissionDefinitionMapper() {
    }

    public static PermissionDefinitionMapper getInstance() {
        if (instance == null) {
            instance = new PermissionDefinitionMapper();
        }

        return instance;
    }

    public virtual List<PermissionDefinitionModel> getPermissionDefinitionModelListByFeatureName(String featureName) {
        List<Permission_Definition__mdt> permissionDefinitionList = this.getPermissionDefinitionList(featureName);

        List<PermissionDefinitionModel> permissionDefinitionModelList = new List<PermissionDefinitionModel>();

        for (Permission_Definition__mdt permissionDefinition : permissionDefinitionList) {
            switch on permissionDefinition.Metadata_Type__c {
                when 'Apex Class' {
                    permissionDefinitionModelList.add(this.getApexClassPermDefinitionModel(permissionDefinition));
                }
                when 'SObject' {
                    permissionDefinitionModelList.add(this.getSObjectPermissionsDefinitionModel(permissionDefinition));
                }
                when 'SObjectField' {
                    permissionDefinitionModelList.add(
                        this.getSObjectFieldPermissionsDefinitionModel(permissionDefinition)
                    );
                }
                when else {
                    throw new IllegalArgumentException();
                }
            }
        }

        return permissionDefinitionModelList;
    }

    @TestVisible
    protected virtual List<Permission_Definition__mdt> getPermissionDefinitionList(String featureNameString) {
        return [
            SELECT
                Api_Name__c,
                Api_Subname__c,
                Create__c,
                Delete__c,
                Feature_Name__c,
                Metadata_Type__c,
                Read__c,
                Update__c
            FROM Permission_Definition__mdt
            WHERE Feature_Name__c LIKE :featureNameString
            ORDER BY Feature_Name__c, Metadata_Type__c, Api_Name__c, Api_Subname__c
        ];
    }

    @TestVisible
    private ApexClassPermDefinitionModel getApexClassPermDefinitionModel(
        Permission_Definition__mdt permissionDefinition
    ) {
        List<String> dotPrefixSplit = this.locateNamespaceService().splitDotFormat(permissionDefinition.Api_Name__c);
        String apiName = dotPrefixSplit[0];
        String namespace = '';

        if (dotPrefixSplit.size() > 1) {
            namespace = this.locateNamespaceService().handleLocalNamespace(dotPrefixSplit[0]);
            apiName = dotPrefixSplit[1];
        }

        return new ApexClassPermDefinitionModel(permissionDefinition.Feature_Name__c, apiName, namespace);
    }

    @TestVisible
    private SObjectPermissionsDefinitionModel getSObjectPermissionsDefinitionModel(
        Permission_Definition__mdt permissionDefinition
    ) {
        String apiName = this.locateNamespaceService().handleLocalNamespace(permissionDefinition.Api_Name__c);
        return new SObjectPermissionsDefinitionModel(
            permissionDefinition.Feature_Name__c,
            apiName,
            permissionDefinition.Create__c,
            permissionDefinition.Read__c,
            permissionDefinition.Update__c,
            permissionDefinition.Delete__c
        );
    }

    @TestVisible
    private SObjectFieldPermissionsDefinitionModel getSObjectFieldPermissionsDefinitionModel(
        Permission_Definition__mdt permissionDefinition
    ) {
        String apiName = this.locateNamespaceService().handleLocalNamespace(permissionDefinition.Api_Name__c);
        String apiSubname = this.locateNamespaceService().handleLocalNamespace(permissionDefinition.Api_Subname__c);
        return new SObjectFieldPermissionsDefinitionModel(
            permissionDefinition.Feature_Name__c,
            apiName,
            apiSubname,
            permissionDefinition.Read__c,
            permissionDefinition.Update__c
        );
    }

    @TestVisible
    private NamespaceService locateNamespaceService() {
        return NamespaceService.getInstance();
    }
}
