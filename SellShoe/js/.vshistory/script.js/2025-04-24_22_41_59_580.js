document.addEventListener("DOMContentLoaded", () => {
    const productSection = document.querySelector("#product-new")
    if (!productSection) return // Tránh lỗi nếu không tìm thấy section

    const filterTabs = productSection.querySelectorAll(".filter-tab")
    const products = productSection.querySelectorAll(".pro")

    // Initially hide all products
    products.forEach((product) => {
        product.style.display = "none"
    })

    function filterProducts(category) {
        products.forEach((product) => {
            product.classList.remove("show")
            product.classList.add("hide")
        })

        setTimeout(() => {
            products.forEach((product) => {
                const productCategory = product.getAttribute("data-category")

                if (category === "all" || productCategory === category) {
                    product.style.display = "block"
                    setTimeout(() => {
                        product.classList.remove("hide")
                        product.classList.add("show")
                    }, 50)
                } else {
                    setTimeout(() => {
                        product.style.display = "none"
                    }, 300)
                }
            })
        }, 300)

        // Clear URL hash để tránh cuộn trang
        if (window.location.hash) {
            history.pushState("", document.title, window.location.pathname + window.location.search)
        }
    }

    // Tab click event
    filterTabs.forEach((tab) => {
        tab.addEventListener("click", function () {
            filterTabs.forEach((t) => t.classList.remove("active"))
            this.classList.add("active")

            const category = this.getAttribute("data-category")
            filterProducts(category)
        })
    })

    // Tự động hiển thị tất cả khi load trang
    const allTab = productSection.querySelector('.filter-tab[data-category="all"]')
    if (allTab) allTab.click()

    // Fix auto scroll xuống cuối nếu có # trong URL
    if (window.location.hash) {
        history.pushState("", document.title, window.location.pathname + window.location.search);
    }
})
