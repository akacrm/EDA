public virtual with sharing class ProfileSelectorVMapper {
    @TestVisible
    private static ProfileSelectorVMapper instance;

    protected ProfileSelectorVMapper() {
    }

    public static ProfileSelectorVMapper getInstance() {
        if (instance == null) {
            instance = new ProfileSelectorVMapper();
        }

        return instance;
    }

    public virtual ProfileSelectorVModel getViewModel() {
        List<ProfileModel> profileModelList = this.locateProfileService().getProfileModels();

        List<ProfileVModel> profileVModelList = this.getProfileVModelListFromModels(profileModelList);

        ProfileSelectorVModel ProfileSelectorVModel = new ProfileSelectorVModel(profileVModelList);

        return ProfileSelectorVModel;
    }

    @TestVisible
    protected virtual List<ProfileVModel> getProfileVModelListFromModels(List<ProfileModel> profileModelList) {
        List<ProfileVModel> profileVModelList = new List<ProfileVModel>();

        for (ProfileModel profileModel : profileModelList) {
            ProfileVModel profileVModel = new ProfileVModel(profileModel.profileId, profileModel.name);

            profileVModelList.add(profileVModel);
        }

        return profileVModelList;
    }

    @TestVisible
    private ProfileService locateProfileService() {
        return ProfileService.getInstance();
    }
}
