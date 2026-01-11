<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pending Amount – Customer List</title>

<!-- ================== CSS ================== -->

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- DataTables -->
<link href="https://cdn.datatables.net/1.13.8/css/dataTables.bootstrap5.min.css" rel="stylesheet">

<!-- ================== JS ================== -->

<!-- jQuery (ONLY ONCE) -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- DataTables -->
<script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.8/js/dataTables.bootstrap5.min.js"></script>

<!-- Highlight plugin -->
<script src="https://bartaz.github.io/sandbox.js/jquery.highlight.js"></script>

<!-- ================== GOLDEN THEME CSS ================== -->
<style>
    body {
        background: linear-gradient(135deg, #FFF8E1, #F5E6C8);
        font-family: 'Segoe UI', sans-serif;
    }

    .gold-card {
        background: #ffffff;
        border-radius: 16px;
        padding: 25px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        border-top: 5px solid #D4AF37;
    }

    .gold-title {
        color: #B8962E;
        font-weight: 700;
        text-align: center;
    }

    table.dataTable thead {
        background: #1c1c1c;
        color: #D4AF37;
    }

    .table td, .table th {
        text-align: center;
        vertical-align: middle;
        font-size: 14px;
    }

    table.dataTable tbody tr:hover {
        background-color: #FFF8E1;
    }

    .amount-green {
        color: #198754;
        font-weight: bold;
    }

    .amount-red {
        color: #dc3545;
        font-weight: bold;
    }

    a.bill-link {
        color: #B8962E;
        font-weight: 600;
        text-decoration: none;
    }

    a.bill-link:hover {
        text-decoration: underline;
        color: #1c1c1c;
    }

    .btn-gold {
        background: linear-gradient(135deg, #D4AF37, #B8962E);
        color: #1c1c1c;
        font-weight: bold;
        border-radius: 25px;
        padding: 8px 22px;
        border: none;
        text-decoration: none;
    }

    .btn-gold:hover {
        background: linear-gradient(135deg, #B8962E, #D4AF37);
        color: #fff;
    }

    /* Search highlight */
    span.highlight {
        background-color: #FFE066;
        padding: 2px 4px;
        border-radius: 4px;
        font-weight: bold;
    }

    /* DataTables input styling */
    .dataTables_filter input,
    .dataTables_length select {
        border-radius: 20px;
        border: 1px solid #D4AF37;
        padding: 5px 10px;
    }
</style>
</head>

<body>

<div class="container mt-5">
    <div class="gold-card">

        <h3 class="gold-title mb-4">
            💎 Pending Amount – Customer List
        </h3>

        <c:if test="${not empty msg}">
            <div class="alert alert-success text-center fw-bold">
                ${msg}
            </div>
        </c:if>

        <table id="billTable" class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th>SR No.</th>
                    <th>Bill No</th>
                    <th>Customer Name</th>
                    <th>Mobile</th>
                    <th>Address</th>
                    <th>Item Description</th>
                    <th>Total Amount</th>
                    <th>Deposited Amount</th>
                    <th>Pending Amount</th>
                    <th>Purchase Date</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="bill" items="${bills}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>

                        <td>
                            <a class="bill-link"
                               href="${pageContext.request.contextPath}/depositAmount/${bill.id}">
                                ${bill.billNo}
                            </a>
                        </td>

                        <td>${bill.customerName}</td>
                        <td>${bill.mobile}</td>
                        <td>${bill.address}</td>
                        <td>${bill.descriptionItem}</td>

                        <td>₹ ${bill.finalAmount}</td>

                        <td class="amount-green">
                            ₹ ${bill.totalDeposit + bill.firstPayment}
                        </td>

                        <td class="amount-red">
                            ₹
                            <fmt:formatNumber
                                value="${bill.finalAmount - (bill.totalDeposit + bill.firstPayment)}"
                                minFractionDigits="2"
                                maxFractionDigits="2"/>
                        </td>

                        <td>
                            <fmt:formatDate value="${bill.date}" pattern="dd-MM-yyyy"/>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty bills}">
                    <tr>
                        <td colspan="10" class="text-danger fw-bold">
                            No Data Found
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/" class="btn-gold">
                Back
            </a>
        </div>

    </div>
</div>

<!-- ================== DATATABLE INIT (SAFE) ================== -->
<script>
    $(document).ready(function () {

        // ✅ Prevent reinitialisation error
        if ($.fn.DataTable.isDataTable('#billTable')) {
            $('#billTable').DataTable().clear().destroy();
        }

        var table = $('#billTable').DataTable({
            pageLength: 10,
            lengthMenu: [5, 10, 25, 50],
            ordering: true,
            language: {
                search: "🔍 Search:",
                lengthMenu: "Show _MENU_ entries"
            }
        });

        // 🔍 Highlight searched text
        table.on('draw', function () {
            var body = $(table.table().body());
            body.unhighlight();
            body.highlight(table.search());
        });
    });
</script>

</body>
</html>
