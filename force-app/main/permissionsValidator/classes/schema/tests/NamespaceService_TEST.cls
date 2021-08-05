@isTest
private class NamespaceService_TEST {
    @isTest
    private static void getInstance() {
        Test.startTest();
        NamespaceService NamespaceServiceInstance = NamespaceService.getInstance();
        Test.stopTest();

        System.assertNotEquals(null, NamespaceServiceinstance, 'Service instance should not be null.');
        System.assertEquals(
            NamespaceService.instance,
            NamespaceServiceinstance,
            'Service instance should equal the apex class service instance.'
        );
    }

    @isTest
    private static void getInstanceSingleton() {
        NamespaceService NamespaceServiceInstance = NamespaceService.getInstance();

        Test.startTest();
        NamespaceService NamespaceServiceGetInstance = NamespaceService.instance;
        Test.stopTest();

        System.assertEquals(
            NamespaceServiceInstance,
            NamespaceServiceGetInstance,
            'Retrieved Service instance should be indentical cached singleton instance.'
        );
    }

    @isTest
    private static void stripNamespacePositive() {
        NamespaceService.instance = new NamespaceServiceStub(false);
        NamespaceService namespaceService = NamespaceService.getInstance();

        Test.startTest();
        Boolean stripNamespace = namespaceService.stripNamespace;
        Test.stopTest();

        System.assertEquals(false, stripNamespace, 'The namespace service should not strip the namespace.');
    }

    @isTest
    private static void stripNamespaceNegative() {
        NamespaceService.instance = new NamespaceServiceStub(true);
        NamespaceService namespaceService = NamespaceService.getInstance();

        Test.startTest();
        Boolean stripNamespace = namespaceService.stripNamespace;
        Test.stopTest();

        System.assertEquals(
            true,
            stripNamespace,
            'The namespace service should not strip the namespace if the namespace does not exist.'
        );
    }

    @isTest
    private static void stripNamespaceNegativeLazyLoad() {
        NamespaceService.instance = new NamespaceServiceStub(true);
        NamespaceService namespaceService = NamespaceService.getInstance();

        Boolean stripNamespace = namespaceService.stripNamespace;

        Test.startTest();
        Boolean stripNamespace2 = namespaceService.stripNamespace;
        Test.stopTest();

        System.assertEquals(
            stripNamespace,
            stripNamespace2,
            'The namespace service should lazy load stripping the namespace.'
        );
    }

    @isTest
    private static void validateNamespaceExistence() {
        NamespaceService namespaceService = NamespaceService.getInstance();

        Boolean testPassed = false;
        try {
            Test.startTest();
            namespaceService.validateNamespaceExistence();
            Test.stopTest();
            testPassed = true;
        } catch (TypeException te) {
            testPassed = true;
        }

        System.assert(testPassed, 'Validating the namespace should not throw unexpected exceptions.');
    }

    @isTest
    private static void handleLocalNamespaceStripNamespace() {
        NamespaceService namespaceService = NamespaceService.getInstance();
        namespaceService.namespaceStripProcessed = true;
        namespaceService.stripNamespace = true;

        String expectedValue = 'remaining';

        Test.startTest();
        String handledValue = namespaceService.handleLocalNamespace(namespaceService.packageNamespace + expectedValue);
        Test.stopTest();

        System.assertEquals(
            expectedValue,
            handledValue,
            'The namespace service should strip the namespace from the value.'
        );
    }

    @isTest
    private static void handleLocalNamespacePreserveNamespace() {
        NamespaceService namespaceService = NamespaceService.getInstance();
        namespaceService.namespaceStripProcessed = true;
        namespaceService.stripNamespace = false;

        String expectedValue = namespaceService.packageNamespace + 'remaining';

        Test.startTest();
        String handledValue = namespaceService.handleLocalNamespace(expectedValue);
        Test.stopTest();

        System.assertEquals(
            expectedValue,
            handledValue,
            'The namespace service should not strip the namespace from the value.'
        );
    }

    @isTest
    private static void splitDotFormat() {
        NamespaceService namespaceService = NamespaceService.getInstance();

        String valueToSplit = 'namespace.test.subtest';

        Test.startTest();
        List<string> splitStringList = namespaceService.splitDotFormat(valueToSplit);
        Test.stopTest();

        System.assertEquals(2, splitStringList.size(), 'The list size for a split string hould be 2.');
        System.assertEquals(
            'namespace',
            splitStringList[0],
            'The namespace should be in the first position of the string list.'
        );
        System.assertEquals(
            'test.subtest',
            splitStringList[1],
            'The remaining value should be in the second position of the string list.'
        );
    }

    public virtual class NamespaceServiceStub extends NamespaceService {
        protected NamespaceServiceStub() {
        }
        protected NamespaceServiceStub(Boolean throwException) {
            this.throwException = throwException;
        }

        private Boolean throwException = false;

        public override void validateNamespaceExistence() {
            if (this.throwException) {
                throw new TypeException();
            }
        }
    }
}
