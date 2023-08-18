// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails


var usersChart = new Chart(document.getElementById('usersChart'), {
  type: 'doughnut',
  data: {
      labels: ['Resolved', 'Open Incidents'],
      datasets: [{
          data: [30, 65],
          backgroundColor: ['#f59e0c', '#8B8B8D'],
      }]
  },
  options: {
      responsive: true,
      maintainAspectRatio: false,
      legend: {
          position: 'bottom'
      }
  }
});

const menuBtn = document.getElementById('menuBtn');
const sideNav = document.getElementById('sideNav');

menuBtn.addEventListener('click', () => {
  sideNav.classList.toggle('hidden');
});

document.addEventListener('DOMContentLoaded', function() {
  const currentPath = window.location.pathname;
  if (currentPath === '/') {
    const navSelected = document.getElementById("home");
    navSelected.classList.remove("text-gray-500");
    navSelected.classList.add("bg-yellow-500", "text-white");
  }
  if (currentPath === '/open_incidents') {
    const navSelected = document.getElementById("incidents");
    navSelected.classList.remove("text-gray-500");
    navSelected.classList.add("bg-yellow-500", "text-white");
  }
  if (currentPath === '/resolved_incidents') {
    const navSelected = document.getElementById("resolved");
    navSelected.classList.remove("text-gray-500");
    navSelected.classList.add("bg-yellow-500", "text-white");
  }
  if (currentPath === '/lists') {
    const navSelected = document.getElementById("history");
    navSelected.classList.remove("text-gray-500");
    navSelected.classList.add("bg-yellow-500", "text-white");
  }
});
