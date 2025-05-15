<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OrderInfoCT.ascx.cs" Inherits="SellShoe.UserControl.OrderInfoCT" %>


<div class="header-border"></div>
    <div class="container">
        <div class="delivery-info">
            <div class="recipient-info">
                <h2 class="recipient-title">Địa Chỉ Nhận Hàng</h2>
                <div class="recipient-name">Minh Phú</div>
                <div class="recipient-phone">(+84) 967394474</div>
                <div class="recipient-address">
                    274a/8, Trần Vĩnh Kiết, Kv 2, kề bên Nhà thuốc Khánh Vân, Phường An Bình, Quận Ninh Kiều, Cần Thơ
                </div>
            </div>
            
            <div class="tracking-info">
                <div class="tracking-number">SPX Express</div>
                <div class="express-label">SPXVN05174790675</div>
                
                <div class="tracking-timeline">
                    <div class="timeline-item">
                        <div class="timeline-dot active"></div>
                        <div class="timeline-line"></div>
                        <div class="timeline-content">
                            <div class="timeline-time">23:54 09-05-2025</div>
                            <div class="timeline-status">Đang vận chuyển</div>
                            <div class="timeline-status">Đơn hàng đã rời kho phân loại tới SW SOC</div>
                        </div>
                    </div>
                    
                    <div class="timeline-item">
                        <div class="timeline-dot"></div>
                        <div class="timeline-line"></div>
                        <div class="timeline-content">
                            <div class="timeline-time">22:51 09-05-2025</div>
                            <div class="timeline-status normal">Đơn hàng đã đến kho phân loại Phương Sài Đông, Quận Long Biên, Hà Nội</div>
                        </div>
                    </div>
                    
                    <div class="timeline-item">
                        <div class="timeline-dot"></div>
                        <div class="timeline-line"></div>
                        <div class="timeline-content">
                            <div class="timeline-time">22:51 09-05-2025</div>
                            <div class="timeline-status normal">Đơn hàng đã đến bưu cục</div>
                        </div>
                    </div>
                    
                    <div class="timeline-item">
                        <div class="timeline-dot"></div>
                        <div class="timeline-line"></div>
                        <div class="timeline-content">
                            <div class="timeline-time">21:54 09-05-2025</div>
                            <div class="timeline-status normal">Đơn hàng đã rời bưu cục</div>
                        </div>
                    </div>
                    
                    <div class="timeline-item">
                        <div class="timeline-dot"></div>
                        <div class="timeline-line"></div>
                        <div class="timeline-content">
                            <div class="timeline-time">18:14 09-05-2025</div>
                            <div class="timeline-status normal">Đơn hàng đã đến bưu cục Xã Đại Xuyên, Huyện Phú Xuyên, Hà Nội</div>
                        </div>
                    </div>
                    
                    <div class="timeline-item">
                        <div class="timeline-dot"></div>
                        <div class="timeline-content">
                            <div class="timeline-time">16:05 09-05-2025</div>
                            <div class="timeline-status normal">Đơn vị vận chuyển lấy hàng thành công</div>
                        </div>
                    </div>
                </div>
                
                <div class="verified-section">
                    <span class="verified-badge">ĐÓNG KIỂM</span>
                    <span class="verified-text">Được đóng kiểm.</span>
                    <a href="#" class="learn-more">Tìm hiểu thêm</a>
                </div>
            </div>
        </div>
        
        <div class="store-section">
            <div class="store-info">
                <span class="store-icon">🏪</span>
                <span class="store-name">Giày Max Rẻ Store</span>
            </div>
            
            <div class="action-buttons">
                <a href="#" class="btn btn-chat">
                    <span class="btn-icon">💬</span> Chat
                </a>
                <a href="#" class="btn btn-view">
                    <span class="btn-icon">🔍</span> Xem Shop
                </a>
            </div>
            
            <div style="margin-left: 10px; color: #999;">
                <span class="info-icon">i</span>
            </div>
        </div>
        
        <div class="product-section">
            <div class="product-item">
                <div class="product-image">
                    <img src="/placeholder.svg?height=80&width=80" alt="Giày Thể Thao Samba">
                </div>
                
                <div class="product-details">
                    <div class="product-title">Giày Thể Thao Samba Low Đế Nâu, Giày Sneaker AdiDa White Black Gum" Hàng Mới 100% Full Box</div>
                    <div class="product-category">Phân loại hàng: Samba trắng đế nâu,41</div>
                    <div class="product-quantity">x1</div>
                </div>
                
                <div class="product-price">
                    <div class="price-original">₫500.000</div>
                    <div class="price-current">₫175.000</div>
                </div>
            </div>
            
            <div class="order-summary">
                <div class="summary-row">
                    <div class="summary-label">Tổng tiền hàng</div>
                    <div class="summary-value">₫175.000</div>
                </div>
                
                <div class="summary-row">
                    <div class="summary-label">Phí vận chuyển</div>
                    <div class="summary-value">₫51.100</div>
                </div>
                
                <div class="summary-row">
                    <div class="summary-label">Giảm giá phí vận chuyển <span class="info-icon">i</span></div>
                    <div class="summary-value discount">-₫51.100</div>
                </div>
                
                <div class="summary-row">
                    <div class="summary-label">Voucher từ Shopee</div>
                    <div class="summary-value discount">-₫21.000</div>
                </div>
                
                <div class="summary-row">
                    <div class="summary-label">Thành tiền</div>
                    <div class="summary-value summary-total">₫154.000</div>
                </div>
            </div>
        </div>
    </div>