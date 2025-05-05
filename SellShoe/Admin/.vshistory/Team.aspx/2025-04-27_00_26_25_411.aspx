<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Team.aspx.cs" Inherits="SellShoe.Admin.Team" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ THÀNH VIÊN</h2>
            <div class="header-actions">
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
                        <th>Tuỳ chọn</th>
                    </tr>
                </thead>
                <tbody id="productsTableBody">
                    <% for (int i = 0; i < listTeam.Count; i++) { %>
                        <tr>
                            <td><%= listTeam[i].Id %></td>
                            <td><%= listTeam[i].FullName %></td>
                            <td><%= listTeam[i].Position %></td>
                            <td><%= listTeam[i].Phone %></td>
                            <td><%= listTeam[i].Email %></td>
                            <td><img src="<%= listTeam[i].Avatar %>" alt="Avatar" style="width:50px;height:50px;border-radius:50%;"/></td>
                            <td>
                                <button class="edit-btn" data-id="<%= listTeam[i].Id %>">Sửa</button>
                                <button class="delete-btn" data-id="<%= listTeam[i].Id %>">Xoá</button>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal Thêm/Sửa Thành viên -->
    <div class="modal" id="teamModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">Thêm thành viên</h3>
                <button class="close-modal" id="closeModal">
                    <i class="fad fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <form id="teamForm" enctype="multipart/form-data">
                    <input type="hidden" id="teamId" />

                    <div class="form-group">
                        <label>Tên thành viên</label>
                        <input type="text" id="txtFullName" required />
                    </div>

                    <div class="form-group">
                        <label>Vị trí</label>
                        <input type="text" id="txtPosition" required />
                    </div>

                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="text" id="txtPhone" required />
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" id="txtEmail" required />
                    </div>

                    <div class="form-group">
                        <label>Ảnh đại diện</label>
                        <input type="file" id="fileAvatar" accept="image/*" />
                        <img id="previewAvatar" style="width:100px;height:100px;margin-top:10px;display:none;border-radius:50%;" />
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
        const modal = document.getElementById('teamModal');
        const form = document.getElementById('teamForm');
        const addProductBtn = document.getElementById('addProductBtn');
        const saveProductBtn = document.getElementById('saveProductBtn');
        const cancelBtn = document.getElementById('cancelBtn');
        const closeModalBtn = document.getElementById('closeModal');
        const previewAvatar = document.getElementById('previewAvatar');
        const fileAvatar = document.getElementById('fileAvatar');

        let currentId = 0;
        let currentAvatarUrl = "";

        function openModal(title) {
            document.getElementById('modalTitle').innerText = title;
            modal.style.display = 'flex';
        }

        function closeModal() {
            modal.style.display = 'none';
            form.reset();
            previewAvatar.style.display = 'none';
            currentId = 0;
            currentAvatarUrl = "";
        }

        addProductBtn.addEventListener('click', function () {
            openModal('Thêm thành viên');
        });

        cancelBtn.addEventListener('click', closeModal);
        closeModalBtn.addEventListener('click', closeModal);

        document.querySelectorAll('.edit-btn').forEach(btn => {
            btn.addEventListener('click', function () {
                const id = this.getAttribute('data-id');
                const row = this.closest('tr');
                const cells = row.getElementsByTagName('td');

                document.getElementById('teamId').value = id;
                document.getElementById('txtFullName').value = cells[1].innerText;
                document.getElementById('txtPosition').value = cells[2].innerText;
                document.getElementById('txtPhone').value = cells[3].innerText;
                document.getElementById('txtEmail').value = cells[4].innerText;

                const img = row.querySelector('img');
                if (img) {
                    previewAvatar.src = img.src;
                    previewAvatar.style.display = 'block';
                    currentAvatarUrl = img.src;
                }

                currentId = id;
                openModal('Sửa thành viên');
            });
        });

        document.querySelectorAll('.delete-btn').forEach(btn => {
            btn.addEventListener('click', function () {
                const id = this.getAttribute('data-id');
                if (confirm('Bạn có chắc chắn muốn xoá thành viên này không?')) {
                    fetch('Team.aspx/DeleteContact', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ id: parseInt(id) })
                    })
                        .then(response => response.json())
                        .then(data => {
                            if (data.d === "success") {
                                alert('Xoá thành công!');
                                location.reload();
                            } else {
                                alert('Xoá thất bại!');
                            }
                        });
                }
            });
        });

        fileAvatar.addEventListener('change', function () {
            const file = this.files[0];
            if (!file) return;

            const validTypes = ['image/jpeg', 'image/png', 'image/jpg'];
            if (!validTypes.includes(file.type)) {
                alert('Chỉ chấp nhận file ảnh JPG, JPEG, PNG.');
                fileAvatar.value = '';
                return;
            }

            if (file.size > 2 * 1024 * 1024) {
                alert('Dung lượng ảnh phải nhỏ hơn 2MB.');
                fileAvatar.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function (e) {
                previewAvatar.src = e.target.result;
                previewAvatar.style.display = 'block';
            };
            reader.readAsDataURL(file);
        });

        saveProductBtn.addEventListener('click', function () {
            const formData = new FormData();
            const file = fileAvatar.files[0];

            if (file) {
                // Nếu có file mới, upload ảnh
                const reader = new FileReader();
                reader.onload = function (e) {
                    currentAvatarUrl = e.target.result; // Base64
                    saveData();
                };
                reader.readAsDataURL(file);
            } else {
                // Không có file mới, dùng ảnh cũ
                saveData();
            }
        });

        function saveData() {
            const data = {
                Id: parseInt(document.getElementById('teamId').value) || 0,
                FullName: document.getElementById('txtFullName').value,
                Position: document.getElementById('txtPosition').value,
                Phone: document.getElementById('txtPhone').value,
                Email: document.getElementById('txtEmail').value,
                Avatar: currentAvatarUrl
            };

            fetch('Team.aspx/SaveContact', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ contact: data })
            })
                .then(response => response.json())
                .then(res => {
                    if (res.d === "success") {
                        alert('Lưu thành công!');
                        location.reload();
                    } else {
                        alert('Đã xảy ra lỗi khi lưu.');
                    }
                });
        }
    });
</script>

</asp:Content>
