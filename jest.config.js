module.exports = {
    collectCoverage: true,
    coverageDirectory: "/my-react-app/test-coverage",  // Fixed to match WORKDIR
    reporters: [
        "default",
        [
            "jest-junit",
            {
                outputDirectory: "/my-react-app/test-reports",  // Already correct
                outputName: "junit.xml"
            }
        ]
    ],
    coverageReporters: ["lcov", "text"],
};