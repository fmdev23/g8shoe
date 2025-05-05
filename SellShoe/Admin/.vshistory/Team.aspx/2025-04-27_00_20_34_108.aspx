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
                            <div class="action-menu" data-id="<%=listTeam[i].Id %>">
                                <button class="action-btn" type="button">
                                    <i class="fad fa-edit"></i>
                                </button>
                                <button class="action-btn" type="button" data-id="<%=listTeam[i].Id %>">
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
                        <input type="text" id="txtFullName" />
                    </div>
                    <div class="form-group">
                        <label>Vị trí</label>
                        <input type="text" id="txtPosition" />
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="text" id="txtPhone" />
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="text" id="txtEmail" />
                    </div>
                    <div class="form-group">
                        <label>Ảnh đại diện</label>
                        <input type="file" id="avatarUpload" accept="image/*" />
                        <div id="avatarPreviewContainer" style="margin-top: 10px;">
                            <img id="avatarPreview" src="" alt="Preview" style="max-width: 150px; display: none; border-radius: 8px;" />
                        </div>
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
            const addProductBtn = document.getElementById('addProductBtn');
            const teamModal = document.getElementById('teamModal');
            const closeModal = document.getElementById('closeModal');
            const cancelBtn = document.getElementById('cancelBtn');
            const saveProductBtn = document.getElementById('saveProductBtn');
            const form = document.getElementById('teamForm');

            const avatarUpload = document.getElementById('avatarUpload');
            const avatarPreview = document.getElementById('avatarPreview');

            let isEditing = false;
            let editingId = null;

            function openModal() {
                teamModal.style.display = "flex";
                teamModal.style.opacity = "1";
                teamModal.style.pointerEvents = "auto";
            }

            function closeModalFunc() {
                teamModal.style.display = "none";
                teamModal.style.opacity = "0";
                teamModal.style.pointerEvents = "none";
            }

            function resetForm() {
                form.reset();
                document.getElementById('teamId').value = '';
                avatarPreview.src = '';
                avatarPreview.style.display = 'none';
                isEditing = false;
                editingId = null;
                document.getElementById('modalTitle').innerText = "Thêm thành viên";
            }

            addProductBtn.addEventListener('click', function () {
                resetForm();
                openModal();
            });

            closeModal.addEventListener('click', function () {
                closeModalFunc();
            });

            cancelBtn.addEventListener('click', function () {
                closeModalFunc();
            });

            saveProductBtn.addEventListener('click', function () {
                const formData = new FormData();
                formData.append('FullName', document.getElementById('txtFullName').value);
                formData.append('Position', document.getElementById('txtPosition').value);
                formData.append('Phone', document.getElementById('txtPhone').value);
                formData.append('Email', document.getElementById('txtEmail').value);
                if (avatarUpload.files[0]) {
                    formData.append('Avatar', avatarUpload.files[0]);
                }
                if (isEditing) {
                    formData.append('Id', editingId);
                    console.log('Cập nhật thành viên:', editingId);
                    // Gọi API cập nhật ở đây (fetch PUT)
                } else {
                    console.log('Thêm thành viên mới');
                    // Gọi API thêm mới ở đây (fetch POST)
                }
                closeModalFunc();
            });

            // Khi chọn file ảnh => preview ra
            avatarUpload.addEventListener('change', function () {
                const file = avatarUpload.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        avatarPreview.src = e.target.result;
                        avatarPreview.style.display = 'block';
                    };
                    reader.readAsDataURL(file);
                }
            });

            // Edit nút
            const editButtons = document.querySelectorAll('.action-menu .fa-edit');
            editButtons.forEach(function (btn) {
                btn.addEventListener('click', function (e) {
                    e.stopPropagation();
                    const id = this.closest('.action-menu').getAttribute('data-id');
                    editingId = id;
                    isEditing = true;

                    const row = this.closest('tr');
                    document.getElementById('teamId').value = id;
                    document.getElementById('txtFullName').value = row.children[1].innerText;
                    document.getElementById('txtPosition').value = row.children[2].innerText;
                    document.getElementById('txtPhone').value = row.children[3].innerText;
                    document.getElementById('txtEmail').value = row.children[4].innerText;

                    // Load ảnh cũ
                    const avatarUrl = row.children[5].innerText; // Vì ảnh đang nằm trong <th> avatar
                    if (avatarUrl) {
                        avatarPreview.src = avatarUrl;
                        avatarPreview.style.display = 'block';
                    } else {
                        avatarPreview.src = '';
                        avatarPreview.style.display = 'none';
                    }

                    document.getElementById('modalTitle').innerText = "Cập nhật thành viên";
                    openModal();
                });
            });

            // Delete nút
            const deleteButtons = document.querySelectorAll('.action-menu .fa-trash');
            deleteButtons.forEach(function (btn) {
                btn.addEventListener('click', function (e) {
                    e.stopPropagation();
                    const id = this.closest('.action-menu').getAttribute('data-id');
                    if (confirm('Bạn có chắc muốn xóa thành viên này không?')) {
                        console.log('Xóa thành viên ID:', id);
                        // Gọi API delete ở đây
                    }
                });
            });
        });
    </script>




</asp:Content>
