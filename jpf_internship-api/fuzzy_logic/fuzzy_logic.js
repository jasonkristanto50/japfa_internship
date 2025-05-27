// Function to normalize values based on the type of input
function fuzzyScale(value, scaleType) {
    let result;

    switch (scaleType) {
        case 'softskills':
            result = value / 25;
            break;
        case 'ipk':
            result = normalizeScore(value);
            break;
        case 'projects':
            result = value / 3;
            break;
        case 'universitas':
            result = getAccreditationValue(value);
            break;
        case 'jurusan':
            result = 1;
            break;
        default:
            result = 1;
    }

    return Math.max(0, Math.min(result, 1));
}

// Function to normalize values for both IPK and Nilai based on predefined ranges
function normalizeScore(value) {
    // Check if the value is relevant for IPK (1-4)
    if (value >= 1.0 && value <= 4.0) {
        // Normalization for IPK values based on trapezoidal scaling
        if (value >= 2.4 && value <= 2.9) {
            return 0.6;
        } else if (value >= 3.0 && value <= 3.4) {
            return 0.8;
        } else if (value >= 3.5 && value <= 4.0) {
            return 1.0;
        } else {
            return 0; // Values below 2.4 and above 4.0 return 0
        }
    } 
    // Check if the value is relevant for Nilai (10-100)
    else if (value >= 10 && value <= 100) {
        // Normalization for Nilai values based on predefined ranges
        if (value >= 10 && value < 20) {
            return 0.1;
        } else if (value >= 20 && value < 30) {
            return 0.2;
        } else if (value >= 30 && value < 40) {
            return 0.3;
        } else if (value >= 40 && value < 50) {
            return 0.4;
        } else if (value >= 50 && value < 60) {
            return 0.5;
        } else if (value >= 60 && value < 70) {
            return 0.6;
        } else if (value >= 70 && value < 80) {
            return 0.7;
        } else if (value >= 80 && value < 90) {
            return 0.8;
        } else if (value >= 90 && value <= 100) {
            return 1.0;
        }
    }
    
    // If the value is less than the minimum for either scale, return 0
    return 0;
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
            return 0;
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
    normalizeScore,
    calculateOverallScore,
};