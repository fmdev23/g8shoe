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
                <button class="add-product-btn" id="addProductBtn" type="button">Thêm thành viên</button>
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
            const addProductBtn = document.getElementById('addProductBtn');
            const closeModal = document.getElementById('closeModal');
            const cancelBtn = document.getElementById('cancelBtn');
            const saveProductBtn = document.getElementById('saveProductBtn');

            const teamForm = document.getElementById('teamForm');
            const teamId = document.getElementById('teamId');
            const txtFullName = document.getElementById('txtFullName');
            const txtPosition = document.getElementById('txtPosition');
            const txtPhone = document.getElementById('txtPhone');
            const txtEmail = document.getElementById('txtEmail');
            const modalTitle = document.getElementById('modalTitle');

            // Hiển thị modal thêm mới
            document.getElementById("addProductBtn")?.addEventListener("click", function () {
                resetForm();
                document.getElementById("modalTitle").innerText = "Thêm thành viên";
            });

            // Đóng modal
            closeModal.addEventListener('click', closeModalFunc);
            cancelBtn.addEventListener('click', closeModalFunc);

            function closeModalFunc() {
                modal.style.display = 'none';
                resetForm();
            }

            function openModal(contact = null) {
                modal.style.display = 'flex';
                if (contact) {
                    modalTitle.textContent = 'Chỉnh sửa thành viên';
                    teamId.value = contact.Id;
                    txtFullName.value = contact.FullName;
                    txtPosition.value = contact.Position;
                    txtPhone.value = contact.Phone;
                    txtEmail.value = contact.Email;
                } else {
                    modalTitle.textContent = 'Thêm thành viên';
                    modal.style.display = "flex";
                    resetForm();
                }
            }

            function resetForm() {
                teamId.value = '';
                txtFullName.value = '';
                txtPosition.value = '';
                txtPhone.value = '';
                txtEmail.value = '';
            }

            // Bắt sự kiện lưu (thêm/sửa)
            saveProductBtn.addEventListener('click', function () {
                const contact = {
                    Id: teamId.value ? parseInt(teamId.value) : 0,
                    FullName: txtFullName.value.trim(),
                    Position: txtPosition.value.trim(),
                    Phone: txtPhone.value.trim(),
                    Email: txtEmail.value.trim()
                };

                fetch('Team.aspx/SaveContact', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8'
                    },
                    body: JSON.stringify({ contact: contact })
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.d === "success") {
                            alert("Lưu thành viên thành công!");
                            location.reload();
                        } else {
                            alert("Có lỗi xảy ra khi lưu thành viên!");
                        }
                    })
                    .catch(error => {
                        console.error(error);
                        alert("Có lỗi xảy ra khi kết nối server!");
                    });
            });

            // Bắt sự kiện click Edit và Delete
            document.querySelectorAll('.action-menu .action-btn').forEach(function (btn) {
                btn.addEventListener('click', function (e) {
                    const id = this.parentElement.getAttribute('data-id');
                    const isDelete = this.querySelector('i').classList.contains('fa-trash');

                    if (isDelete) {
                        if (confirm('Bạn có chắc chắn muốn xóa thành viên này?')) {
                            deleteContact(id);
                        }
                    } else {
                        // Edit: lấy dữ liệu từ bảng
                        const row = this.closest('tr');
                        const contact = {
                            Id: id,
                            FullName: row.children[1].innerText,
                            Position: row.children[2].innerText,
                            Phone: row.children[3].innerText,
                            Email: row.children[4].innerText
                        };
                        openModal(contact);
                    }
                });
            });

            function deleteContact(id) {
                fetch('Team.aspx/DeleteContact', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8'
                    },
                    body: JSON.stringify({ id: parseInt(id) })
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.d === "success") {
                            alert("Xóa thành viên thành công!");
                            location.reload();
                        } else {
                            alert("Không tìm thấy thành viên hoặc lỗi server!");
                        }
                    })
                    .catch(error => {
                        console.error(error);
                        alert("Có lỗi xảy ra khi kết nối server!");
                    });
            }
        });
    </script>



</asp:Content>
