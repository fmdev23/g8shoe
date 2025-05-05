document.addEventListener("DOMContentLoaded", () => {
    const section = document.querySelector("#product-new")
    if (!section) return

    const filterTabs = section.querySelectorAll(".filter-tab")
    const products = section.querySelectorAll(".pro")

    // Ẩn tất cả lúc đầu
    products.forEach(product => product.style.display = "none")

    function filterProducts(category) {
        products.forEach(product => {
            product.classList.remove("show")
            product.classList.add("hide")
        })

        setTimeout(() => {
            products.forEach(product => {
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
    }

    filterTabs.forEach(tab => {
        tab.addEventListener("click", function (e) {
            e.preventDefault() // ⚠ Ngăn cuộn do href="#"
            filterTabs.forEach(t => t.classList.remove("active"))
            this.classList.add("active")
            const category = this.getAttribute("data-category")
            filterProducts(category)
        })
    })

    // Load mặc định tab all
    const defaultTab = section.querySelector('.filter-tab[data-category="all"]')
    if (defaultTab) {
        setTimeout(() => {
            defaultTab.click()

            // Xoá hash khỏi URL nếu có
            if (window.location.hash) {
                history.replaceState("", document.title, window.location.pathname + window.location.search)
            }
        }, 10)
    }
})
