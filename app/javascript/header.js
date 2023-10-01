
const menuBtn = document.getElementById('menuBtn');
const sideNav = document.getElementById('sideNav');

menuBtn.addEventListener('click', () => {
  sideNav.classList.toggle('hidden');
});

document.addEventListener('DOMContentLoaded', function() {
  const currentPath = window.location.pathname;
  if (currentPath === '/' || currentPath === '') {
    const navSelected = document.getElementById("home");
    navSelected.classList.remove("text-gray-500");
    navSelected.classList.add("bg-blue-500", "text-white");
  }
  else if (currentPath === '/daily_report' || currentPath === '/daily_report_medicine' || currentPath === '/daily_report_medical_supply') {
    const navSelected = document.getElementById("dailyreport");
    navSelected.classList.remove("text-gray-500");
    navSelected.classList.add("bg-blue-500", "text-white");
  }
  else if (currentPath === '/medical_supplies' || currentPath === '/medical_supplies/critical') {
    const navSelected = document.getElementById("medical_supplies");
    navSelected.classList.remove("text-gray-500");
    navSelected.classList.add("bg-blue-500", "text-white");
  }
  else if (currentPath === '/export_reports') {
    const navSelected = document.getElementById("export_reports");
    navSelected.classList.remove("text-gray-500");
    navSelected.classList.add("bg-blue-500", "text-white");
  }
  else if (currentPath === '/medicines' || currentPath === '/medicines/critical') {
    const navSelected = document.getElementById("medicines");
    navSelected.classList.remove("text-gray-500");
    navSelected.classList.add("bg-blue-500", "text-white");
  }

  else if (currentPath === '/new') {
    const navSelected = document.getElementById("new_supply");
    navSelected.classList.remove("text-gray-500");
    navSelected.classList.add("bg-blue-500", "text-white");
  }
});