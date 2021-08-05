public with sharing class ApexClassModel {
    public Id classId;
    public String name;
    public String namespacePrefix;

    public ApexClassModel(Id classId, String name, String namespacePrefix) {
        this.classId = classId;
        this.name = name;
        this.namespacePrefix = namespacePrefix;
    }

    public String getQualifiedName() {
        if (String.isBlank(this.namespacePrefix)) {
            return this.name;
        }

        return this.namespacePrefix + '.' + this.name;
    }
}
