public with sharing class PermissionSetGroupModel {
    public Id permissionSetGroupId;
    public String label;

    public PermissionSetGroupModel(Id permissionSetGroupId, String label) {
        this.permissionSetGroupId = permissionSetGroupId;
        this.label = label;
    }
}
