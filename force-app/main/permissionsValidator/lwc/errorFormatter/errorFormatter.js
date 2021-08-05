import errorUnexpected from "@salesforce/label/c.errorUnexpected";

export function formatApexErrorsForDisplay(error, title) {
    if (!error.body.exceptionType) {
        return {
            title: title,
            message: error.body.message,
        };
    }

    return {
        title: title,
        message: errorUnexpected.replace("{0}", error.body.exceptionType),
    };
}

export function formatApexErrorsForToast(error, title) {
    if (!error.body.exceptionType) {
        return {
            title: title,
            message: error.body.message,
            variant: "error",
        };
    }

    return {
        title: title,
        message: errorUnexpected,
        messageData: [error.body.exceptionType],
        variant: "error",
    };
}
