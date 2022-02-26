//Based on https://www.jackbarber.co.uk/blog/2019-04-26-email-address-plugin-for-redactor with small improvements
(function (t) {
    t.add('plugin', 'email', {
      modals: {
        // this is variable with modal HTML body
        'emailmodal': '<form action=""></form>'
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
          open: function (modal, form) {
            this.$modal = modal;
            this.$form = form;
            this._setup();
          },

          insert: function ($modal, $form) {
            var data = $form.getData();
            this._insert(data);
          }
        }
      },
      start: function () {
            var button   = this.app.toolbar.getButton('link'),
                dropdown = button.getDropdown(),
                items    = dropdown.items,
                newList  = {
                    liststyle: {
                        title: this.lang.get('email'),
                        api: 'plugin.email.open'
                    }
                };

            button.setDropdown($.extend(items, newList));
      },

      _setup: function () {

        if (0 === (e = this.$modal.find("#redactor-email-insert")).length) {
            
            var n = this.$modal.getBody();
            fi = t.dom('<div class="form-item" id="redactor-email-insert" />');
            lb = t.dom('<label>Email Address</label>');
            se = t.dom('<input type="email" name="emailaddress">');
            fi.append(lb).append(se);
            n.children().first().append(fi);

            var sel = this.app.selection.get();
            let linkText = sel ?? 'Email us';
            fi = t.dom('<div class="form-item" />');
            lb = t.dom('<label>Link text</label>');
            se = t.dom('<input type="text" name="anchortext" value="' + linkText + '">');
            fi.append(lb).append(se);
            n.children().first().append(fi);
        }
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


  