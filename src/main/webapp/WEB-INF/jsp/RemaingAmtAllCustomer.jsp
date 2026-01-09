 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- DataTables CSS -->
<link href="https://cdn.datatables.net/1.13.8/css/dataTables.bootstrap5.min.css" rel="stylesheet">
<!-- Highlight plugin -->
<script src="https://cdn.jsdelivr.net/gh/bartaz/sandbox.js/jquery.highlight.js"></script>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- DataTables -->
<script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.8/js/dataTables.bootstrap5.min.js"></script>

<!-- Highlight plugin (stable) -->
<script src="https://bartaz.github.io/sandbox.js/jquery.highlight.js"></script>

<!-- jQuery (Required) -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.8/js/dataTables.bootstrap5.min.js"></script>


<!DOCTYPE html>
<html>
<head>
<title>Bill List</title>

<style>
	.highlight {
	    background-color: #7CFC98;   /* green */
	    font-weight: bold;
	    padding: 2px;
	    border-radius: 3px;
	}
    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 13px;
    }
    th, td {
        border: 1px solid #ccc;
        padding: 6px;
        text-align: center;
    }
    th {
        background: #f2f2f2;
    }
    .edit {
        background: #4CAF50;
        color: white;
        padding: 4px 8px;
        text-decoration: none;
        border-radius: 4px;
    }
    .delete {
        background: #f44336;
        color: white;
        padding: 4px 8px;
        text-decoration: none;
        border-radius: 4px;
    }
	
	/* Search highlight green */
	span.highlight {
	    background-color: #a6f4a6;
	    color: #000;
	    font-weight: bold;
	    padding: 2px;
	    border-radius: 3px;
	}

</style>
</head>

<body>



<c:if test="${not empty msg}">
    <p style="color: green">${msg}</p>
</c:if>
<div class="container mt-4">
    <h3 class="text-center mb-3">Pending Amount – Customer List</h3>

	<table id="billTable" class="table table-bordered table-striped table-hover">
	    <thead class="table-dark">
	        <tr>
	            <th>SR No.</th>
				<th>Bill No</th>
	            <th>Customer Name</th>
				<th>Mobile</th>
				<th>Address</th>
				<th>Description Item</th>
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
					 <a href="${pageContext.request.contextPath}/depositAmount/${bill.id}">
					   ${bill.billNo}
						                    </a>
						                </td>
	                <td>${bill.customerName}</td>
					<td>${bill.mobile}</td>
					<td>${bill.address}</td>
					<td>${bill.descriptionItem}</td>
	                <td>₹ ${bill.finalAmount}</td>
					<td class="text-success fw-bold">
					    ₹ ${bill.totalDeposit + bill.firstPayment}
					</td>
	                <td class="text-danger fw-bold"> ₹ ${bill.finalAmount - (bill.totalDeposit + bill.firstPayment)}</td>
	                <td>
	                    <fmt:formatDate value="${bill.date}" pattern="dd-MM-yyyy"/>
	                </td>
	            </tr>
	        </c:forEach>

	        <c:if test="${empty bills}">
	            <tr>
	                <td colspan="7" class="text-center text-danger">No Data Found</td>
	            </tr>
	        </c:if>
	    </tbody>
	</table>
</div>
<br>
<a href="${pageContext.request.contextPath}/">➕ Add New Bill</a>

</body>

<script>
$(document).ready(function () {
    var table = $('#billTable').DataTable({
        paging: true,
        searching: true,
        ordering: true,
        lengthChange: true,
        pageLength: 10,
        responsive: true,
        searchHighlight: true,   // ⭐ IMPORTANT
        language: {
            search: "Search:",
            lengthMenu: "Show _MENU_ entries",
            info: "Showing _START_ to _END_ of _TOTAL_ records",
            paginate: {
                previous: "Prev",
                next: "Next"
            }
        }
    });

    // Highlight refresh on every search
    table.on('draw', function () {
        var body = $(table.table().body());
        body.unhighlight();
        body.highlight(table.search());
    });
});
</script>


</html>