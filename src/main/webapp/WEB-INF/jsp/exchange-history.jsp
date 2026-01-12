<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Old Item Exchange & Buyback</title>

<style>
    body{
        margin:0;
        padding:0;
        font-family: "Segoe UI", Arial, sans-serif;
        background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
        min-height: 100vh;
        padding: 25px 20px;
        color: #111827;
    }

    .page-wrap{
        max-width: 1300px;
        margin: 0 auto;
    }

    .title-card{
        background: rgba(255,255,255,0.95);
        border-radius: 14px;
        padding: 18px 22px;
        box-shadow: 0 14px 40px rgba(0,0,0,0.25);
        margin-bottom: 18px;
        display:flex;
        align-items:center;
        justify-content: space-between;
        gap: 15px;
        flex-wrap: wrap;
    }

    .title-card h2{
        margin:0;
        font-size: 20px;
        font-weight: 700;
        letter-spacing: 0.4px;
        color: #0f172a;
    }

    .right-tools{
        display:flex;
        align-items:center;
        gap: 12px;
        flex-wrap: wrap;
        justify-content: flex-end;
    }

    .bill-chip{
        display:inline-flex;
        align-items:center;
        gap: 8px;
        background: #111827;
        color:#fff;
        padding: 8px 14px;
        border-radius: 999px;
        font-size: 13px;
        font-weight: 600;
        box-shadow: 0 6px 16px rgba(0,0,0,0.2);
    }

    .bill-chip span{
        background: rgba(255,255,255,0.18);
        padding: 4px 10px;
        border-radius: 999px;
        font-weight: 700;
    }

    /*  Back button classy */
    .btn-back{
        border: none;
        cursor: pointer;
        padding: 9px 14px;
        border-radius: 999px;
        font-weight: 700;
        font-size: 13px;
        color: #fff;
        background: linear-gradient(135deg, #f97316, #ef4444);
        box-shadow: 0 10px 20px rgba(0,0,0,0.18);
        transition: transform 0.2s, box-shadow 0.2s;
    }
    .btn-back:hover{
        transform: translateY(-1px);
        box-shadow: 0 14px 24px rgba(0,0,0,0.25);
    }

    .table-card{
        background: rgba(255,255,255,0.95);
        border-radius: 14px;
        padding: 14px;
        box-shadow: 0 14px 40px rgba(0,0,0,0.25);
        overflow: hidden;
    }

    .table-responsive{
        width: 100%;
        overflow-x: auto;
        border-radius: 12px;
    }

    table{
        width: 100%;
        border-collapse: collapse;
        min-width: 1100px;
    }

    thead th{
        position: sticky;
        top: 0;
        z-index: 2;
        background: linear-gradient(135deg, #111827, #334155);
        color:#fff;
        font-weight: 700;
        font-size: 13px;
        padding: 12px 10px;
        border-bottom: 1px solid rgba(255,255,255,0.15);
        text-transform: uppercase;
        letter-spacing: 0.4px;
        white-space: nowrap;
    }

    tbody td{
        padding: 12px 10px;
        border-bottom: 1px solid #e5e7eb;
        font-size: 13.5px;
        color:#111827;
        text-align: center;
        white-space: nowrap;
    }

    tbody tr:nth-child(even){
        background: #f8fafc;
    }

    tbody tr:hover{
        background: #eef2ff;
        transform: scale(1.002);
        transition: 0.15s ease-in-out;
    }

    /* Exchange type badges */
    .badge{
        display:inline-flex;
        align-items:center;
        gap: 6px;
        padding: 6px 10px;
        border-radius: 999px;
        font-size: 12px;
        font-weight: 700;
        letter-spacing: 0.2px;
    }

    .badge-buyback{
        background: rgba(239, 68, 68, 0.12);
        color: #b91c1c;
        border: 1px solid rgba(239,68,68,0.25);
    }

    .badge-exchange{
        background: rgba(16, 185, 129, 0.12);
        color: #047857;
        border: 1px solid rgba(16,185,129,0.25);
    }

    .money{
        font-weight: 800;
        color:#0f172a;
    }

    .empty-row{
        text-align:center;
        color:#dc2626;
        font-weight: 700;
        padding: 16px 10px !important;
        background: rgba(220, 38, 38, 0.06);
    }

    @media(max-width: 520px){
        .title-card h2{ font-size: 18px; }
        .bill-chip{ font-size: 12px; }
    }
</style>

<script>
    function goBack() {
        if (document.referrer) {
            window.history.back();
        } else {
            window.location.href = "Mainindex";
        }
    }
</script>

</head>
<body>

<div class="page-wrap">

    <!--  Title Header Card -->
    <div class="title-card">
        <h2>Old Item Exchange & Buyback</h2>

        <div class="right-tools">
            <!-- Back Button -->
            <button type="button" class="btn-back" onclick="goBack()">⬅ Back</button>

            <%-- <!--  Bill Id chip -->
            <div class="bill-chip">
                Bill ID <span>${billId}</span>
            </div> --%>
        </div>
    </div>

    <!-- Table Card -->
    <div class="table-card">
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>Bill ID</th>
                        <th>Bill No</th>
                        <th>Date</th>
                        <th>Type</th>
                        <th>Old Item</th>
                        <th>Weight</th>
                        <th>Purity</th>
                        <th>Rate</th>
                        <th>Old Value</th>
                        <th>New Item</th>
                        <th>New Value</th>
                        <th>Balance</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="ex" items="${exchanges}">
                        <tr>
                            <td>${ex.billId}</td>
                            <td>${ex.bill.billNo}</td>
                            <td>${ex.exchangeDate}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${ex.exchangeType == 'BUYBACK'}">
                                        <span class="badge badge-buyback">● ${ex.exchangeType}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-exchange">● ${ex.exchangeType}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>${ex.oldDescription}</td>
                            <td>${ex.oldWeight}</td>
                            <td>${ex.oldPurity}</td>
                            <td>${ex.oldRate}</td>
                            <td class="money">${ex.oldValue}</td>
                            <td>${ex.newDescription}</td>
                            <td class="money">${ex.newValue}</td>
                            <td class="money">${ex.balanceAmount}</td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty exchanges}">
                        <tr>
                            <td colspan="12" class="empty-row">
                                No Exchange / Buyback Data Found
                            </td>
                        </tr>
                    </c:if>
                </tbody>

            </table>
        </div>
    </div>

</div>

</body>
</html>
