public with sharing class ProfileSelectorVModel {
    public ProfileSelectorVModel(List<ProfileVModel> profileViewModelList) {
        this.profileViewModelList = profileViewModelList;
    }

    @AuraEnabled
    public List<ProfileVModel> profileViewModelList { get; private set; }
}
