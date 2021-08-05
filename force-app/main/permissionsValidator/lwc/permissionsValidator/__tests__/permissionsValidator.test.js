import { createElement } from "lwc";
import { registerSa11yMatcher } from "@sa11y/jest";
import PermissionsValidator from "c/permissionsValidator";

import permissionsValidator from "@salesforce/label/c.permissionsValidator";
import validatorRunButton from "@salesforce/label/c.validatorRunButton";
import validatorRunButtonTitle from "@salesforce/label/c.validatorRunButtonTitle";

import getViewModelList from "@salesforce/apex/ResultsIteratorController.getViewModelList";

jest.mock(
    "@salesforce/label/c.permissionsValidator",
    () => {
        return { default: "permissionsValidator" };
    },
    { virtual: true }
);
jest.mock(
    "@salesforce/label/c.validatorRunButton",
    () => {
        return { default: "validatorRunButton" };
    },
    { virtual: true }
);
jest.mock(
    "@salesforce/label/c.validatorRunButtonTitle",
    () => {
        return { default: "validatorRunButtonTitle" };
    },
    { virtual: true }
);

jest.mock(
    "@salesforce/apex/ResultsIteratorController.getViewModelList",
    () => {
        return {
            default: jest.fn(),
        };
    },
    { virtual: true }
);

const apexGetViewModelListSuccess = [
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

describe("c-permissions-validator", () => {
    beforeAll(() => {
        registerSa11yMatcher();
    });

    afterEach(() => {
        clearElements();
        jest.clearAllMocks();
    });

    it("Is Accessible", () => {
        const element = createElement("c-permissions-validator", {
            is: PermissionsValidator,
        });

        document.body.appendChild(element);

        return Promise.resolve().then(() => expect(element).toBeAccessible());
    });

    it("Localization", () => {
        const element = createElement("c-permissions-validator", {
            is: PermissionsValidator,
        });

        document.body.appendChild(element);

        const lightningCard = element.shadowRoot.querySelector("lightning-card");
        expect(lightningCard.title).toBe(permissionsValidator);

        const lightningButton = element.shadowRoot.querySelector("lightning-button");
        expect(lightningButton.label).toBe(validatorRunButton);
        expect(lightningButton.title).toBe(validatorRunButtonTitle);
    });

    it("handles profile selected", () => {
        const element = createElement("c-permissions-validator", {
            is: PermissionsValidator,
        });

        document.body.appendChild(element);

        const profileValue = "000000000000000000";

        const profileSelector = element.shadowRoot.querySelector("c-profile-selector");

        profileSelector.dispatchEvent(
            new CustomEvent("profileselected", {
                detail: {
                    profileId: profileValue,
                },
                bubbles: true,
                composed: true,
            })
        );
    });

    it("passes parameters to get view model list", () => {
        const profileValue = "000000000000000000";
        const apexParameters = { profileId: profileValue };

        getViewModelList.mockResolvedValue(apexGetViewModelListSuccess);

        const element = createElement("c-permissions-validator", {
            is: PermissionsValidator,
        });

        document.body.appendChild(element);

        const profileSelector = element.shadowRoot.querySelector("c-profile-selector");

        profileSelector.dispatchEvent(
            new CustomEvent("profileselected", {
                detail: {
                    profileId: profileValue,
                },
                bubbles: true,
                composed: true,
            })
        );

        const runButton = element.shadowRoot.querySelector("lightning-button");
        runButton.click();

        return flushPromises().then(() => {
            expect(getViewModelList.mock.calls[0][0]).toEqual(apexParameters);
        });
    });

    it("HandlesRunClick", () => {
        const profileValue = "000000000000000000";

        getViewModelList.mockResolvedValue(apexGetViewModelListSuccess);

        const element = createElement("c-permissions-validator", {
            is: PermissionsValidator,
        });

        document.body.appendChild(element);

        const profileSelector = element.shadowRoot.querySelector("c-profile-selector");

        profileSelector.dispatchEvent(
            new CustomEvent("profileselected", {
                detail: {
                    profileId: profileValue,
                },
                bubbles: true,
                composed: true,
            })
        );

        const runButton = element.shadowRoot.querySelector("lightning-button");
        runButton.click();

        return flushPromises().then(() => {
            const resultsIterator = element.shadowRoot.querySelector("c-results-iterator");
            expect(resultsIterator.features.length).toBe(apexGetViewModelListSuccess.length);

            for (let i = 0; i < resultsIterator.features.length; i++) {
                let feature = apexGetViewModelListSuccess[i];
                let iteratorFeature = resultsIterator.features[i];
                expect(iteratorFeature.name).toBe(feature.name);
                expect(iteratorFeature.icon).toBe(feature.icon);
            }
        });
    });

    it("is accessible with features", () => {
        const profileValue = "000000000000000000";

        getViewModelList.mockResolvedValue(apexGetViewModelListSuccess);

        const element = createElement("c-permissions-validator", {
            is: PermissionsValidator,
        });

        document.body.appendChild(element);

        const profileSelector = element.shadowRoot.querySelector("c-profile-selector");

        profileSelector.dispatchEvent(
            new CustomEvent("profileselected", {
                detail: {
                    profileId: profileValue,
                },
                bubbles: true,
                composed: true,
            })
        );

        const runButton = element.shadowRoot.querySelector("lightning-button");
        runButton.click();

        return flushPromises().then(() => expect(element).toBeAccessible());
    });
});
