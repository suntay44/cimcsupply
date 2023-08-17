// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

const sidebar = document.getElementById('sidebar');
const labels = sidebar.querySelectorAll('span');
const buttons = sidebar.querySelectorAll('button');
function expandSidebar() {
  const mainContent = document.querySelector('.ml-16');

  if (sidebar.style.width === '16rem') {
      sidebar.style.width = '4rem';
      mainContent.style.marginLeft = '4rem';
      sidebar.classList.remove('text-left', 'px-6');
      sidebar.classList.add('text-center', 'px-0');
  } else {
      sidebar.style.width = '16rem';
      mainContent.style.marginLeft = '16rem';
      sidebar.classList.add('text-left', 'px-6');
      sidebar.classList.remove('text-center', 'px-0');
  }

  labels.forEach(label => label.classList.toggle('opacity-0'));
}

function highlightSidebarItem(element) {
  buttons.forEach(btn => {
      btn.classList.remove('bg-blue-500', 'text-gray-500', 'text-white', 'w-48', 'ml-0');
      btn.firstChild.nextSibling.classList.remove('text-white');
  });
  element.classList.add('bg-blue-500', 'text-white', 'w-56', 'h-10','ml-0');
  element.firstChild.nextSibling.classList.add('text-white');
}

document.addEventListener('DOMContentLoaded', function() {
  const currentPath = window.location.pathname;
  if (currentPath === '/') {
    const homeButton = document.querySelector("#sidebar button:nth-child(1)");
    if (homeButton) {
      highlightSidebarItem(homeButton);
    }
  }
  if (currentPath === '/resolved_incidents') {
    const homeButton = document.querySelector("#sidebar button:nth-child(2)");
    if (homeButton) {
      highlightSidebarItem(homeButton);
    }
  }
  if (currentPath === '/open_incidents') {
    const homeButton = document.querySelector("#sidebar button:nth-child(3)");
    if (homeButton) {
      highlightSidebarItem(homeButton);
    }
  }
  if (currentPath === '/') {
    const homeButton = document.querySelector("#sidebar button:nth-child(1)");
    if (homeButton) {
      highlightSidebarItem(homeButton);
    }
  }
});
