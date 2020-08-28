const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  purge: [],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter", ...defaultTheme.fontFamily.sans],
      },
    },
  },
  variants: {
    backgroundColor: [
      "hover",
      "group-hover",
      "even",
      "odd",
      "dark",
      "dark-hover",
      "dark-group-hover",
      "dark-even",
      "dark-odd",
    ],
    borderColor: [
      "disabled",
      "focus",
      "focus-within",
      "dark",
      "dark-disabled",
      "dark-focus",
      "dark-focus-within",
    ],
    textColor: [
      "hover",
      "active",
      "dark",
      "dark-hover",
      "dark-active",
      "dark-placeholder",
    ],
  },
  plugins: [require("@tailwindcss/ui"), require("tailwindcss-dark-mode")()],
  future: {
    removeDeprecatedGapUtilities: true,
  },
};
