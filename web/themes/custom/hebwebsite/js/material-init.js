(function ($, Drupal) {
  'use strict';

  Drupal.behaviors.materialInit = {
    attach: function (context, settings) {
      // Initialize top app bar
      const topAppBarElement = document.querySelector('.mdc-top-app-bar');
      if (topAppBarElement) {
        const topAppBar = new mdc.topAppBar.MDCTopAppBar(topAppBarElement);
      }

      // Initialize all menus
      const menus = document.querySelectorAll('.mdc-menu', context);
      menus.forEach(menuElement => {
        const menu = new mdc.menu.MDCMenu(menuElement);
        
        // Get the associated button
        const menuButton = menuElement.previousElementSibling;
        if (menuButton) {
          menuButton.addEventListener('click', () => {
            // Close all other menus first
            menus.forEach(m => {
              if (m !== menuElement) {
                mdc.menu.MDCMenu.attachTo(m).open = false;
              }
            });
            menu.open = !menu.open;
            
            // Position the menu relative to the button
            menu.setAnchorCorner(mdc.menu.Corner.BOTTOM_LEFT);
            menu.setAnchorElement(menuButton);
          });
        }
      });

      // Close menus when clicking outside
      $(document).once('click-outside').on('click', (e) => {
        if (!e.target.closest('.mdc-menu') && !e.target.closest('.menu-button')) {
          menus.forEach(menuElement => {
            const menu = mdc.menu.MDCMenu.attachTo(menuElement);
            menu.open = false;
          });
        }
      });

      // Initialize drawer for mobile menu
      const drawerElement = document.querySelector('.mdc-drawer');
      if (drawerElement) {
        const drawer = new mdc.drawer.MDCDrawer(drawerElement);
        
        // Toggle drawer on menu button click
        const menuButton = document.querySelector('.menu-toggle');
        if (menuButton) {
          menuButton.addEventListener('click', () => {
            drawer.open = !drawer.open;
          });
        }
      }

      // Add ripple effect to buttons
      const buttons = document.querySelectorAll('.mdc-button');
      buttons.forEach(button => {
        new mdc.ripple.MDCRipple(button);
      });

      // Initialize language selector menu
      const langSelector = document.querySelector('.language-selector');
      if (langSelector) {
        const langMenu = new mdc.menu.MDCMenu(langSelector.querySelector('.mdc-menu'));
        const langButton = langSelector.querySelector('.lang-button');
        
        if (langButton) {
          langButton.addEventListener('click', () => {
            langMenu.open = !langMenu.open;
            langMenu.setAnchorElement(langButton);
            langMenu.setAnchorCorner(mdc.menu.Corner.BOTTOM_RIGHT);
          });
        }
      }
    }
  };
})(jQuery, Drupal);
