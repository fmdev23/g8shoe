﻿document.addEventListener("DOMContentLoaded", () => {
    const section = document.querySelector("#product-new")
    if (!section) return //Tìm section #product-new, nếu không tồn tại thì thoát sớm

    //Lấy toàn bộ các nút tab (.filter-tab) và danh sách sản phẩm (.pro)
    const filterTabs = section.querySelectorAll(".filter-tab")
    const products = section.querySelectorAll(".pro")

    // Ẩn tất cả lúc đầu
    products.forEach(product => product.style.display = "none")

    function filterProducts(category) {
        products.forEach((product) => {
            const productCategory = product.getAttribute("data-category"); // Lấy category của sản phẩm từ thuộc tính data-category

            if (category === "all" || productCategory === category) { // Nếu category là "all" hoặc category của sản phẩm trùng với category đang chọn
                product.classList.remove("hide"); 
                product.classList.add("show");
            } else { // Nếu không thì ẩn sản phẩm
                product.classList.remove("show");
                product.classList.add("hide");
            }
        });

        setTimeout(() => { 
            products.forEach(product => { 
                const productCategory = product.getAttribute("data-category") // Lấy category của sản phẩm từ thuộc tính data-category

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

    filterTabs.forEach((tab) => {
        tab.addEventListener("click", function (e) {
            e.preventDefault(); // Ngăn scroll

            filterTabs.forEach((t) => t.classList.remove("active")); // Xoá class active cho tất cả tab
            this.classList.add("active"); // Thêm class active cho tab đang click

            const category = this.getAttribute("data-category"); // Lấy category từ thuộc tính data-category của tab
            filterProducts(category); // Gọi hàm filterProducts với category tương ứng
        });
    });

    // Load mặc định tab all
    const defaultTab = section.querySelector('.filter-tab[data-category="all"]') 
    if (defaultTab) { 
        setTimeout(() => {
            defaultTab.click() // Tự động click vào tab "all" sau 300ms

            // Xoá hash khỏi URL nếu có
            if (window.location.hash) { 
                history.replaceState("", document.title, window.location.pathname + window.location.search) 
            } 
        }, 10) 
    } 
})
