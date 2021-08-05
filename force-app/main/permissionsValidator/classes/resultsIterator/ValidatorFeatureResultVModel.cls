public with sharing class ValidatorFeatureResultVModel implements Comparable {
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String status;
    @AuraEnabled
    public String statusLabel;
    @AuraEnabled
    public String icon;
    @AuraEnabled
    public List<ValidatorResultRowVModel> tableData;

    public ValidatorFeatureResultVModel(
        String name,
        String icon,
        String status,
        String statusLabel,
        List<ValidatorResultRowVModel> tableData
    ) {
        this.name = name;
        this.icon = icon;
        this.status = status;
        this.statusLabel = statusLabel;
        this.tableData = tableData;
    }

    public Integer CompareTo(Object compareTo) {
        if (!(compareTo instanceof ValidatorFeatureResultVModel)) {
            return 0;
        }

        ValidatorFeatureResultVModel model = (ValidatorFeatureResultVModel) compareTo;
        return this.name.compareTo(model.name);
    }
}
