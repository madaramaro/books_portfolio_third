const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
  ],
  plugins: [require('daisyui')],

  daisyui: {
    themes: ['retro'],
  },

  theme: {
    extend: {
      fontFamily: {
        sans: ['Zen Kurenaido', ...defaultTheme.fontFamily.sans],
      },
    },
  },
};
