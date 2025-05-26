// Function to normalize values based on the type of input
function fuzzyScale(value, scaleType) {
    let result;

    switch (scaleType) {
        case 'softskills':
            result = value / 25; // Normalize from 1-5 to [0, 1]
            break;
        case 'ipk':
            if (value <= 4) {
                result = value / 4; // Normalize IPK scores 1-4 to [0, 1]
            } else {
                if (value < 10 || value > 100) {
                    throw new Error('IPK value is out of range (10-100)');
                }
                result = (value - 10) / 90; // Scale from 10 to 100
            }
            break;
        case 'projects':
            result = value / 3; // Normalize the number of projects to [0, 1]
            break;
        case 'universitas':
            // Handle university accreditation logic
            result = getAccreditationValue(value);
            break;
        case 'jurusan':
            result = 1; // Uniform score for jurusan (1)
            break;
        default:
            result = 1; // Uniform score for other cases
    }

    return Math.max(0, Math.min(result, 1)); // Ensure result is between 0 and 1
}

// Function to get accreditation value
function getAccreditationValue(accreditation) {
    switch (accreditation) {
        case 'A':
            return 1.0;
        case 'B':
            return 0.8;
        case 'C':
            return 0.6;
        case 'D':
        case 'F':
            return 0.4;
        default:
            return 0; // Unknown accreditation
    }
}

// Function to calculate the overall fuzzy score
function calculateOverallScore(scores, weights) {
    let overallScore = 0;

    Object.keys(scores).forEach((key) => {
        overallScore += scores[key] * (weights[key] || 0);
    });

    return overallScore;
}

module.exports = {
    fuzzyScale,
    calculateOverallScore,
};