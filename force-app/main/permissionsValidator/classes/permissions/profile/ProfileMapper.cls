public virtual with sharing class ProfileMapper {
    @TestVisible
    private static ProfileMapper instance;

    protected ProfileMapper() {
    }

    public static ProfileMapper getInstance() {
        if (instance == null) {
            instance = new ProfileMapper();
        }

        return instance;
    }

    public virtual List<ProfileModel> getProfileModels() {
        SecurityService.getInstance().assertViewSetupPermissionForCurrentUser();
        List<Profile> profileList = [SELECT Id, name FROM Profile ORDER BY name];

        List<ProfileModel> profileModelList = new List<ProfileModel>();

        for (Profile profile : profileList) {
            ProfileModel profileModel = new ProfileModel(profile.id, profile.name);

            profileModelList.add(profileModel);
        }

        return profileModelList;
    }
}
