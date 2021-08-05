import { createElement } from "lwc";
import { registerSa11yMatcher } from "@sa11y/jest";
import ResultsIterator from "c/resultsIterator";

const features = [
    {
        name: "Test1",
        icon: "utility:success",
        tableData: [
            {
                id: "Apex Class.testclass",
                status: "Pass",
                metadatatype: "Apex Class",
                label: "testclass",
                apiname: "testclass",
                description: "You have the required access",
            },
        ],
    },
    {
        name: "Test2",
        icon: "utility:error",
        tableData: [
            {
                id: "Apex Class.testclass2",
                status: "Fail",
                metadatatype: "Apex Class",
                label: "testclass2",
                apiname: "testclass2",
                description: "You do not have the required access",
            },
        ],
    },
];

describe("c-results-iterator", () => {
    beforeAll(() => {
        registerSa11yMatcher();
    });

    afterEach(() => {
        clearElements();
    });

    it("IsAccessible", () => {
        const element = createElement("c-results-iterator", {
            is: ResultsIterator,
        });

        element.features = features;
        document.body.appendChild(element);

        return Promise.resolve().then(() => expect(element).toBeAccessible());
    });
});
