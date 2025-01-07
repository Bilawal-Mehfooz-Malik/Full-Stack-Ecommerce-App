module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    "eslint:recommended",
    "plugin:import/errors",
    "plugin:import/warnings",
    "plugin:import/typescript",
    "google",
    "plugin:@typescript-eslint/recommended",
  ],
  parser: "@typescript-eslint/parser",
  parserOptions: {
    project: ["tsconfig.json", "tsconfig.dev.json"],
    sourceType: "module",
    tsconfigRootDir: __dirname,
  },
  ignorePatterns: [
    "/lib/**/*", // Ignore built files.
    "/generated/**/*", // Ignore generated files.
  ],
  plugins: [
    "@typescript-eslint",
    "import",
  ],
  rules: {
    "quotes": ["error", "double"], // Enforces the use of double quotes.
    "import/no-unresolved": 0, // Disables unresolved import warnings.
    "indent": ["off"], // Turns off indentation enforcement.
    "semi": ["off"], // Disables semicolon enforcement.
    "require-jsdoc": ["off"], // Disables JSDoc comment enforcement.
    "object-curly-spacing": ["off"], // Disables object literal spacing enforcement.
    "spaced-comment": ["off"], // Turns off comment spacing enforcement.
    "max-len": [
      "error",
      {
        "code": 140, // Sets maximum line length to 140 characters.
      },
    ],
    "@typescript-eslint/no-unused-vars": ["off"], // Disables the unused variables rule.
    "no-trailing-spaces": ["off"],
    "linebreak-style": ["off"],
  },
};
