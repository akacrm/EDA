import { createElement } from "lwc";
import { registerApexTestWireAdapter } from "@salesforce/sfdx-lwc-jest";

import { registerSa11yMatcher } from "@sa11y/jest";
import ProfileSelector from "c/profileSelector";

import getViewModel from "@salesforce/apex/ProfileSelectorController.getViewModel";
const mockGetViewModel = require("./data/getViewModel.json");
const getViewModelAdapter = registerApexTestWireAdapter(getViewModel);

import profileSelectorPrompt from "@salesforce/label/c.profileselectorprompt";
import profileSelectorAvailable from "@salesforce/label/c.profileselectoravailable";
import profileSelectorSelected from "@salesforce/label/c.profileselectorselected";
import profileSelectorFieldLevelHelp from "@salesforce/label/c.profileselectorfieldlevelhelp";

jest.mock(
    "@salesforce/label/c.profileselectorprompt",
    () => {
        return { default: "profileselectorprompt" };
    },
    { virtual: true }
);
jest.mock(
    "@salesforce/label/c.profileselectoravailable",
    () => {
        return { default: "profileselectoravailable" };
    },
    { virtual: true }
);
jest.mock(
    "@salesforce/label/c.profileselectorselected",
    () => {
        return { default: "profileselectorselected" };
    },
    { virtual: true }
);
jest.mock(
    "@salesforce/label/c.profileselectorfieldlevelhelp",
    () => {
        return { default: "profileselectorfieldlevelhelp" };
    },
    { virtual: true }
);

describe("c-profile-selector", () => {
    beforeAll(() => {
        registerSa11yMatcher();
    });

    afterEach(() => {
        clearElements();
        jest.clearAllMocks();
    });

    it("IsAccessibleNoDataLoaded", () => {
        const element = createElement("c-profile-selector", {
            is: ProfileSelector,
        });

        document.body.appendChild(element);

        return Promise.resolve().then(() => expect(element).toBeAccessible());
    });

    it("IsAccessibleDataLoaded", () => {
        const element = createElement("c-profile-selector", {
            is: ProfileSelector,
        });

        document.body.appendChild(element);
        getViewModelAdapter.emit(mockGetViewModel);

        return Promise.resolve().then(() => expect(element).toBeAccessible());
    });

    it("Localization", () => {
        const element = createElement("c-profile-selector", {
            is: ProfileSelector,
        });

        document.body.appendChild(element);
        getViewModelAdapter.emit(mockGetViewModel);

        return Promise.resolve().then(() => {
            const dualPicklist = element.shadowRoot.querySelector("lightning-dual-listbox");
            expect(dualPicklist.label).toBe(profileSelectorPrompt);
            expect(dualPicklist.sourceLabel).toBe(profileSelectorAvailable);
            expect(dualPicklist.selectedLabel).toBe(profileSelectorSelected);
            expect(dualPicklist.fieldLevelHelp).toBe(profileSelectorFieldLevelHelp);
        });
    });

    it("GetViewModelDataUnloaded", () => {
        const element = createElement("c-profile-selector", {
            is: ProfileSelector,
        });

        document.body.appendChild(element);

        return Promise.resolve().then(() => {
            const dualPicklist = element.shadowRoot.querySelector("lightning-dual-listbox");
            expect(dualPicklist.showActivityIndicator).toBe(true);
        });
    });

    it("GetViewModelDataLoads", () => {
        const element = createElement("c-profile-selector", {
            is: ProfileSelector,
        });

        document.body.appendChild(element);
        getViewModelAdapter.emit(mockGetViewModel);

        return Promise.resolve().then(() => {
            const dualPicklist = element.shadowRoot.querySelector("lightning-dual-listbox");
            expect(dualPicklist.options.length).toBe(mockGetViewModel.profileViewModelList.length);

            for (let i = 0; i < dualPicklist.options.length; i++) {
                expect(dualPicklist.options[i].label).toBe(mockGetViewModel.profileViewModelList[i].label);
                expect(dualPicklist.options[i].value).toBe(mockGetViewModel.profileViewModelList[i].value);
            }

            expect(dualPicklist.showActivityIndicator).toBe(undefined);

            expect(dualPicklist.min).toBe(0);
            expect(dualPicklist.max).toBe(1);
            expect(dualPicklist.size).toBe(10);
        });
    });

    it("GetViewModelErrorHandling", () => {
        const element = createElement("c-profile-selector", {
            is: ProfileSelector,
        });

        document.body.appendChild(element);
        getViewModelAdapter.error();

        return Promise.resolve().then(() => {
            //Reserved for error handling
        });
    });

    it("ProfileEventDispatched", () => {
        const element = createElement("c-profile-selector", {
            is: ProfileSelector,
        });

        const mockHandler = jest.fn();
        element.addEventListener("profileselected", mockHandler);
        getViewModelAdapter.emit(mockGetViewModel);

        document.body.appendChild(element);

        const profileValue = "000000000000000000";

        const dualPicklist = element.shadowRoot.querySelector("lightning-dual-listbox");
        dualPicklist.dispatchEvent(
            new CustomEvent("change", {
                detail: {
                    value: [profileValue],
                },
            })
        );

        return Promise.resolve().then(() => {
            expect(mockHandler).toHaveBeenCalledTimes(1);
            expect(mockHandler.mock.calls[0][0].detail.profileId).toStrictEqual(profileValue);
        });
    });

    it("EmptyProfileEventDispatched", () => {
        const element = createElement("c-profile-selector", {
            is: ProfileSelector,
        });

        const mockHandler = jest.fn();
        element.addEventListener("profileselected", mockHandler);
        getViewModelAdapter.emit(mockGetViewModel);

        document.body.appendChild(element);

        const dualPicklist = element.shadowRoot.querySelector("lightning-dual-listbox");
        dualPicklist.dispatchEvent(
            new CustomEvent("change", {
                detail: {
                    value: [],
                },
            })
        );

        return Promise.resolve().then(() => {
            expect(mockHandler).toHaveBeenCalledTimes(1);
            expect(mockHandler.mock.calls[0][0].detail.profileId).toStrictEqual(undefined);
        });
    });
});
