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
      // ここから新しいユーティリティを追加
      perspective: {
        none: 'none',
        1000: '1000px',
      },
      backfaceVisibility: {
        hidden: 'hidden',
      },
      rotate: {
        0: '0',
        '-180': '-180deg',
        180: '180deg',
      },
      // ここまで
    },
  },
  variants: {},
  plugins: [
    function ({ addUtilities }) {
      const newUtilities = {
        '.perspective': {
          perspective: '1000px',
        },
        '.card-face': {
          backfaceVisibility: 'hidden',
        },
        '.card-front': {
          transform: 'rotateY(0deg)',
        },
        '.card-back': {
          transform: 'rotateY(-180deg)',
        },
        '.flip .card-front': {
          transform: 'rotateY(180deg)',
        },
        '.flip .card-back': {
          transform: 'rotateY(0deg)',
        },
      };
      addUtilities(newUtilities, ['responsive', 'hover']);
    },
    // 既存のdaisyuiプラグインもここに維持
    require('daisyui'),
  ],
};
