public virtual with sharing class PermissionDefinitionService {
    @TestVisible
    private static PermissionDefinitionService instance;

    protected PermissionDefinitionService() {
    }

    public static PermissionDefinitionService getInstance() {
        if (instance == null) {
            instance = new PermissionDefinitionService();
        }

        return instance;
    }

    public virtual List<PermissionDefinitionModel> getPermissionDefinitionModelListByFeatureName(String featureName) {
        return this.locatePermissionDefinitionMapper().getPermissionDefinitionModelListByFeatureName(featureName);
    }

    public virtual List<String> getFeatureNamesFromModelList(
        List<PermissionDefinitionModel> permissionDefinitionModelList
    ) {
        Set<String> featureNameSet = new Set<String>();

        for (PermissionDefinitionModel permissionDefinitionModel : permissionDefinitionModelList) {
            featureNameSet.add(permissionDefinitionModel.featureName);
        }

        List<String> featureNameList = new List<String>(featureNameSet);
        featureNameList.sort();
        return featureNameList;
    }

    public virtual Map<String, TypeStringCollection> getTypeStringCollectionByTypeFromModelList(
        List<PermissionDefinitionModel> permissionDefinitionModelList
    ) {
        Map<String, TypeStringCollection> typeStringCollectionByType = new Map<String, TypeStringCollection>();

        TypeStringCollection apexClassTypeStringCollection = new TypeStringCollection();
        TypeStringCollection sObjectTypeStringCollection = new TypeStringCollection();
        TypeStringCollection sObjectFieldTypeStringCollection = new TypeStringCollection();

        typeStringCollectionByType.put('Apex Class', apexClassTypeStringCollection);
        typeStringCollectionByType.put('SObject', sObjectTypeStringCollection);
        typeStringCollectionByType.put('SObjectField', sObjectFieldTypeStringCollection);

        for (PermissionDefinitionModel permisionDefinitionModel : permissionDefinitionModelList) {
            switch on permisionDefinitionModel.getMetadataType() {
                when 'Apex Class' {
                    apexClassTypeStringCollection.namespacePrefixList.add(
                        ((ApexClassPermDefinitionModel) permisionDefinitionModel).namespacePrefix
                    );
                    apexClassTypeStringCollection.apiNameList.add(permisionDefinitionModel.apiName);
                }
                when 'SObject' {
                    sObjectTypeStringCollection.apiNameList.add(permisionDefinitionModel.getQualifiedName());
                }
                when 'SObjectField' {
                    sObjectFieldTypeStringCollection.apiNameList.add(permisionDefinitionModel.getQualifiedFullName());
                }
            }
        }

        return typeStringCollectionByType;
    }

    @TestVisible
    private PermissionDefinitionMapper locatePermissionDefinitionMapper() {
        return PermissionDefinitionMapper.getInstance();
    }

    public class TypeStringCollection {
        public List<String> namespacePrefixList;
        public List<String> apiNameList;
        public List<String> apiSubnameList;

        public TypeStringCollection() {
            this.apiNameList = new List<String>();
            this.apiSubnameList = new List<String>();
            this.namespacePrefixList = new List<String>();
        }
    }
}
