public virtual with sharing class PermissionSetGroupService {
    @TestVisible
    private static PermissionSetGroupService instance;

    protected PermissionSetGroupService() {
    }

    public static PermissionSetGroupService getInstance() {
        if (instance == null) {
            instance = new PermissionSetGroupService();
        }

        return instance;
    }

    public virtual List<PermissionSetGroupModel> getPermissionSetGroupModels() {
        return this.locatePermissionSetGroupMapper().getPermissionSetGroupModels();
    }

    @TestVisible
    private PermissionSetGroupMapper locatePermissionSetGroupMapper() {
        return PermissionSetGroupMapper.getInstance();
    }
}
