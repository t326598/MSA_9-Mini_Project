/**
 * 헤더, 푸터 삽입
 */

document.addEventListener('DOMContentLoaded', function() {
    // Header 삽입
    fetch('layout/header.jsp')
        .then(response => response.text())
        .then(data => {
            document.getElementById('header').innerHTML = data;
        });
    
    // Footer 삽입
    fetch('layout/footer.jsp')
        .then(response => response.text())
        .then(data => {
            document.getElementById('footer').innerHTML = data;
        });
});