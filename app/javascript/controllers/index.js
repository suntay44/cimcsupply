// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)

document.addEventListener('DOMContentLoaded', function() {
  function expandSidebar() {
      const sidebar = document.getElementById('sidebar');
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

      const labels = sidebar.querySelectorAll('span');
      labels.forEach(label => label.classList.toggle('opacity-0'));
  }

  function highlightSidebarItem(element) {
      const buttons = document.querySelectorAll("#sidebar button");
      buttons.forEach(btn => {
          btn.classList.remove('bg-gradient-to-r', 'from-cyan-400', 'to-cyan-500', 'text-white', 'w-48', 'ml-0');
          btn.firstChild.nextSibling.classList.remove('text-white');
      });
      element.classList.add('bg-gradient-to-r', 'from-cyan-400', 'to-cyan-500', 'w-56', 'h-10','ml-0');
      element.firstChild.nextSibling.classList.add('text-white');
  }
});