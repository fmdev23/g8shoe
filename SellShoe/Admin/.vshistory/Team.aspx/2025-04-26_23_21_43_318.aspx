<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Team.aspx.cs" Inherits="SellShoe.Admin.Team" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ THÀNH VIÊN</h2>
            <div class="header-actions">
                <div class="search-container">
                    <i class="fal fa-search"></i>
                    <input type="text" placeholder="Search products">
                </div>
                <button class="add-product-btn" id="addProductBtn">Thêm thành viên</button>
            </div>
        </div>

        <div class="table-container">
            <table class="products-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Tên thành viên</th>
                        <th>Vị trí</th>
                        <th>Số điện thoại</th>
                        <th>Email</th>
                        <th>Ảnh</th>
                        <th>Tùy chọn</th>
                    </tr>
                </thead>
                <tbody id="productsTableBody">

                    <%for (int i = 0; i < listTeam.Count; i++)
                        {  %>
                    <tr>
                        <th><%=listTeam[i].Id %></th>
                        <th><%=listTeam[i].FullName %></th>
                        <th><%=listTeam[i].Position %></th>
                        <th><%=listTeam[i].Phone %></th>
                        <th><%=listTeam[i].Email %></th>
                        <th><%=listTeam[i].Avatar %></th>
                        <th class="action-cell">
                            <div class="action-menu" data-id="1">
                                <button class="action-btn">
                                    <i class="fad fa-edit"></i>
                                </button>
                                <button class="action-btn">
                                    <i class="fal fa-trash"></i>
                                </button>
                            </div>
                        </th>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="pagination">
            <button class="pagination-arrow prev">
                <i class="fal fa-chevron-left"></i>
            </button>
            <div class="pagination-numbers">
                <button class="pagination-number active">1</button>
                <button class="pagination-number">2</button>
                <span class="pagination-ellipsis">...</span>
                <button class="pagination-number">23</button>
                <button class="pagination-number">24</button>
            </div>
            <button class="pagination-arrow next">
                <i class="fal fa-chevron-right"></i>
            </button>
        </div>


    </div>

    <!-- Add/Edit Product Modal -->
    <div class="modal" id="teamModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">Thêm thành viên</h3>
                <button class="close-modal" id="closeModal">
                    <i class="fad fa-times"></i>
                </button>
            </div>
            <div class="modal-body">

                <form id="teamForm">
                    <input type="hidden" id="teamId" />

                    <div class="form-group">
                        <label>Tên thành viên</label>
                        <input type="text" id="txtTitle" />
                    </div>
                    <div class="form-group">
                        <label>Vị trí</label>
                        <input type="text" id="txtDescription" />
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="text" id="txtPhone" />
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="text" id="txtEmail" />
                    </div>

                    <div class="form-actions">
                        <button type="button" class="cancel-btn" id="cancelBtn">Thoát</button>
                        <button type="button" class="save-btn" id="saveProductBtn">Lưu</button>
                    </div>
                </form>

            </div>
        </div>
    </div>


    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const modal = document.getElementById("teamModal");

            // Hiển thị modal thêm thành viên
            document.getElementById("addTeamBtn").addEventListener("click", function () {
                resetForm();
                document.getElementById("modalTitle").innerText = "Thêm thành viên";
                modal.style.display = "flex";
            });

            // Hiển thị modal sửa thành viên
            document.querySelectorAll(".action-menu .fa-edit").forEach(function (btn) {
                btn.addEventListener("click", function () {
                    const id = this.closest(".action-menu").getAttribute("data-id");
                    const row = this.closest("tr");
                    document.getElementById("teamId").value = id;
                    document.getElementById("txtFullName").value = row.cells[1].innerText;
                    document.getElementById("txtPosition").value = row.cells[2].innerText;
                    document.getElementById("txtPhone").value = row.cells[3].innerText;
                    document.getElementById("txtEmail").value = row.cells[4].innerText;

                    document.getElementById("modalTitle").innerText = "Sửa thành viên";
                    modal.style.display = "flex";
                });
            });

            // Đóng modal
            document.getElementById("closeModal").addEventListener("click", function () {
                modal.style.display = "none";
            });

            document.getElementById("cancelBtn").addEventListener("click", function () {
                modal.style.display = "none";
            });

            // Lưu thành viên
            document.getElementById("saveTeamBtn").addEventListener("click", function () {
                const id = document.getElementById("teamId").value;
                const fullName = document.getElementById("txtFullName").value;
                const position = document.getElementById("txtPosition").value;
                const phone = document.getElementById("txtPhone").value;
                const email = document.getElementById("txtEmail").value;

                if (!fullName || !email) {
                    alert("Vui lòng nhập đầy đủ thông tin.");
                    return;
                }

                const payload = {
                    Id: id ? parseInt(id) : 0,
                    FullName: fullName,
                    Position: position,
                    Phone: phone,
                    Email: email
                };

                fetch("ContactPeople.aspx/SaveContact", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ contact: payload })
                })
                    .then(res => res.json())
                    .then(data => {
                        if (data.d === "success") {
                            alert("Lưu thành công!");
                            location.reload();
                        } else {
                            alert("Có lỗi xảy ra khi lưu!");
                        }
                    })
                    .catch(err => console.error(err));
            });

            // Xóa thành viên
            document.querySelectorAll(".action-menu .fa-trash").forEach(function (btn) {
                btn.addEventListener("click", function () {
                    const id = this.closest(".action-menu").getAttribute("data-id");
                    if (confirm("Bạn có chắc chắn muốn xóa thành viên này không?")) {
                        fetch("ContactPeople.aspx/DeleteContact", {
                            method: "POST",
                            headers: { "Content-Type": "application/json" },
                            body: JSON.stringify({ id: parseInt(id) })
                        })
                            .then(res => res.json())
                            .then(data => {
                                if (data.d === "success") {
                                    alert("Xóa thành công!");
                                    location.reload();
                                } else {
                                    alert("Không tìm thấy thành viên cần xóa!");
                                }
                            })
                            .catch(err => console.error(err));
                    }
                });
            });

            // Reset form
            function resetForm() {
                document.getElementById("teamId").value = "";
                document.getElementById("txtFullName").value = "";
                document.getElementById("txtPosition").value = "";
                document.getElementById("txtPhone").value = "";
                document.getElementById("txtEmail").value = "";
            }
        });
    </script>


</asp:Content>
