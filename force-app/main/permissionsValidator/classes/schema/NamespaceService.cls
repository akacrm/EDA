public virtual with sharing class NamespaceService {
    @TestVisible
    private static NamespaceService instance;

    @TestVisible
    private String packageNamespace;
    @TestVisible
    private Boolean namespaceStripProcessed;

    protected NamespaceService() {
        this.packageNamespace = 'hed';
        this.namespaceStripProcessed = false;
    }

    public static NamespaceService getInstance() {
        if (instance == null) {
            instance = new NamespaceService();
        }

        return instance;
    }

    @TestVisible
    private Boolean stripNamespace {
        get {
            if (this.namespaceStripProcessed) {
                return this.stripNamespace;
            }

            try {
                this.validateNamespaceExistence();
                this.stripNamespace = false;
            } catch (TypeException te) {
                this.stripNamespace = true;
            }

            return this.stripNamespace;
        }
        set;
    }

    @TestVisible
    private virtual void validateNamespaceExistence() {
        UserInfo.isCurrentUserLicensed(this.packageNamespace);
    }

    public String handleLocalNamespace(String stringToStrip) {
        if (this.stripNamespace) {
            return stringToStrip.replaceAll(this.packageNamespace, '');
        }

        return stringToStrip;
    }

    public List<String> splitDotFormat(String stringToSplit) {
        return stringToSplit.split('\\.', 2);
    }
}
