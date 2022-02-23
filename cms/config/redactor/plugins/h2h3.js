(function($R)
{
   $R.add('plugin', 'h2h3', {
        init: function(app)
        {
            this.app     = app;
            this.block   = app.block;
            this.toolbar = app.toolbar;
            this.editor  = app.editor;
            this.source  = app.source;
        },
        start: function()
        {
            // add the button to the toolbar
            this.toolbar.addButtonBefore('bold', 'h2button', {
                title: 'H2',
                api: 'plugin.h2h3.toggleh2'
            });

            // add the button to the toolbar
            this.toolbar.addButtonBefore('bold', 'h3button', {
                title: 'H3',
                api: 'plugin.h2h3.toggleh3'
            });
        },
        toggleh2: function()
        {
            this.block.format('h2')
            this.toolbar.getButton('h2button').setActive()
        },
        toggleh3: function()
        {
            this.block.format('h3')
            this.toolbar.getButton('h3button').setActive()
        }
    });
})(Redactor);