<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Bill Search & Download</title>

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: "Segoe UI", Arial, sans-serif;
        background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .bill-search-card {
        background: rgba(255, 255, 255, 0.95);
        width: 360px;
        padding: 25px 30px;
        border-radius: 12px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.25);
    }

    .bill-search-card h2 {
        margin: 0 0 20px;
        text-align: center;
        color: #1f2937;
        font-size: 20px;
        letter-spacing: 0.5px;
    }

    table.no-border {
        width: 100%;
        border-collapse: collapse;
    }

    table.no-border td {
        border: none;
        padding: 6px 0;
        font-size: 14px;
        color: #374151;
    }

    input[type="text"] {
        width: 100%;
        padding: 10px;
        font-size: 14px;
        border-radius: 8px;
        border: 1px solid #cbd5e1;
        outline: none;
        transition: border 0.3s, box-shadow 0.3s;
    }

    input[type="text"]:focus {
        border-color: #2563eb;
        box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.15);
    }

    .btn-print {
        width: 100%;
        margin-top: 10px;
        padding: 10px;
        border: none;
        border-radius: 20px;
        background: linear-gradient(135deg, #10b981, #2563eb);
        color: #fff;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: transform 0.2s, box-shadow 0.2s;
    }

    .btn-print:hover {
        transform: translateY(-1px);
        box-shadow: 0 8px 18px rgba(0,0,0,0.25);
    }

    .note {
        margin-top: 12px;
        font-size: 12px;
        text-align: center;
        color: #6b7280;
    }
</style>

<script>
    function validateBillNo(input) {
        input.value = input.value.replace(/[^0-9]/g, '');
    }

    function checkBillNo() {
        var billNo = document.getElementById("billNo").value.trim();
        if (billNo.length === 0) {
            alert("Please enter Bill No");
            return false;
        }
        return true;
    }
</script>

</head>

<body>

<div class="bill-search-card">
    <h2>Download Bill</h2>

    <!-- Right-side Bill Search + Print Section -->
    <table class="no-border">
        <tr>
            <td><b>Enter Bill No:</b></td>
        </tr>
        <tr>
            <td>
                <form action="bills" onsubmit="return checkBillNo()" method="get">
                    <input type="text"
                           id="billNo"
                           name="billNo"
                           placeholder="Enter Bill No"
                           maxlength="4"
                           oninput="validateBillNo(this)"
                           required>
                    <button type="submit" class="btn-print">
                        Download Bill (PDF)
                    </button>
                </form>
            </td>
        </tr>
    </table>

    <div class="note">
        Enter a valid bill number to download the invoice.
    </div>
</div>

</body>
</html>
