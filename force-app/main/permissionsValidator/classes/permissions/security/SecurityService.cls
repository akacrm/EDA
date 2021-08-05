//Class is without sharing to enforce permissions necessary for the application
public virtual without sharing class SecurityService {
    @TestVisible
    private static SecurityService instance;

    protected SecurityService() {
    }

    public static SecurityService getInstance() {
        if (instance == null) {
            instance = new SecurityService();
        }

        return instance;
    }

    @TestVisible
    private Boolean checkRunForCurrentUser = false;
    @TestVisible
    private Boolean checkPassedForCurrentUser = false;

    //Throws an access exception if the current user does not have view setup
    @TestVisible
    public virtual Boolean assertViewSetupPermissionForCurrentUser() {
        if (this.checkRunForCurrentUser) {
            return this.checkPassedForCurrentUser;
        }

        this.checkRunForCurrentUser = true;

        Id userId = UserInfo.getUserId();

        //This has the 'hidden' permission sets for profile and the permission set group aggregate in it.
        List<PermissionSetAssignment> permissionSetAssignmentList = [
            SELECT PermissionSetId
            FROM PermissionSetAssignment
            WHERE AssigneeId = :userId
        ];

        List<Id> permissionSetIdList = new List<Id>();

        for (PermissionSetAssignment permissionSetAssignment : permissionSetAssignmentList) {
            permissionSetIdList.add(permissionSetAssignment.PermissionSetId);
        }

        PermissionSet passingPermissionSet = this.getPermissionSetWithViewSetup(permissionSetIdList);

        if (passingPermissionSet == null) {
            throw new NoAccessException();
        }

        this.checkPassedForCurrentUser = true;
        return this.checkPassedForCurrentUser;
    }

    @TestVisible
    protected virtual PermissionSet getPermissionSetWithViewSetup(List<Id> permissionSetIdList) {
        return [
            SELECT PermissionsViewSetup
            FROM PermissionSet
            WHERE Id IN :permissionSetIdList AND PermissionsViewSetup = TRUE
            LIMIT 1
        ];
    }
}
