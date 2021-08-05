import { createElement } from "lwc";
import { registerSa11yMatcher } from "@sa11y/jest";
import ResultsSection from "c/resultsSection";

const viewModel = {
    name: "test",
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
};

describe("c-results-section", () => {
    beforeAll(() => {
        registerSa11yMatcher();
    });

    afterEach(() => {
        clearElements();
    });

    it("IsAccessible", () => {
        const element = createElement("c-results-section", {
            is: ResultsSection,
        });

        element.viewModel = viewModel;
        document.body.appendChild(element);

        return Promise.resolve().then(() => expect(element).toBeAccessible());
    });

    it("LightningCardShows", () => {
        const element = createElement("c-results-section", {
            is: ResultsSection,
        });

        element.viewModel = viewModel;
        document.body.appendChild(element);

        const lightningCard = element.shadowRoot.querySelector("lightning-card");
        expect(lightningCard.title).toBe(viewModel.name);
        expect(lightningCard.iconName).toBe(viewModel.icon);

        const lightningDataTable = element.shadowRoot.querySelector("lightning-datatable");
        for (let i = 0; i < lightningDataTable.data.length; i++) {
            expect(lightningDataTable.data[i].id).toBe(viewModel.tableData[i].id);
            expect(lightningDataTable.data[i].status).toBe(viewModel.tableData[i].status);
            expect(lightningDataTable.data[i].metadatatype).toBe(viewModel.tableData[i].metadatatype);
            expect(lightningDataTable.data[i].label).toBe(viewModel.tableData[i].label);
            expect(lightningDataTable.data[i].id).toBe(viewModel.tableData[i].id);
            expect(lightningDataTable.data[i].apiname).toBe(viewModel.tableData[i].apiname);
            expect(lightningDataTable.data[i].description).toBe(viewModel.tableData[i].description);
        }
    });
});
