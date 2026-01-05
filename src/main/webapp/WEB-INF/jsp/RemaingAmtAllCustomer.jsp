<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">


<!DOCTYPE html>
<html>
<head>
<title>Bill List</title>

<style>
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
</style>
</head>

<body>



<c:if test="${not empty msg}">
    <p style="color: green">${msg}</p>
</c:if>
<div class="container mt-4">
    <h3 class="text-center mb-3">Pending Amount – Customer List</h3>

    <table class="table table-bordered table-striped table-hover">
        <thead class="table-dark">
            <tr>
                <th>#</th>
                <th>Customer Name</th>
                <th>Bill No</th>
                <th>Total Amount</th>
				<th>Deposited Amount</th>
                <th>Pendinging Amount</th>
                <th>Date</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="bill" items="${bills}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${bill.customerName}</td>
					
                    <td>
						 <a href="${pageContext.request.contextPath}/depositAmount/${bill.id}">
						${bill.billNo}
					</td>
					
                    <td>₹ ${bill.totalAmount}</td>
					<td class="text-success fw-bold">
					                       ₹ ${bill.depositAmount}
					                   </td>
                    <td class="text-danger fw-bold">
                        ₹ ${bill.pendingAmount}
                    </td>
                    <td>
                        <fmt:formatDate value="${bill.date}" pattern="dd-MM-yyyy"/>
                    </td>
                </tr>
            </c:forEach>

            <c:if test="${empty bills}">
                <tr>
                    <td colspan="6" class="text-center text-danger">
                        No Data Found
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>
<br>
<a href="${pageContext.request.contextPath}/">➕ Add New Bill</a>

</body>
</html>
