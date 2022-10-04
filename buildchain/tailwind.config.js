// module exports
module.exports = {
  content: [
    '../cms/config/designtokens/**/*.json',
    '../cms/templates/**/*.{twig,html}',
    '../src/vue/**/*.{vue,html}',
    '../src/css/components/**/*.pcss'
  ],
  theme: {
    container: {
      center: true,
      padding: {
        DEFAULT: '1rem',
        sm: '2rem',
        lg: '4rem',
        xl: '5rem',
        '2xl': '6rem',
      }
    },
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