@isTest
private class ApexClassModel_TEST {
    @isTest
    private static void constructor() {
        Id classId = '000000000000000000';
        String name = 'name';
        String namespacePrefix = 'namespacePrefix';

        ApexClassModel model = new ApexClassModel(classId, name, namespacePrefix);

        System.assertEquals(classId, model.classId, 'Class Id should match value passed to model.');
        System.assertEquals(name, model.name, 'Name should match value passed to model.');
        System.assertEquals(
            namespacePrefix,
            model.namespacePrefix,
            'Namespace Prefix should match value passed to model.'
        );
    }

    @isTest
    private static void getQualifiedNameWithNamespace() {
        Id classId = '000000000000000000';
        String name = 'name';
        String namespacePrefix = 'namespacePrefix';

        ApexClassModel model = new ApexClassModel(classId, name, namespacePrefix);

        System.assertEquals(
            namespacePrefix +
            '.' +
            name,
            model.getQualifiedName(),
            'Qualified name should equal the namespace prefix and name separated by a \'.\'.'
        );
    }

    @isTest
    private static void getQualifiedNameWithoutNamespace() {
        Id classId = '000000000000000000';
        String name = 'name';
        String namespacePrefix = '';

        ApexClassModel model = new ApexClassModel(classId, name, namespacePrefix);

        System.assertEquals(name, model.getQualifiedName(), 'Qualified name should equal the name.');
    }
}
