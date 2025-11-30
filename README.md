# ĐỒ ÁN MÔN HỌC: HỆ THỐNG QUẢN LÝ BÁN HÀNG 🛒

-----

## 🚀 Giới Thiệu Chung

Đây là đồ án môn học Python sử dụng thư viện **Tkinter** cho giao diện người dùng và **pyodbc** để kết nối với **SQL Server**. Hệ thống được xây dựng nhằm mục đích quản lý toàn diện các nghiệp vụ cơ bản của một cửa hàng hoặc doanh nghiệp bán lẻ/phân phối, bao gồm: **Bán hàng (Giao Dịch)**, **Quản lý Danh mục (Sản phẩm, Khách hàng, Nhà cung cấp)**, **Quản lý Kho hàng (Tồn kho)** và **Đăng nhập/Phân quyền**.

Mục tiêu của dự án là cung cấp một công cụ trực quan, đồng bộ về màu sắc và dễ sử dụng để theo dõi, kiểm soát hoạt động kinh doanh và tồn kho.

-----
✨ Tầm nhìn Dự án
Hệ thống được xây dựng trên nền tảng Python và Tkinter (cho giao diện người dùng Desktop hiện đại) kết hợp với SQL Server (cho khả năng quản lý dữ liệu mạnh mẽ). Đây là một giải pháp quản lý bán hàng toàn diện, được thiết kế đặc biệt để tối ưu hóa quy trình vận hành, kiểm soát tồn kho, và nâng cao hiệu quả giao dịch cho các doanh nghiệp vừa và nhỏ.

Với giao diện người dùng đồng bộ, trực quan và thân thiện, đồ án không chỉ giải quyết các bài toán nghiệp vụ cơ bản mà còn hướng tới việc cung cấp thông tin kịp thời, giúp người quản lý đưa ra quyết định nhanh chóng và chính xác.

## 💡 Các Tính Năng Chính

Hệ thống được thiết kế với các module và chức năng cốt lõi sau:

### 1\. Phân hệ Đăng nhập & An toàn (`Login.py`)

  * **Đăng nhập Người dùng:** Yêu cầu tên đăng nhập và mật khẩu để truy cập hệ thống.
  * **Kết nối CSDL:** Thiết lập kết nối an toàn đến cơ sở dữ liệu **SQL Server** (`QuanLyBanHang`) qua **pyodbc**.

### 2\. Phân hệ Quản lý Danh mục (`QuanLy.py`)

  * **Quản lý Sản phẩm:** Thêm mới, chỉnh sửa, xóa, và tìm kiếm thông tin chi tiết về các mặt hàng.
  * **Quản lý Khách hàng:** Quản lý thông tin khách hàng (Họ tên, Ngày sinh, SĐT, v.v.).
  * **Quản lý Nhà cung cấp (NCC):** Quản lý thông tin đối tác cung cấp hàng hóa (Tên NCC, Địa chỉ, SĐT).
  * **Quản lý Nhân viên:** Quản lý thông tin nhân sự.

### 3\. Phân hệ Giao Dịch Bán hàng (`GiaoDich.py`)

  * **Lập Hóa đơn:** Tạo mới hóa đơn bán hàng, bao gồm chi tiết sản phẩm, số lượng, đơn giá.
  * **Quản lý Khuyến mãi:** Xem và áp dụng các chương trình khuyến mãi hiện có.
  * **Theo dõi Hóa đơn:** Xem lại lịch sử các giao dịch đã thực hiện.

### 4\. Phân hệ Kho Hàng & Tồn kho (`KhoHang.py`)

  * **Kiểm tra Tồn kho:** Xem số lượng tồn kho hiện tại của từng sản phẩm.
* **Quản lý Nhập hàng:**
      * Theo dõi **Phiếu Nhập** hàng từ các Nhà Cung Cấp.
      * Cập nhật số lượng nhập và giá vốn đơn vị.

### 5\. Cơ sở dữ liệu (`SQLQuery1.sql`)

  * Tạo cấu trúc bảng dữ liệu chuẩn (như `NHANVIEN`, `KHACHHANG`, `SANPHAM`, `HOADON`, `CHITIETHOADON`, `PHIEUNHAP`, `CHITIETPHIEUNHAP`, `KHUYENMAI`) để lưu trữ dữ liệu.
  * Cung cấp dữ liệu mẫu (INSERT INTO) để kiểm thử hệ thống.

-----

## 🛠️ Hướng dẫn Cài đặt & Chạy Ứng dụng

Để chạy project này trên máy tính của bạn, vui lòng làm theo các bước sau:

### 1\. Yêu cầu Hệ thống

  * **Ngôn ngữ:** Python phiên bản 3.x
  * **Hệ quản trị CSDL:** SQL Server (Đã cài đặt và có thể truy cập)

### 2\. Cài đặt Thư viện Python

Mở Terminal hoặc Command Prompt và chạy lệnh sau:

```bash
pip install pyodbc tkinter
```

*(Thư viện `tkinter` thường được cài đặt sẵn với Python, nhưng `pyodbc` là bắt buộc.)*

### 3\. Cấu hình Kết nối CSDL

  * Mở file **`SQLQuery1.sql`** và chạy toàn bộ script trên SQL Server Management Studio (SSMS) để tạo CSDL **`QuanLyBanHang`** và điền dữ liệu mẫu.
  * Đảm bảo chuỗi kết nối trong các file Python (`TrangChu.py`, `Login.py`, `QuanLy.py`, `GiaoDich.py`, `KhoHang.py`) khớp với cấu hình máy của bạn, cụ thể là dòng:
    ```python
    'SERVER=DESKTOP-DR4Q3K4;' 
    'DATABASE=QuanLyBanHang;'
    'Trusted_Connection=yes;'
    ```
    (Thay thế `'SERVER=DESKTOP-DR4Q3K4;'` bằng tên máy chủ SQL Server của bạn nếu cần).

### 4\. Chạy Ứng dụng

Chạy file **`TrangChu.py`** để khởi động giao diện chính của ứng dụng:

```bash
python TrangChu.py
```
-----
