public with sharing class PermissionSetSelectorVModel {
    public PermissionSetSelectorVModel(List<PermissionSetVModel> permissionSetViewModelList) {
        this.permissionSetViewModelList = permissionSetViewModelList;
    }

    @AuraEnabled
    public List<PermissionSetVModel> permissionSetViewModelList { get; private set; }
}
