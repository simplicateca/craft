//Based on https://www.jackbarber.co.uk/blog/2019-04-26-email-address-plugin-for-redactor with small improvements
(function ($R) {
    $R.add('plugin', 'email', {
      modals: {
        // this is variable with modal HTML body
        'emailmodal': '<form action=""><div class="form-item"><label>Email Address</label><input type="text" name="emailaddress"><label>Text</label><input type="text" name="anchortext"></div></form>'
      },
      // set translations
      translations: {
        en: {
          "email": "Email"
        },
      },
      init: function (app) {
        this.app = app;
        this.toolbar = app.toolbar;
        this.insertion = app.insertion;
  
        // define lang service
        this.lang = app.lang;
      },
      // messages
      onmodal: {
        emailmodal: {
          insert: function ($modal, $form) {
            var data = $form.getData();
            this._insert(data);
          }
        }
      },
      start: function () {
        // set up the button with lang variable
        var buttonData = {
          title: this.lang.get('email'),
          api: 'plugin.email.open',
          icon: '<svg viewBox="0 0 382.117 382.117" width="16" height="16" xmlns="http://www.w3.org/2000/svg"><path d="M336.764 45.945H45.354C20.346 45.945 0 65.484 0 89.5v203.117c0 24.016 20.346 43.555 45.354 43.555h291.41c25.008 0 45.353-19.539 45.353-43.555V89.5c0-24.016-20.345-43.555-45.353-43.555zm0 251.775H45.354c-3.676 0-6.9-2.384-6.9-5.103V116.359l131.797 111.27a15.014 15.014 0 009.676 3.538l22.259.001c3.536 0 6.974-1.257 9.677-3.539l131.803-111.274v176.264c-.002 2.717-3.227 5.101-6.902 5.101zM191.059 192.987L62.87 84.397h256.378z"/></svg>'
        };
  
        // add the button to the toolbar
        var $button = this.toolbar.addButton('email', buttonData);
      },
      open: function () {
        var options = {
          title: 'Insert Email Address', // the modal title
          name: 'emailmodal', // the modal variable in modals object
          commands: {
            cancel: { title: 'Cancel' }, // the cancel button in the modal
            insert: { title: 'Insert' }, // the insert button in the modal
          }
        };
  
        // open the modal with API
        this.app.api('module.modal.build', options);
      },
      // private
      _insert: function (data) {
        this.app.api('module.modal.close');
  
        if (data.emailaddress.trim() === '') return;
        var emaillink = '<a href="mailto:' + data.emailaddress + '">' + data.anchortext + '</a>';
        this.insertion.insertHtml(emaillink);
      }
    });
  })(Redactor);