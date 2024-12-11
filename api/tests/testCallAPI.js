// * /api/v1/species?select=scientific_name,common_name&sort=-createdAt&page=2&limit=5
// Import axios
const axios = require("axios");

// Define the API URL
const API_URL = "http://localhost:3000/api/v1/species";

// Define query parameters
const queryParams = {
  select: "scientific_name,common_name",
  sort: "-createdAt",
  page: 2,
  limit: 5,
};

// Function to call the API
(async () => {
  try {
    // Make a GET request
    const response = await axios.get(API_URL, { params: queryParams });

    // Log the response data
    console.log("Response Data:", response.data);
  } catch (error) {
    // Handle errors
    if (error.response) {
      console.error("Error Response:", error.response.data);
    } else if (error.request) {
      console.error("No Response Received:", error.request);
    } else {
      console.error("Error:", error.message);
    }
  }
})();
