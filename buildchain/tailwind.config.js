// module exports
module.exports = {
  content: [
    '../cms/templates/**/*.{twig,html}',
    '../src/vue/**/*.{vue,html}',
    '../src/css/components/**/*.pcss',
  ],
  theme: {
    extend: {
      colors: {
        // 'grey': '#eeeeee',
        // 'blue': '#1d70b8'
      },

      typography: (theme) => ({
        DEFAULT: {
          css: {
            maxWidth: '100%'
          },
        },
      }),
    }
  },
  plugins: [
    require('@tailwindcss/typography'),
    // ...
  ],
};