public with sharing class PermissionSetModel {
    public Id permissionSetId;
    public String name;
    public String label;

    public PermissionSetModel(Id permissionSetId, String name, String label) {
        this.permissionSetId = permissionSetId;
        this.name = name;
        this.label = label;
    }
}
