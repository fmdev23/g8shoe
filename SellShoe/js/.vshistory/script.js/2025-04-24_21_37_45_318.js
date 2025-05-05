document.addEventListener("DOMContentLoaded", () => {
    // Get all filter tabs and products
    const filterTabs = document.querySelectorAll(".filter-tab")
    const products = document.querySelectorAll(".pro")
    const proContainer = document.querySelector(".pro-container")
  
    // Initially hide all products
    products.forEach((product) => {
      product.style.display = "none"
    })
  
    // Function to filter products
    function filterProducts(category) {
      // First, hide all products with a fade-out effect
      products.forEach((product) => {
        product.classList.remove("show")
        product.classList.add("hide")
      })
  
      // After the fade-out animation completes, show the filtered products
      setTimeout(() => {
        products.forEach((product) => {
          const productCategory = product.getAttribute("data-category")
  
          // If category is 'all' or matches the product category
          if (category === "all" || productCategory === category) {
            product.style.display = "block"
            setTimeout(() => {
              product.classList.remove("hide")
              product.classList.add("show")
            }, 50) // Small delay for better animation effect
          } else {
            setTimeout(() => {
              product.style.display = "none"
            }, 300) // Match the transition duration
          }
        })
      }, 300) // Match the transition duration
    }
  
    // Add click event listeners to filter tabs
    filterTabs.forEach((tab) => {
      tab.addEventListener("click", function () {
        // Remove active class from all tabs
        filterTabs.forEach((t) => t.classList.remove("active"))
  
        // Add active class to clicked tab
        this.classList.add("active")
  
        // Get the category from data attribute
        const category = this.getAttribute("data-category")
  
        // Filter products
        filterProducts(category)
      })
    })
  
    // Trigger click on "all" tab to initialize the view
    document.querySelector('.filter-tab[data-category="all"]').click()
  })
  