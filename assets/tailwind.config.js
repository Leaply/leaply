const defaultTheme = require("tailwindcss/defaultTheme")

module.exports = {
  purge: [],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Encode Sans", ...defaultTheme.fontFamily.sans]
      },
    },
  },
  variants: {
    backgroundColor: ['dark', 'dark-hover', 'dark-group-hover', 'dark-even', 'dark-odd'],
    borderColor: ['dark', 'dark-disabled', 'dark-focus', 'dark-focus-within'],
    textColor: ['dark', 'dark-hover', 'dark-active', 'dark-placeholder'],
  },
  plugins: [
    require('@tailwindcss/ui'),
    require('tailwindcss-dark-mode')(),
  ],
  future: {
    removeDeprecatedGapUtilities: true,
  },
}
