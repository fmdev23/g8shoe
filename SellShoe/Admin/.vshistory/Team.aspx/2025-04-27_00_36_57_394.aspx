<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Team.aspx.cs" Inherits="SellShoe.Admin.Team" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ THÀNH VIÊN ĐỘI NGŨ</h2>
            <div class="header-actions">
                <button type="button" class="add-product-btn" id="addMemberBtn">Thêm thành viên</button>
            </div>
        </div>

        <div class="table-container">
            <table class="products-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Họ và tên</th>
                        <th>Chức vụ</th>
                        <th>Điện thoại</th>
                        <th>Email</th>
                        <th>Ảnh đại diện</th>
                        <th>Tùy chọn</th>
                    </tr>
                </thead>
                <tbody id="membersTableBody">
                    <%for (int i = 0; i < listTeam.Count; i++) { %>
                    <tr>
                        <td><%=listTeam[i].Id %></td>
                        <td><%=listTeam[i].FullName %></td>
                        <td><%=listTeam[i].Position %></td>
                        <td><%=listTeam[i].Phone %></td>
                        <td><%=listTeam[i].Email %></td>
                        <td>
                            <% if (!string.IsNullOrEmpty(listTeam[i].Avatar)) { %>
                                <img src="<%=listTeam[i].Avatar %>" alt="Avatar" style="width:50px;height:50px;border-radius:50%;" />
                            <% } else { %>
                                <span>Không có ảnh</span>
                            <% } %>
                        </td>
                        <td class="action-cell">
                            <div class="action-menu" data-id="<%=listTeam[i].Id %>">
                                <button class="action-btn" type="button">
                                    <i class="fad fa-edit"></i>
                                </button>
                                <button class="action-btn" type="button" data-id="<%=listTeam[i].Id %>">
                                    <i class="fal fa-trash"></i>
                                </button>
                            </div>
                        </td>
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

        <!-- Add/Edit Member Modal -->
        <div class="modal" id="memberModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 id="modalTitle">Thêm thành viên</h3>
                    <button class="close-modal" id="closeModal">
                        <i class="fad fa-times"></i>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="memberForm">
                        <input type="hidden" id="memberId" />

                        <div class="form-group">
                            <label>Họ và tên</label>
                            <input type="text" id="txtFullName" />
                        </div>
                        <div class="form-group">
                            <label>Chức vụ</label>
                            <input type="text" id="txtPosition" />
                        </div>
                        <div class="form-group">
                            <label>Điện thoại</label>
                            <input type="text" id="txtPhone" />
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" id="txtEmail" />
                        </div>
                        <div class="form-group">
                            <label>Ảnh đại diện (link)</label>
                            <input type="text" id="txtAvatar" />
                        </div>

                        <div class="form-actions">
                            <button type="button" class="cancel-btn" id="cancelBtn">Thoát</button>
                            <button type="button" class="save-btn" id="saveMemberBtn">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const modal = document.getElementById("memberModal");

            document.getElementById("addMemberBtn")?.addEventListener("click", function () {
                resetForm();
                document.getElementById("modalTitle").innerText = "Thêm thành viên";
                modal.style.display = "flex";
            });

            document.getElementById("membersTableBody").addEventListener("click", function (event) {
                const target = event.target;
                const btn = target.closest("button.action-btn");
                if (!btn) return;

                const actionMenu = btn.closest(".action-menu");
                const id = actionMenu.getAttribute("data-id");
                const row = btn.closest("tr");

                if (btn.querySelector(".fa-edit")) {
                    document.getElementById("memberId").value = id;
                    document.getElementById("txtFullName").value = row.cells[1].innerText;
                    document.getElementById("txtPosition").value = row.cells[2].innerText;
                    document.getElementById("txtPhone").value = row.cells[3].innerText;
                    document.getElementById("txtEmail").value = row.cells[4].innerText;
                    document.getElementById("txtAvatar").value = row.cells[5].querySelector("img")?.src || '';

                    document.getElementById("modalTitle").innerText = "Sửa thành viên";
                    modal.style.display = "flex";
                }
                else if (btn.querySelector(".fa-trash")) {
                    if (confirm("Bạn có chắc chắn muốn xóa thành viên này không?")) {
                        fetch("Team.aspx/DeleteMember", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/json"
                            },
                            body: JSON.stringify({ id: parseInt(id) })
                        })
                            .then(res => res.json())
                            .then(data => {
                                if (data.d === "success") {
                                    alert("Xóa thành công!");
                                    row.remove();
                                } else {
                                    alert("Không tìm thấy thành viên cần xóa!");
                                }
                            })
                            .catch(err => console.error(err));
                    }
                }
            });

            document.getElementById("closeModal")?.addEventListener("click", function () {
                modal.style.display = "none";
            });
            document.getElementById("cancelBtn")?.addEventListener("click", function () {
                modal.style.display = "none";
            });

            document.getElementById("saveMemberBtn")?.addEventListener("click", function () {
                const id = document.getElementById("memberId").value;
                const fullName = document.getElementById("txtFullName").value;
                const position = document.getElementById("txtPosition").value;
                const phone = document.getElementById("txtPhone").value;
                const email = document.getElementById("txtEmail").value;
                const avatar = document.getElementById("txtAvatar").value;

                if (!fullName || !position) {
                    alert("Vui lòng nhập đầy đủ họ tên và chức vụ.");
                    return;
                }

                const payload = {
                    id: id ? parseInt(id) : 0,
                    fullName: fullName,
                    position: position,
                    phone: phone,
                    email: email,
                    avatar: avatar
                };

                fetch("Team.aspx/SaveMember", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({ member: payload })
                })
                    .then(res => res.json())
                    .then(data => {
                        if (data.d === "success") {
                            alert("Lưu thành công!");
                            location.reload();
                        } else {
                            alert("Có lỗi xảy ra!");
                        }
                    })
                    .catch(err => console.error(err));
            });

            function resetForm() {
                document.getElementById("memberId").value = "";
                document.getElementById("txtFullName").value = "";
                document.getElementById("txtPosition").value = "";
                document.getElementById("txtPhone").value = "";
                document.getElementById("txtEmail").value = "";
                document.getElementById("txtAvatar").value = "";
            }
        });
    </script>

</asp:Content>
