﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Team.aspx.cs" Inherits="SellShoe.Admin.Team" %>

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
                    <%for (int i = 0; i < listTeam.Count; i++)
                        { %>
                    <tr>
                        <td><%=listTeam[i].Id %></td>
                        <td><%=listTeam[i].FullName %></td>
                        <td><%=listTeam[i].Position %></td>
                        <td><%=listTeam[i].Phone %></td>
                        <td><%=listTeam[i].Email %></td>
                        <td><%=listTeam[i].Avatar %></td>
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
                            <label>Ảnh đại diện</label>
                            <input type="text" id="txtAvatarUrl" placeholder="Đường dẫn ảnh..." />
                            <div style="margin-top: 10px;">
                                <img id="previewAvatar" src="" alt="Ảnh đại diện" style="max-width: 100px; max-height: 100px;" />
                            </div>
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
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const modal = document.getElementById("memberModal");

            // Reset form
            function resetForm() {
                document.getElementById("memberId").value = "";
                document.getElementById("txtFullName").value = "";
                document.getElementById("txtPosition").value = "";
                document.getElementById("txtPhone").value = "";
                document.getElementById("txtEmail").value = "";
                document.getElementById("txtAvatarUrl").value = "";
                document.getElementById("previewAvatar").src = ""; // Clear preview ảnh
            }

            // Open modal - Thêm thành viên
            document.getElementById("addMemberBtn")?.addEventListener("click", function () {
                resetForm();
                document.getElementById("modalTitle").innerText = "Thêm thành viên";
                modal.style.display = "flex";
            });

            // Xử lý click sửa / xóa trong bảng
            document.getElementById("membersTableBody").addEventListener("click", function (event) {
                const target = event.target;
                const btn = target.closest("button.action-btn");
                if (!btn) return;

                const actionMenu = btn.closest(".action-menu");
                const id = actionMenu.getAttribute("data-id");
                const row = btn.closest("tr");

                if (btn.querySelector(".fa-edit")) {
                    // Sửa
                    document.getElementById("memberId").value = id;
                    document.getElementById("txtFullName").value = row.cells[1].innerText;
                    document.getElementById("txtPosition").value = row.cells[2].innerText;
                    document.getElementById("txtPhone").value = row.cells[3].innerText;
                    document.getElementById("txtEmail").value = row.cells[4].innerText;

                    const avatarImg = row.cells[5].querySelector("img");
                    if (avatarImg) {
                        document.getElementById("txtAvatarUrl").value = avatarImg.src;
                        document.getElementById("previewAvatar").src = avatarImg.src;
                    } else {
                        document.getElementById("txtAvatarUrl").value = "";
                        document.getElementById("previewAvatar").src = "";
                    }

                    document.getElementById("modalTitle").innerText = "Sửa thành viên";
                    modal.style.display = "flex";
                }
                else if (btn.querySelector(".fa-trash")) {
                    // Xóa
                    if (confirm("Bạn có chắc chắn muốn xóa thành viên này không?")) {
                        fetch("Team.aspx/DeleteMember", {
                            method: "POST",
                            headers: { "Content-Type": "application/json" },
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

            // Đóng modal
            document.getElementById("closeModal")?.addEventListener("click", function () {
                modal.style.display = "none";
            });
            document.getElementById("cancelBtn")?.addEventListener("click", function () {
                modal.style.display = "none";
            });

            // Lưu thành viên
            document.getElementById("saveMemberBtn")?.addEventListener("click", function () {
                const id = document.getElementById("memberId").value;
                const fullName = document.getElementById("txtFullName").value.trim();
                const position = document.getElementById("txtPosition").value.trim();
                const phone = document.getElementById("txtPhone").value.trim();
                const email = document.getElementById("txtEmail").value.trim();
                const avatar = document.getElementById("txtAvatarUrl").value.trim();

                if (!fullName || !position) {
                    alert("Vui lòng nhập đầy đủ họ tên và chức vụ.");
                    return;
                }

                fetch("Team.aspx/SaveMember", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({
                        id: id ? parseInt(id) : 0,
                        fullName,
                        position,
                        phone,
                        email,
                        avatar
                    })
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

        });
    </script>


</asp:Content>
