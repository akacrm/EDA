public with sharing class SObjectPermissionsModel {
    public String sObjectType;

    public Boolean canCreate;
    public Boolean canRead;
    public Boolean canUpdate;
    public Boolean canDelete;

    public SObjectPermissionsModel(
        String sObjectType,
        Boolean canCreate,
        Boolean canRead,
        Boolean canUpdate,
        Boolean canDelete
    ) {
        this.sObjectType = sObjectType;
        this.canCreate = canCreate;
        this.canRead = canRead;
        this.canUpdate = canUpdate;
        this.canDelete = canDelete;
    }

    public SObjectPermissionsModel combineModels(SObjectPermissionsModel sObjectPermissionsModel) {
        if (this.sObjectType != sObjectPermissionsModel.sObjectType) {
            throw new IllegalArgumentException();
        }

        this.canCreate = (sObjectPermissionsModel.canCreate ? true : this.canCreate);
        this.canRead = (sObjectPermissionsModel.canRead ? true : this.canRead);
        this.canUpdate = (sObjectPermissionsModel.canUpdate ? true : this.canUpdate);
        this.canDelete = (sObjectPermissionsModel.canDelete ? true : this.canDelete);

        return this;
    }
}
