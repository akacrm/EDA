public with sharing class PermissionSetGroupSelectorVModel {
    public PermissionSetGroupSelectorVModel(List<PermissionSetGroupVModel> permissionSetGroupViewModelList) {
        this.permissionSetGroupViewModelList = permissionSetGroupViewModelList;
    }

    @AuraEnabled
    public List<PermissionSetGroupVModel> permissionSetGroupViewModelList { get; private set; }
}
