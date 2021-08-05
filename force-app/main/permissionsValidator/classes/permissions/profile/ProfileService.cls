public virtual with sharing class ProfileService {
    @TestVisible
    private static ProfileService instance;

    protected ProfileService() {
    }

    public static ProfileService getInstance() {
        if (instance == null) {
            instance = new ProfileService();
        }

        return instance;
    }

    public virtual List<ProfileModel> getProfileModels() {
        return this.locateProfileMapper().getProfileModels();
    }

    @TestVisible
    private ProfileMapper locateProfileMapper() {
        return ProfileMapper.getInstance();
    }
}
