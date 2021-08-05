public with sharing class SObjectFieldPermissionsModel {
    public String sObjectType;
    public String name;

    public Boolean canRead;
    public Boolean canUpdate;

    public SObjectFieldPermissionsModel(String sObjectType, String name, Boolean canRead, Boolean canUpdate) {
        this.sObjectType = sObjectType;
        this.name = name;
        this.canRead = canRead;
        this.canUpdate = canUpdate;
    }

    public SObjectFieldPermissionsModel combineModels(SObjectFieldPermissionsModel sObjectFieldPermissionsModel) {
        if (
            this.sObjectType != sObjectFieldPermissionsModel.sObjectType ||
            this.name != sObjectFieldPermissionsModel.name
        ) {
            throw new IllegalArgumentException();
        }

        this.canRead = (sObjectFieldPermissionsModel.canRead ? true : this.canRead);
        this.canUpdate = (sObjectFieldPermissionsModel.canUpdate ? true : this.canUpdate);

        return this;
    }
}
