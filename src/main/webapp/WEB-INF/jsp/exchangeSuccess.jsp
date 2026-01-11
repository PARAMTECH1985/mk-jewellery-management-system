<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Exchange Success</title>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
body{
    margin:0;
    font-family: "Segoe UI", Arial, sans-serif;
    background: linear-gradient(135deg,#eef1f6,#f8fbff);
}

/* Center wrapper */
.wrapper{
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 30px;
}

/* Card */
.box{
    width: 520px;
    background: rgba(255,255,255,0.95);
    border-radius: 16px;
    padding: 38px 34px;
    text-align: center;
    box-shadow: 0 18px 45px rgba(0,0,0,0.12);
    position: relative;
    overflow: hidden;
}

/* Top gradient bar */
.box::before{
    content:"";
    position:absolute;
    top:0;
    left:0;
    width:100%;
    height:7px;
    background: linear-gradient(90deg,#2e7d32,#43a047,#66bb6a);
}

/* Success circle icon */
.success-icon{
    width: 86px;
    height: 86px;
    margin: 0 auto 18px;
    border-radius: 50%;
    display:flex;
    align-items:center;
    justify-content:center;
    background: linear-gradient(135deg,#43a047,#2e7d32);
    box-shadow: 0 12px 28px rgba(67,160,71,0.35);
    color: #fff;
    font-size: 42px;
}

h2{
    font-size: 22px;
    margin: 0;
    color: #1f2937;
    font-weight: 700;
}

p{
    margin: 12px 0 0;
    color:#5b6472;
    font-size: 14px;
    line-height: 1.6;
}

/* Highlight info box */
.info{
    margin: 18px auto 0;
    padding: 12px 14px;
    background: #f0fff3;
    border: 1px solid #b7f0c2;
    border-radius: 12px;
    color:#256029;
    font-size: 13px;
}

/* Button row */
.btn-row{
    margin-top: 22px;
    display:flex;
    gap: 12px;
    justify-content: center;
    flex-wrap: wrap;
}

.btn{
    display: inline-block;
    padding: 11px 20px;
    border-radius: 10px;
    font-size: 14px;
    text-decoration: none;
    font-weight: 600;
    transition: 0.25s;
    cursor: pointer;
}

/* Primary */
.btn.primary{
    background: linear-gradient(135deg,#43a047,#2e7d32);
    color: #fff;
    box-shadow: 0 12px 28px rgba(67,160,71,0.25);
}
.btn.primary:hover{
    transform: translateY(-1px);
    box-shadow: 0 16px 35px rgba(67,160,71,0.33);
}

/* Secondary */
.btn.secondary{
    background: #ffffff;
    color: #2e7d32;
    border: 1px solid #cfe6d1;
}
.btn.secondary:hover{
    background:#f5fff6;
}

/* Footer note */
.note{
    margin-top: 18px;
    font-size: 12px;
    color:#8a94a6;
}
</style>
</head>

<body>

<div class="wrapper">

    <div class="box">
        <div class="success-icon">✓</div>

        <h2>Exchange Saved Successfully ✅</h2>
        <p>Your exchange / buyback entry has been saved in the system.</p>

        <div class="info">
            ✅ You can now view the updated bill record from the bill list.
        </div>

        <div class="btn-row">
            <a class="btn primary" href="${pageContext.request.contextPath}/bill-list">
                Go to Bill List
            </a>

            <a class="btn secondary" href="${pageContext.request.contextPath}/index">
                Make New Bill
            </a>
            
             <a class="btn secondary" href="${pageContext.request.contextPath}/Mainindex">
               Home
            </a>
            
        </div>

        <div class="note">
            Thank you! Keep your records updated for accurate billing.
        </div>
    </div>

</div>


<!-- ✅ SweetAlert Popup -->
<c:if test="${param.success == '1' && not empty successMsg}">
<script>
Swal.fire({
    icon: "success",
    title: "Success ✅",
    text: "${successMsg}",
    confirmButtonText: "OK",
    timer: 2500,
    timerProgressBar: true
});

// ✅ URL se success=1 remove (refresh pe dubara popup na aaye)
if (window.location.search.includes("success=1")) {
    const cleanUrl = window.location.origin + window.location.pathname;
    window.history.replaceState({}, document.title, cleanUrl);
}
</script>
</c:if>

</body>
</html>
