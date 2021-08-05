public with sharing class ProfileModel {
    public Id profileId;
    public String name;

    public ProfileModel(Id profileId, String name) {
        this.profileId = profileId;
        this.name = name;
    }
}
